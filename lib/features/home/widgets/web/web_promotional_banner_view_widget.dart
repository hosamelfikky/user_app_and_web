import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../common/widgets/custom_image.dart';
import '../../../../util/dimensions.dart';
import '../../../banner/controllers/banner_controller.dart';

class WebPromotionalBannerView extends StatelessWidget {
  const WebPromotionalBannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(builder: (bannerController) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge),
        child: bannerController.promotionalBanner != null
            ? Container(
                height: 235,
                width: context.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                  child: CustomImage(
                    image: '${bannerController.promotionalBanner!.bottomSectionBannerFullUrl}',
                    fit: BoxFit.cover,
                    height: 235,
                    width: double.infinity,
                  ),
                ),
              )
            : const WebPromotionalBannerShimmerView(),
      );
    });
  }
}

class WebPromotionalBannerShimmerView extends StatelessWidget {
  const WebPromotionalBannerShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(seconds: 2),
      enabled: true,
      child: Container(
        height: 235,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
        ),
      ),
    );
  }
}
