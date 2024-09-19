import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app_web/features/auth/controllers/auth_controller.dart';
import 'package:user_app_web/features/profile/controllers/profile_controller.dart';
import 'package:user_app_web/helper/route_helper.dart';
import 'package:user_app_web/util/styles.dart';

class GuestButtonWidget extends StatelessWidget {
  const GuestButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return !authController.guestLoading
          ? TextButton(
              style: TextButton.styleFrom(
                minimumSize: const Size(1, 40),
              ),
              onPressed: () {
                authController.guestLogin().then((response) {
                  if (response.isSuccess) {
                    Get.find<ProfileController>().setForceFullyUserEmpty();
                    if (!context.mounted) return;
                    Navigator.pushReplacementNamed(context, RouteHelper.getInitialRoute());
                  }
                });
              },
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(text: '${'continue_as'.tr} ', style: robotoRegular.copyWith(color: Theme.of(context).disabledColor)),
                TextSpan(text: 'guest'.tr, style: robotoMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color)),
              ])),
            )
          : const Center(child: SizedBox(height: 25, width: 25, child: CircularProgressIndicator()));
    });
  }
}
