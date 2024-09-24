import 'dart:async';
import 'dart:io';

import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../common/widgets/cart_widget.dart';
import '../../../common/widgets/custom_dialog.dart';
import '../../../helper/auth_helper.dart';
import '../../../helper/responsive_helper.dart';
import '../../../helper/route_helper.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../address/screens/address_screen.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../checkout/widgets/congratulation_dialogue.dart';
import '../../favourite/screens/favourite_screen.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/screens/home_screen.dart';
import '../../location/controllers/location_controller.dart';
import '../../menu/screens/menu_screen.dart';
import '../../order/controllers/order_controller.dart';
import '../../order/domain/models/order_model.dart';
import '../../order/screens/order_screen.dart';
import '../../parcel/controllers/parcel_controller.dart';
import '../../splash/controllers/splash_controller.dart';
import '../../store/controllers/store_controller.dart';
import '../widgets/address_bottom_sheet_widget.dart';
import '../widgets/bottom_nav_item_widget.dart';
import '../widgets/parcel_bottom_sheet_widget.dart';
import '../widgets/running_order_view_widget.dart';
import '../widgets/store_registration_success_bottom_sheet.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  final bool fromSplash;
  const DashboardScreen({super.key, required this.pageIndex, this.fromSplash = false});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  PageController? _pageController;
  int _pageIndex = 0;
  late List<Widget> _screens;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = GetPlatform.isWeb ? true : false;

  GlobalKey<ExpandableBottomSheetState> key = GlobalKey();

  late bool _isLogin;
  bool active = false;

  @override
  void initState() {
    super.initState();

    _isLogin = AuthHelper.isLoggedIn();

    _showRegistrationSuccessBottomSheet();

    if (_isLogin) {
      if (Get.find<SplashController>().configModel!.loyaltyPointStatus == 1 &&
          Get.find<AuthController>().getEarningPint().isNotEmpty &&
          !ResponsiveHelper.isDesktop(Get.context)) {
        Future.delayed(const Duration(seconds: 1), () {
          if (!mounted || !context.mounted) return;
          showAnimatedDialog(context, const CongratulationDialogue());
        });
      }
      suggestAddressBottomSheet();
      Get.find<OrderController>().getRunningOrders(1, fromDashboard: true);
    }

    _pageIndex = widget.pageIndex;

    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [const HomeScreen(), const FavouriteScreen(), const SizedBox(), const OrderScreen(), const MenuScreen()];

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {});
    });
  }

  _showRegistrationSuccessBottomSheet() {
    bool canShowBottomSheet = Get.find<HomeController>().getRegistrationSuccessfulSharedPref();
    if (canShowBottomSheet) {
      Future.delayed(const Duration(seconds: 1), () {
        if (!mounted || !context.mounted) return;
        ResponsiveHelper.isDesktop(context)
            ? Get.dialog(const Dialog(child: StoreRegistrationSuccessBottomSheet())).then((value) {
                Get.find<HomeController>().saveRegistrationSuccessfulSharedPref(false);
                Get.find<HomeController>().saveIsStoreRegistrationSharedPref(false);
                setState(() {});
              })
            : showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (con) => const StoreRegistrationSuccessBottomSheet(),
              ).then((value) {
                Get.find<HomeController>().saveRegistrationSuccessfulSharedPref(false);
                Get.find<HomeController>().saveIsStoreRegistrationSharedPref(false);
                setState(() {});
              });
      });
    }
  }

  Future<void> suggestAddressBottomSheet() async {
    active = await Get.find<LocationController>().checkLocationActive();
    if (widget.fromSplash && Get.find<LocationController>().showLocationSuggestion && active) {
      Future.delayed(const Duration(seconds: 1), () {
        if (!mounted || !context.mounted) return;
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (con) => const AddressBottomSheetWidget(),
        ).then((value) {
          Get.find<LocationController>().hideSuggestedLocation();
          setState(() {});
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    bool keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return GetBuilder<SplashController>(builder: (splashController) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (value, _) async {
          if (_pageIndex != 0) {
            _setPage(0);
          } else {
            if (!ResponsiveHelper.isDesktop(context) &&
                Get.find<SplashController>().module != null &&
                Get.find<SplashController>().configModel!.module == null) {
              Get.find<SplashController>().setModule(null);
              Get.find<StoreController>().resetStoreData();
            } else {
              if (_canExit) {
                if (GetPlatform.isAndroid) {
                  SystemNavigator.pop();
                } else if (GetPlatform.isIOS) {
                  exit(0);
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('back_press_again_to_exit'.tr, style: const TextStyle(color: Colors.white)),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                  margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                ));
                _canExit = true;
                Timer(const Duration(seconds: 2), () {
                  _canExit = false;
                });
              }
            }
          }
        },
        child: GetBuilder<OrderController>(builder: (orderController) {
          List<OrderModel> runningOrder = orderController.runningOrderModel != null ? orderController.runningOrderModel!.orders! : [];

          List<OrderModel> reversOrder = List.from(runningOrder.reversed);

          return Scaffold(
            key: _scaffoldKey,
            body: ExpandableBottomSheet(
              background: Stack(children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: _screens.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _screens[index];
                  },
                ),
                ResponsiveHelper.isDesktop(context) || keyboardVisible
                    ? const SizedBox()
                    : Align(
                        alignment: Alignment.bottomCenter,
                        child: GetBuilder<SplashController>(builder: (splashController) {
                          bool isParcel = splashController.module != null && splashController.configModel!.moduleConfig!.module!.isParcel!;

                          _screens = [
                            const HomeScreen(),
                            isParcel ? const AddressScreen(fromDashboard: true) : const FavouriteScreen(),
                            const SizedBox(),
                            const OrderScreen(),
                            const MenuScreen()
                          ];
                          return Container(
                            width: size.width,
                            height: 65 + MediaQuery.viewPaddingOf(context).bottom,
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.viewPaddingOf(context).bottom,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusLarge)),
                              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  top: -15,
                                  child: Center(
                                    heightFactor: 0.6,
                                    child: ResponsiveHelper.isDesktop(context)
                                        ? null
                                        : (widget.fromSplash && Get.find<LocationController>().showLocationSuggestion && active)
                                            ? null
                                            : (orderController.showBottomSheet &&
                                                    orderController.runningOrderModel != null &&
                                                    orderController.runningOrderModel!.orders!.isNotEmpty &&
                                                    _isLogin)
                                                ? const SizedBox()
                                                : Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: Theme.of(context).cardColor, width: 5),
                                                      borderRadius: BorderRadius.circular(30),
                                                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
                                                    ),
                                                    child: FloatingActionButton(
                                                      backgroundColor: Theme.of(context).primaryColor,
                                                      onPressed: () {
                                                        if (isParcel) {
                                                          showModalBottomSheet(
                                                            context: context,
                                                            isScrollControlled: true,
                                                            backgroundColor: Colors.transparent,
                                                            builder: (con) =>
                                                                ParcelBottomSheetWidget(parcelCategoryList: Get.find<ParcelController>().parcelCategoryList),
                                                          );
                                                        } else {
                                                          Get.toNamed(RouteHelper.getCartRoute());
                                                        }
                                                      },
                                                      elevation: 0,
                                                      child: isParcel
                                                          ? Icon(CupertinoIcons.add, size: 34, color: Theme.of(context).cardColor)
                                                          : CartWidget(color: Theme.of(context).cardColor, size: 22),
                                                    ),
                                                  ),
                                  ),
                                ),
                                ResponsiveHelper.isDesktop(context)
                                    ? const SizedBox()
                                    : (widget.fromSplash && Get.find<LocationController>().showLocationSuggestion && active)
                                        ? const SizedBox()
                                        : (orderController.showBottomSheet &&
                                                orderController.runningOrderModel != null &&
                                                orderController.runningOrderModel!.orders!.isNotEmpty &&
                                                _isLogin)
                                            ? const SizedBox()
                                            : Center(
                                                child: SizedBox(
                                                  width: size.width,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      BottomNavItemWidget(
                                                        title: 'home'.tr,
                                                        selectedIcon: Images.homeSelect,
                                                        unSelectedIcon: Images.homeUnselect,
                                                        isSelected: _pageIndex == 0,
                                                        onTap: () => _setPage(0),
                                                      ),
                                                      BottomNavItemWidget(
                                                        title: isParcel ? 'address'.tr : 'favourite'.tr,
                                                        selectedIcon: isParcel ? Images.addressSelect : Images.favouriteSelect,
                                                        unSelectedIcon: isParcel ? Images.addressUnselect : Images.favouriteUnselect,
                                                        isSelected: _pageIndex == 1,
                                                        onTap: () => _setPage(1),
                                                      ),
                                                      Container(width: size.width * 0.2),
                                                      BottomNavItemWidget(
                                                        title: 'orders'.tr,
                                                        selectedIcon: Images.orderSelect,
                                                        unSelectedIcon: Images.orderUnselect,
                                                        isSelected: _pageIndex == 3,
                                                        onTap: () => _setPage(3),
                                                      ),
                                                      BottomNavItemWidget(
                                                        title: 'menu'.tr,
                                                        selectedIcon: Images.menu,
                                                        unSelectedIcon: Images.menu,
                                                        isSelected: _pageIndex == 4,
                                                        onTap: () => _setPage(4),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                              ],
                            ),
                          );
                        }),
                      ),
              ]),
              persistentContentHeight: (widget.fromSplash && Get.find<LocationController>().showLocationSuggestion && active)
                  ? 0
                  : GetPlatform.isIOS
                      ? 110
                      : 100,
              onIsContractedCallback: () {
                if (!orderController.showOneOrder) {
                  orderController.showOrders();
                }
              },
              onIsExtendedCallback: () {
                if (orderController.showOneOrder) {
                  orderController.showOrders();
                }
              },
              enableToggle: true,
              expandableContent: (widget.fromSplash && Get.find<LocationController>().showLocationSuggestion && active && !ResponsiveHelper.isDesktop(context))
                  ? const SizedBox()
                  : (ResponsiveHelper.isDesktop(context) ||
                          !_isLogin ||
                          orderController.runningOrderModel == null ||
                          orderController.runningOrderModel!.orders!.isEmpty ||
                          !orderController.showBottomSheet)
                      ? const SizedBox()
                      : Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            if (orderController.showBottomSheet) {
                              orderController.showRunningOrders();
                            }
                          },
                          child: RunningOrderViewWidget(
                              reversOrder: reversOrder,
                              onOrderTap: () {
                                _setPage(3);
                                if (orderController.showBottomSheet) {
                                  orderController.showRunningOrders();
                                }
                              }),
                        ),
            ),
          );
        }),
      );
    });
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController!.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }

  Widget trackView(BuildContext context, {required bool status}) {
    return Container(
        height: 3,
        decoration: BoxDecoration(
            color: status ? Theme.of(context).primaryColor : Theme.of(context).disabledColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault)));
  }
}
