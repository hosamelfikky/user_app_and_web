import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/add_favourite_view.dart';
import '../../../../common/widgets/cart_count_view.dart';
import '../../../../common/widgets/custom_asset_image_widget.dart';
import '../../../../common/widgets/custom_image.dart';
import '../../../../common/widgets/custom_ink_well.dart';
import '../../../../common/widgets/discount_tag.dart';
import '../../../../common/widgets/hover/on_hover.dart';
import '../../../../common/widgets/not_available_widget.dart';
import '../../../../helper/price_converter.dart';
import '../../../../helper/responsive_helper.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';
import '../../../item/controllers/item_controller.dart';
import '../../../item/domain/models/item_model.dart';
import '../../../language/controllers/language_controller.dart';
import '../../../splash/controllers/splash_controller.dart';

class ItemThatYouLoveCard extends StatelessWidget {
  final Item item;
  final int? index;
  const ItemThatYouLoveCard({super.key, required this.item, this.index});

  @override
  Widget build(BuildContext context) {
    double? discount = item.storeDiscount == 0 ? item.discount : item.storeDiscount;
    String? discountType = item.storeDiscount == 0 ? item.discountType : 'percent';
    return OnHover(
      isItem: true,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          color: Theme.of(context).cardColor,
          boxShadow: ResponsiveHelper.isMobile(context)
              ? [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, 1))]
              : null,
        ),
        child: CustomInkWell(
          onTap: () => Get.find<ItemController>().navigateToItemPage(item, context),
          radius: Dimensions.radiusDefault,
          child: Column(children: [
            Expanded(
              flex: 7,
              child: Stack(clipBehavior: Clip.none, children: [
                Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                    child: CustomImage(
                      image: '${item.imageFullUrl}',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                DiscountTag(
                  discount: discount,
                  discountType: discountType,
                  freeDelivery: false,
                ),
                item.isStoreHalalActive! && item.isHalalItem!
                    ? const Positioned(
                        top: 40,
                        right: 15,
                        child: CustomAssetImageWidget(
                          Images.halalTag,
                          height: 20,
                          width: 20,
                        ),
                      )
                    : const SizedBox(),
                AddFavouriteView(
                  item: item,
                ),
                Get.find<ItemController>().isAvailable(item) ? const SizedBox() : const NotAvailableWidget(),
                Positioned(
                  bottom: -10,
                  left: 0,
                  right: 0,
                  child: CartCountView(
                    item: item,
                    index: index,
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        width: 65,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(112),
                          color: Theme.of(context).primaryColor,
                          boxShadow: [
                            BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.1), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, 1))
                          ],
                        ),
                        child: Text("add".tr, style: robotoBold.copyWith(color: Theme.of(context).cardColor)),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Expanded(
              flex: Get.find<LocalizationController>().isLtr ? 3 : 4,
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(item.name ?? '', style: robotoBold),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(Icons.star, size: 15, color: Theme.of(context).primaryColor),
                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                    Text(item.avgRating!.toStringAsFixed(1), style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                    Text("(${item.ratingCount})",
                        style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor)),
                  ]),
                  (Get.find<SplashController>().configModel!.moduleConfig!.module!.unit! && item.unitType != null)
                      ? Text(
                          item.unitType ?? '',
                          style: robotoRegular.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeExtraSmall),
                        )
                      : const SizedBox(),
                  Wrap(alignment: WrapAlignment.center, crossAxisAlignment: WrapCrossAlignment.center, children: [
                    item.discount != null && item.discount! > 0
                        ? Text(
                            PriceConverter.convertPrice(Get.find<ItemController>().getStartingPrice(item)),
                            style: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeExtraSmall,
                              color: Theme.of(context).disabledColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                            textDirection: TextDirection.ltr,
                          )
                        : const SizedBox(),
                    SizedBox(width: item.discount != null && item.discount! > 0 ? Dimensions.paddingSizeExtraSmall : 0),
                    Text(
                      PriceConverter.convertPrice(
                        Get.find<ItemController>().getStartingPrice(item),
                        discount: item.discount,
                        discountType: item.discountType,
                      ),
                      textDirection: TextDirection.ltr,
                      style: robotoMedium,
                    ),
                  ]),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
