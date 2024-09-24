import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app_web/common/widgets/custom_button.dart';
import 'package:user_app_web/features/language/controllers/language_controller.dart';
import 'package:user_app_web/features/language/widgets/language_card_widget.dart';
import 'package:user_app_web/util/app_constants.dart';
import 'package:user_app_web/util/dimensions.dart';
import 'package:user_app_web/util/styles.dart';

class LanguageBottomSheetWidget extends StatelessWidget {
  const LanguageBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      builder: (localizationController) {
        return Container(
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5,
                width: 35,
                decoration: BoxDecoration(
                  color: Theme.of(context).disabledColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('choose_your_language'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  Text('choose_your_language_to_proceed'.tr, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                ],
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraLarge),
              Flexible(
                child: ListView.builder(
                  itemCount: localizationController.languages.length,
                  // shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                  itemBuilder: (context, index) {
                    return LanguageCardWidget(
                      languageModel: localizationController.languages[index],
                      localizationController: localizationController,
                      index: index,
                      fromBottomSheet: true,
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeExtraLarge).copyWith(
                  bottom: MediaQuery.viewPaddingOf(context).bottom,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 10, spreadRadius: 0)],
                ),
                margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                child: CustomButton(
                  buttonText: 'update'.tr,
                  onPressed: () {
                    if (localizationController.languages.isNotEmpty && localizationController.selectedLanguageIndex != -1) {
                      localizationController.saveCacheLanguage(
                        Locale(
                          AppConstants.languages[localizationController.selectedLanguageIndex].languageCode!,
                          AppConstants.languages[localizationController.selectedLanguageIndex].countryCode,
                        ),
                      );
                    }
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
