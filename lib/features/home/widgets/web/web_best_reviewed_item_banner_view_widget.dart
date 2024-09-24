import 'package:flutter/material.dart';

import '../../../../common/widgets/custom_image.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';

class WebStoreWiseBannerViewWidget extends StatelessWidget {
  const WebStoreWiseBannerViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraLarge),
      child: Container(
        height: 135,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
          child: const CustomImage(
            image: Images.placeholder,
            fit: BoxFit.cover,
            height: 135,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
