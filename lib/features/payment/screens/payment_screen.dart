// import 'dart:async';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:get/get.dart';
// import 'package:user_app_web/common/widgets/custom_app_bar.dart';
// import 'package:user_app_web/features/checkout/widgets/payment_failed_dialog.dart';
// import 'package:user_app_web/features/location/domain/models/zone_response_model.dart';
// import 'package:user_app_web/features/order/controllers/order_controller.dart';
import 'package:user_app_web/features/order/domain/models/order_model.dart';
// import 'package:user_app_web/features/splash/controllers/splash_controller.dart';
// import 'package:user_app_web/features/wallet/widgets/fund_payment_dialog_widget.dart';
// import 'package:user_app_web/helper/address_helper.dart';
// import 'package:user_app_web/util/app_constants.dart';
// import 'package:user_app_web/util/dimensions.dart';

class PaymentScreen extends StatefulWidget {
  final OrderModel orderModel;
  final bool isCashOnDelivery;
  final String? addFundUrl;
  final String paymentMethod;
  final String guestId;
  final String contactNumber;
  final String? subscriptionUrl;
  final int? storeId;
  final bool createAccount;
  final int? createUserId;
  const PaymentScreen(
      {super.key,
      required this.orderModel,
      required this.isCashOnDelivery,
      this.addFundUrl,
      required this.paymentMethod,
      required this.guestId,
      required this.contactNumber,
      this.storeId,
      this.subscriptionUrl,
      this.createAccount = false,
      this.createUserId});

  @override
  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {
//   late String selectedUrl;
//   double value = 0.0;
//   final bool _isLoading = true;
//   PullToRefreshController? pullToRefreshController;
//   late MyInAppBrowser browser;
//   double? _maximumCodOrderAmount;

//   @override
//   void initState() {
//     super.initState();

//     if (widget.addFundUrl == '' && widget.addFundUrl!.isEmpty && widget.subscriptionUrl == '' && widget.subscriptionUrl!.isEmpty) {
//       selectedUrl =
//           '${AppConstants.baseUrl}/payment-mobile?customer_id=${widget.createAccount ? widget.createUserId : widget.orderModel.userId == 0 ? widget.guestId : widget.orderModel.userId}&order_id=${widget.orderModel.id}&payment_method=${widget.paymentMethod}';
//     } else if (widget.subscriptionUrl != '' && widget.subscriptionUrl!.isNotEmpty) {
//       selectedUrl = widget.subscriptionUrl!;
//     } else {
//       selectedUrl = widget.addFundUrl!;
//     }

//     if (kDebugMode) {
//       log('==========url=======> $selectedUrl');
//     }

//     _initData();
//   }

//   void _initData() async {
//     if (widget.addFundUrl == '' && widget.addFundUrl!.isEmpty && widget.subscriptionUrl == '' && widget.subscriptionUrl!.isEmpty) {
//       for (ZoneData zData in AddressHelper.getUserAddressFromSharedPref()!.zoneData!) {
//         for (Modules m in zData.modules!) {
//           if (m.id == Get.find<SplashController>().module!.id) {
//             _maximumCodOrderAmount = m.pivot!.maximumCodOrderAmount;
//             break;
//           }
//         }
//       }
//     }

//     browser = MyInAppBrowser(
//       orderID: widget.orderModel.id.toString(),
//       orderType: widget.orderModel.orderType,
//       orderAmount: widget.orderModel.orderAmount,
//       maxCodOrderAmount: _maximumCodOrderAmount,
//       isCashOnDelivery: widget.isCashOnDelivery,
//       addFundUrl: widget.addFundUrl,
//       contactNumber: widget.contactNumber,
//       storeId: widget.storeId,
//       subscriptionUrl: widget.subscriptionUrl,
//       createAccount: widget.createAccount,
//       guestId: widget.guestId,
//     );

//     if (!GetPlatform.isIOS) {
//       await InAppWebViewController.setWebContentsDebuggingEnabled(true);
//     }

//     var options = InAppBrowserClassSettings(
//       browserSettings: InAppBrowserSettings(hideUrlBar: true, hideToolbarTop: GetPlatform.isAndroid),
//       webViewSettings: InAppWebViewSettings(useShouldOverrideUrlLoading: true, useOnLoadResource: true, javaScriptEnabled: true),
//     );

//     await browser.openUrlRequest(
//       urlRequest: URLRequest(url: WebUri.uri(Uri.parse(selectedUrl))),
//       settings: options,
//     );
//   }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
//     return PopScope(
//       canPop: false,
//       onPopInvokedWithResult: (val, _) {
//         _exitApp().then((value) => value!);
//       },
//       child: Scaffold(
//         backgroundColor: Theme.of(context).primaryColor,
//         appBar: CustomAppBar(title: 'payment'.tr, onBackPressed: () => _exitApp()),
//         body: Center(
//           child: SizedBox(
//             width: Dimensions.webMaxWidth,
//             child: Stack(
//               children: [
//                 _isLoading
//                     ? Center(
//                         child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
//                       )
//                     : const SizedBox.shrink(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<bool?> _exitApp() async {
//     if ((widget.addFundUrl == null || widget.addFundUrl!.isEmpty) && (widget.subscriptionUrl == '' && widget.subscriptionUrl!.isEmpty)) {
//       return Get.dialog(PaymentFailedDialog(
//         orderID: widget.orderModel.id.toString(),
//         orderAmount: widget.orderModel.orderAmount,
//         maxCodOrderAmount: _maximumCodOrderAmount,
//         orderType: widget.orderModel.orderType,
//         isCashOnDelivery: widget.isCashOnDelivery,
//         guestId: widget.createAccount ? widget.createUserId.toString() : widget.guestId,
//       ));
//     } else {
//       return Get.dialog(FundPaymentDialogWidget(isSubscription: widget.subscriptionUrl != null && widget.subscriptionUrl!.isNotEmpty));
//     }
  }
}

// class MyInAppBrowser extends InAppBrowser {
//   final String orderID;
//   final String? orderType;
//   final double? orderAmount;
//   final double? maxCodOrderAmount;
//   final bool isCashOnDelivery;
//   final String? addFundUrl;
//   final String? subscriptionUrl;
//   final String? contactNumber;
//   final int? storeId;
//   final bool createAccount;
//   final String guestId;

//   MyInAppBrowser({
//     super.windowId,
//     super.initialUserScripts,
//     required this.orderID,
//     required this.orderType,
//     required this.orderAmount,
//     required this.maxCodOrderAmount,
//     required this.isCashOnDelivery,
//     this.addFundUrl,
//     this.subscriptionUrl,
//     this.contactNumber,
//     this.storeId,
//     required this.createAccount,
//     required this.guestId,
//   });

//   final bool _canRedirect = true;

//   @override
//   Future onBrowserCreated() async {
//     if (kDebugMode) {
//       log("\n\nBrowser Created!\n\n");
//     }
//   }

//   @override
//   Future onLoadStart(url) async {
//     if (kDebugMode) {
//       log("\n\nStarted: $url\n\n");
//     }
//     Get.find<OrderController>().paymentRedirect(
//       url: url.toString(),
//       canRedirect: _canRedirect,
//       onClose: () => close(),
//       addFundUrl: addFundUrl,
//       orderID: orderID,
//       contactNumber: contactNumber,
//       storeId: storeId,
//       subscriptionUrl: subscriptionUrl,
//       createAccount: createAccount,
//       guestId: guestId,
//     );
//   }

//   @override
//   Future onLoadStop(url) async {
//     pullToRefreshController?.endRefreshing();
//     if (kDebugMode) {
//       log("\n\nStopped: $url\n\n");
//     }
//     Get.find<OrderController>().paymentRedirect(
//       url: url.toString(),
//       canRedirect: _canRedirect,
//       onClose: () => close(),
//       addFundUrl: addFundUrl,
//       orderID: orderID,
//       contactNumber: contactNumber,
//       storeId: storeId,
//       subscriptionUrl: subscriptionUrl,
//       createAccount: createAccount,
//       guestId: guestId,
//     );
//   }

//   // @override
//   // Future<ServerTrustAuthResponse?>? onReceivedServerTrustAuthRequest(URLAuthenticationChallenge challenge) async {
//   //   if (kDebugMode) {
//   //     log("\n\n onReceivedServerTrustAuthRequest: ${challenge.toString()}\n\n");
//   //   }
//   //   return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
//   // }
//   //
//   // @override
//   // Future<ShouldAllowDeprecatedTLSAction?>? shouldAllowDeprecatedTLS(URLAuthenticationChallenge challenge) async {
//   //   if (kDebugMode) {
//   //     log("\n\n shouldAllowDeprecatedTLS: ${challenge.protectionSpace.host}\n\n");
//   //   }
//   //   return ShouldAllowDeprecatedTLSAction.ALLOW;
//   // }

//   @override
//   void onLoadError(url, code, message) {
//     pullToRefreshController?.endRefreshing();
//     if (kDebugMode) {
//       log("Can't load [$url] Error: $message");
//     }
//   }

//   @override
//   void onProgressChanged(progress) {
//     if (progress == 100) {
//       pullToRefreshController?.endRefreshing();
//     }
//     if (kDebugMode) {
//       log("Progress: $progress");
//     }
//   }

//   @override
//   void onExit() {
//     if (kDebugMode) {
//       log("\n\nBrowser closed!\n\n");
//     }
//   }

//   @override
//   Future<NavigationActionPolicy> shouldOverrideUrlLoading(navigationAction) async {
//     if (kDebugMode) {
//       log("\n\nOverride ${navigationAction.request.url}\n\n");
//     }
//     return NavigationActionPolicy.ALLOW;
//   }

//   @override
//   void onLoadResource(resource) {
//     if (kDebugMode) {
//       log("Started at: ${resource.startTime}ms ---> duration: ${resource.duration}ms ${resource.url ?? ''}");
//     }
//   }

//   @override
//   void onConsoleMessage(consoleMessage) {
//     if (kDebugMode) {
//       log("""
//     console output:
//       message: ${consoleMessage.message}
//       messageLevel: ${consoleMessage.messageLevel.toValue()}
//    """);
//     }
//   }
// }
