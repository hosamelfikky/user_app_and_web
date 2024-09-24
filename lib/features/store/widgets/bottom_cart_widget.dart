import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../helper/price_converter.dart';
import '../../../helper/route_helper.dart';
import '../../../util/dimensions.dart';
import '../../../util/styles.dart';
import '../../cart/controllers/cart_controller.dart';

class BottomCartWidget extends StatelessWidget {
  const BottomCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController) {
      return Container(
        height: GetPlatform.isIOS ? 100 : 70,
        width: Get.width,
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeExtraLarge, /* vertical: Dimensions.PADDING_SIZE_SMALL*/
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [BoxShadow(color: const Color(0xFF2A2A2A).withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))],
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('${'item'.tr}: ${cartController.cartList.length}', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Row(children: [
              Text(
                '${'total'.tr}: ',
                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
              ),
              Text(
                PriceConverter.convertPrice(cartController.calculationCart()),
                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
                textDirection: TextDirection.ltr,
              ),
            ]),
          ]),
          CustomButton(buttonText: 'view_cart'.tr, width: 130, height: 45, onPressed: () => Get.toNamed(RouteHelper.getCartRoute()))
        ]),
      );
    });
  }
}
