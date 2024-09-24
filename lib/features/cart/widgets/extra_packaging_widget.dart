import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/price_converter.dart';
import '../../../util/dimensions.dart';
import '../../../util/styles.dart';
import '../../store/controllers/store_controller.dart';
import '../controllers/cart_controller.dart';

class ExtraPackagingWidget extends StatelessWidget {
  final CartController cartController;
  const ExtraPackagingWidget({super.key, required this.cartController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(builder: (storeController) {
      return storeController.store?.extraPackagingStatus ?? false
          ? Container(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              margin: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              decoration: BoxDecoration(
                color: Theme.of(context).disabledColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              ),
              child: Row(children: [
                Checkbox(
                  activeColor: Theme.of(context).primaryColor,
                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                  value: cartController.needExtraPackage,
                  onChanged: (bool? isChecked) {
                    cartController.toggleExtraPackage();
                  },
                ),
                const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                Text('need_extra_packaging'.tr, style: robotoMedium),
                const Spacer(),
                Text(PriceConverter.convertPrice(storeController.store?.extraPackagingAmount), style: robotoMedium),
              ]),
            )
          : const SizedBox();
    });
  }
}
