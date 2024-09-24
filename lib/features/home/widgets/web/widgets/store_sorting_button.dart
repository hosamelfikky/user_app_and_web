import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../util/dimensions.dart';
import '../../../../../util/styles.dart';
import '../../../../store/controllers/store_controller.dart';

class StoreSortingButton extends StatelessWidget {
  final String storeType;
  final String storeTypeText;
  const StoreSortingButton({super.key, required this.storeType, required this.storeTypeText});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(builder: (storeController) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall, vertical: Dimensions.paddingSizeExtraSmall),
        decoration: BoxDecoration(
          color: storeController.filterType == storeType ? Theme.of(context).primaryColor.withOpacity(0.1) : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          border: Border.all(color: storeController.filterType == storeType ? Theme.of(context).primaryColor : Theme.of(context).disabledColor),
        ),
        child: Row(children: [
          Icon(storeController.filterType == storeType ? Icons.check_circle : Icons.circle_outlined,
              color: storeController.filterType == storeType ? Theme.of(context).primaryColor : Theme.of(context).disabledColor, size: 16),
          const SizedBox(width: Dimensions.paddingSizeExtraSmall),
          Text(storeTypeText,
              style: robotoMedium.copyWith(color: storeController.filterType == storeType ? Theme.of(context).primaryColor : Theme.of(context).disabledColor)),
        ]),
      );
    });
  }
}
