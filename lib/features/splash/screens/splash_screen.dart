import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/no_internet_screen.dart';
import '../../../helper/address_helper.dart';
import '../../../helper/auth_helper.dart';
import '../../../helper/route_helper.dart';
import '../../../util/app_constants.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../favourite/controllers/favourite_controller.dart';
import '../../location/controllers/location_controller.dart';
import '../../notification/domain/models/notification_body_model.dart';
import '../controllers/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  final NotificationBodyModel? body;
  const SplashScreen({super.key, required this.body});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  late StreamSubscription<List<ConnectivityResult>> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    bool firstTime = true;
    _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (!firstTime) {
        bool isConnected = !result.contains(ConnectivityResult.none);
        if (!context.mounted || !mounted) return;
        if (isConnected) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: !isConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: !isConnected ? 6000 : 3),
          content: Text(
            !isConnected ? 'no_connection'.tr : 'connected'.tr,
            textAlign: TextAlign.center,
          ),
        ));
        if (isConnected) {
          _route();
        }
      }
      firstTime = false;
    });

    Get.find<SplashController>().initSharedData();
    if ((AuthHelper.getGuestId().isNotEmpty || AuthHelper.isLoggedIn()) && Get.find<SplashController>().cacheModule != null) {
      Get.find<CartController>().getCartDataOnline();
    }
    _route();
  }

  @override
  void dispose() {
    super.dispose();

    _onConnectivityChanged.cancel();
  }

  void _route() {
    Get.find<SplashController>().getConfigData().then((isSuccess) {
      if (isSuccess) {
        Timer(const Duration(seconds: 1), () async {
          double minimumVersion = 0;
          if (GetPlatform.isAndroid) {
            minimumVersion = Get.find<SplashController>().configModel!.appMinimumVersionAndroid ?? 0;
          } else if (GetPlatform.isIOS) {
            minimumVersion = Get.find<SplashController>().configModel!.appMinimumVersionIos ?? 0;
          }
          if (AppConstants.appVersion < minimumVersion || Get.find<SplashController>().configModel!.maintenanceMode!) {
            Get.offNamed(RouteHelper.getUpdateRoute(AppConstants.appVersion < minimumVersion));
          } else {
            if (widget.body != null) {
              _forNotificationRouteProcess();
            } else {
              if (AuthHelper.isLoggedIn()) {
                _forLoggedInUserRouteProcess();
              } else {
                if (Get.find<SplashController>().showIntro()!) {
                  _newlyRegisteredRouteProcess();
                } else {
                  if (AuthHelper.isGuestLoggedIn()) {
                    _forGuestUserRouteProcess();
                  } else {
                    await Get.find<AuthController>().guestLogin();
                    _forGuestUserRouteProcess();
                    // Get.offNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
                  }
                }
              }
            }
          }
        });
      }
    });
  }

  void _forNotificationRouteProcess() {
    if (widget.body!.notificationType == NotificationType.order) {
      Get.offNamed(RouteHelper.getOrderDetailsRoute(widget.body!.orderId, fromNotification: true));
    } else if (widget.body!.notificationType == NotificationType.general) {
      Get.offNamed(RouteHelper.getNotificationRoute(fromNotification: true));
    } else {
      Get.offNamed(RouteHelper.getChatRoute(notificationBody: widget.body, conversationID: widget.body!.conversationId, fromNotification: true));
    }
  }

  Future<void> _forLoggedInUserRouteProcess() async {
    Get.find<AuthController>().updateToken();
    if (AddressHelper.getUserAddressFromSharedPref() != null) {
      if (Get.find<SplashController>().module != null) {
        await Get.find<FavouriteController>().getFavouriteList();
      }
      Get.offNamed(RouteHelper.getInitialRoute(fromSplash: true));
    } else {
      Get.find<LocationController>().navigateToLocationScreen('splash', offNamed: true);
    }
  }

  void _newlyRegisteredRouteProcess() {
    if (AppConstants.languages.length > 1) {
      Get.offNamed(RouteHelper.getLanguageRoute('splash'));
    } else {
      Get.offNamed(RouteHelper.getOnBoardingRoute());
    }
  }

  void _forGuestUserRouteProcess() {
    if (AddressHelper.getUserAddressFromSharedPref() != null) {
      Get.offNamed(RouteHelper.getInitialRoute(fromSplash: true));
    } else {
      Get.find<LocationController>().navigateToLocationScreen('splash', offNamed: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>().initSharedData();
    if (AddressHelper.getUserAddressFromSharedPref() != null && AddressHelper.getUserAddressFromSharedPref()!.zoneIds == null) {
      Get.find<AuthController>().clearSharedAddress();
    }

    return Scaffold(
      key: _globalKey,
      body: GetBuilder<SplashController>(builder: (splashController) {
        return Center(
          child: splashController.hasConnection
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(Images.logo, width: 200),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    // Text(AppConstants.APP_NAME, style: robotoMedium.copyWith(fontSize: 25)),
                  ],
                )
              : NoInternetScreen(child: SplashScreen(body: widget.body)),
        );
      }),
    );
  }
}
