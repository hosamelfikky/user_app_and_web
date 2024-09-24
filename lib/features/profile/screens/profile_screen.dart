import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/controllers/theme_controller.dart';
import '../../../common/widgets/confirmation_dialog.dart';
import '../../../common/widgets/custom_image.dart';
import '../../../common/widgets/footer_view.dart';
import '../../../common/widgets/menu_drawer.dart';
import '../../../common/widgets/web_menu_bar.dart';
import '../../../helper/auth_helper.dart';
import '../../../helper/date_converter.dart';
import '../../../helper/price_converter.dart';
import '../../../helper/responsive_helper.dart';
import '../../../helper/route_helper.dart';
import '../../../util/app_constants.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/styles.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../auth/screens/sign_in_screen.dart';
import '../../splash/controllers/splash_controller.dart';
import '../controllers/profile_controller.dart';
import '../widgets/notification_status_change_bottom_sheet.dart';
import '../widgets/profile_button_widget.dart';
import '../widgets/profile_card_widget.dart';
import '../widgets/web_profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    if (AuthHelper.isLoggedIn() && Get.find<ProfileController>().userInfoModel == null) {
      Get.find<ProfileController>().getUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool showWalletCard =
        Get.find<SplashController>().configModel!.customerWalletStatus == 1 || Get.find<SplashController>().configModel!.loyaltyPointStatus == 1;

    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context) ? const WebMenuBar() : null,
      endDrawer: const MenuDrawer(),
      endDrawerEnableOpenDragGesture: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      key: UniqueKey(),
      body: GetBuilder<ProfileController>(builder: (profileController) {
        bool isLoggedIn = AuthHelper.isLoggedIn();
        return (isLoggedIn && profileController.userInfoModel == null)
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: FooterView(
                  minHeight: isLoggedIn
                      ? ResponsiveHelper.isDesktop(context)
                          ? 0.4
                          : 0.6
                      : 0.35,
                  child: (isLoggedIn && ResponsiveHelper.isDesktop(context))
                      ? const WebProfileWidget()
                      : Container(
                          color: Theme.of(context).primaryColor.withOpacity(0.2),
                          width: Dimensions.webMaxWidth,
                          height: context.height,
                          child: Center(
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeSmall),
                                child: SafeArea(
                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    !ResponsiveHelper.isDesktop(context)
                                        ? IconButton(
                                            onPressed: () => Get.back(),
                                            icon: const Icon(Icons.arrow_back_ios),
                                          )
                                        : const SizedBox(),
                                    Text('profile'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                                    const SizedBox(width: 50),
                                  ]),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: Dimensions.paddingSizeExtremeLarge, right: Dimensions.paddingSizeExtremeLarge, bottom: Dimensions.paddingSizeLarge),
                                child: Row(children: [
                                  ClipOval(
                                      child: CustomImage(
                                    placeholder: Images.guestIcon,
                                    image: '${(profileController.userInfoModel != null && isLoggedIn) ? profileController.userInfoModel!.imageFullUrl : ''}',
                                    height: 70,
                                    width: 70,
                                    fit: BoxFit.cover,
                                  )),
                                  const SizedBox(width: Dimensions.paddingSizeDefault),
                                  Expanded(
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text(
                                        isLoggedIn
                                            ? '${profileController.userInfoModel?.fName} ${profileController.userInfoModel?.lName ?? ''}'
                                            : 'guest_user'.tr,
                                        style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge),
                                      ),
                                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                                      isLoggedIn
                                          ? Text(
                                              '${'joined'.tr} ${DateConverter.containTAndZToUTCFormat(profileController.userInfoModel!.createdAt!)}',
                                              style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                                            )
                                          : InkWell(
                                              onTap: () async {
                                                if (!ResponsiveHelper.isDesktop(context)) {
                                                  await Get.toNamed(RouteHelper.getSignInRoute(Get.currentRoute));
                                                  if (AuthHelper.isLoggedIn()) {
                                                    profileController.getUserInfo();
                                                  }
                                                } else {
                                                  await Get.dialog(const SignInScreen(exitFromApp: true, backFromThis: true));
                                                }
                                              },
                                              child: Text(
                                                'login_to_view_all_feature'.tr,
                                                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                                              ),
                                            ),
                                    ]),
                                  ),
                                  isLoggedIn
                                      ? InkWell(
                                          onTap: () => Get.toNamed(RouteHelper.getUpdateProfileRoute()),
                                          child: Container(
                                            decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).cardColor, boxShadow: [
                                              BoxShadow(
                                                  color: Theme.of(context).primaryColor.withOpacity(0.05),
                                                  blurRadius: 5,
                                                  spreadRadius: 1,
                                                  offset: const Offset(3, 3))
                                            ]),
                                            padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                            child: const Icon(Icons.edit_outlined, size: 24, color: Colors.blue),
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () async {
                                            if (!ResponsiveHelper.isDesktop(context)) {
                                              await Get.toNamed(RouteHelper.getSignInRoute(Get.currentRoute));
                                              if (AuthHelper.isLoggedIn()) {
                                                profileController.getUserInfo();
                                              }
                                            } else {
                                              Get.dialog(const SignInScreen(exitFromApp: true, backFromThis: true));
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                              color: Theme.of(context).primaryColor,
                                            ),
                                            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall, horizontal: Dimensions.paddingSizeLarge),
                                            child: Text(
                                              'login'.tr,
                                              style: robotoMedium.copyWith(color: Theme.of(context).cardColor),
                                            ),
                                          ),
                                        )
                                ]),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusExtraLarge)),
                                      color: Theme.of(context).cardColor),
                                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeDefault),
                                  child: Column(children: [
                                    const SizedBox(height: Dimensions.paddingSizeLarge),
                                    (showWalletCard && isLoggedIn)
                                        ? Row(children: [
                                            Get.find<SplashController>().configModel!.loyaltyPointStatus == 1
                                                ? Expanded(
                                                    child: ProfileCardWidget(
                                                    image: Images.loyaltyIcon,
                                                    data: profileController.userInfoModel!.loyaltyPoint != null
                                                        ? profileController.userInfoModel!.loyaltyPoint.toString()
                                                        : '0',
                                                    title: 'loyalty_points'.tr,
                                                  ))
                                                : const SizedBox(),
                                            SizedBox(
                                                width: Get.find<SplashController>().configModel!.loyaltyPointStatus == 1 ? Dimensions.paddingSizeSmall : 0),
                                            isLoggedIn
                                                ? Expanded(
                                                    child: ProfileCardWidget(
                                                    image: Images.shoppingBagIcon,
                                                    data: profileController.userInfoModel!.orderCount.toString(),
                                                    title: 'total_order'.tr,
                                                  ))
                                                : const SizedBox(),
                                            SizedBox(
                                                width: Get.find<SplashController>().configModel!.customerWalletStatus == 1 ? Dimensions.paddingSizeSmall : 0),
                                            Get.find<SplashController>().configModel!.customerWalletStatus == 1
                                                ? Expanded(
                                                    child: ProfileCardWidget(
                                                    image: Images.walletProfile,
                                                    data: PriceConverter.convertPrice(profileController.userInfoModel!.walletBalance),
                                                    title: 'wallet_balance'.tr,
                                                  ))
                                                : const SizedBox(),
                                          ])
                                        : const SizedBox(),
                                    const SizedBox(height: Dimensions.paddingSizeDefault),
                                    ProfileButtonWidget(
                                        icon: Icons.tonality_outlined,
                                        title: 'dark_mode'.tr,
                                        isButtonActive: Get.isDarkMode,
                                        onTap: () {
                                          Get.find<ThemeController>().toggleTheme();
                                        }),
                                    const SizedBox(height: Dimensions.paddingSizeSmall),
                                    isLoggedIn
                                        ? GetBuilder<AuthController>(builder: (authController) {
                                            return ProfileButtonWidget(
                                              icon: Icons.notifications,
                                              title: 'notification'.tr,
                                              isButtonActive: authController.notification,
                                              onTap: () {
                                                Get.bottomSheet(const NotificationStatusChangeBottomSheet());
                                                // authController.setNotificationActive(!authController.notification);
                                              },
                                            );
                                          })
                                        : const SizedBox(),
                                    SizedBox(height: isLoggedIn ? Dimensions.paddingSizeSmall : 0),
                                    isLoggedIn
                                        ? profileController.userInfoModel!.socialId == null
                                            ? ProfileButtonWidget(
                                                icon: Icons.lock,
                                                title: 'change_password'.tr,
                                                onTap: () {
                                                  Get.toNamed(RouteHelper.getResetPasswordRoute('', '', 'password-change'));
                                                })
                                            : const SizedBox()
                                        : const SizedBox(),
                                    SizedBox(
                                        height: isLoggedIn
                                            ? profileController.userInfoModel!.socialId == null
                                                ? Dimensions.paddingSizeSmall
                                                : 0
                                            : 0),
                                    isLoggedIn
                                        ? ProfileButtonWidget(
                                            icon: Icons.delete,
                                            title: 'delete_account'.tr,
                                            iconImage: Images.profileDelete,
                                            color: Theme.of(context).colorScheme.error,
                                            onTap: () {
                                              Get.dialog(
                                                  ConfirmationDialog(
                                                    icon: Images.support,
                                                    title: 'are_you_sure_to_delete_account'.tr,
                                                    description: 'it_will_remove_your_all_information'.tr,
                                                    isLogOut: true,
                                                    onYesPressed: () => profileController.deleteUser(),
                                                  ),
                                                  useSafeArea: false);
                                            },
                                          )
                                        : const SizedBox(),
                                    SizedBox(height: isLoggedIn ? Dimensions.paddingSizeLarge : 0),
                                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                      Text('${'version'.tr}:', style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall)),
                                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                      Text(AppConstants.appVersion.toString(), style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall)),
                                    ]),
                                  ]),
                                ),
                              )
                            ]),
                          ),
                        ),
                ),
              );
      }),
    );
  }
}
