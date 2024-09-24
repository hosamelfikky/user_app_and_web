import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/menu_drawer.dart';
import '../../../util/dimensions.dart';
import '../../../util/styles.dart';
import '../../order/domain/models/order_details_model.dart';
import '../../order/domain/models/order_model.dart';
import '../controllers/review_controller.dart';
import '../widgets/deliver_man_review_widget.dart';
import '../widgets/item_review_widget.dart';

class RateReviewScreen extends StatefulWidget {
  final List<OrderDetailsModel> orderDetailsList;
  final DeliveryMan? deliveryMan;
  final int? orderID;
  const RateReviewScreen({super.key, required this.orderDetailsList, required this.deliveryMan, required this.orderID});

  @override
  RateReviewScreenState createState() => RateReviewScreenState();
}

class RateReviewScreenState extends State<RateReviewScreen> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: (widget.deliveryMan == null || widget.orderDetailsList.isEmpty) ? 1 : 2, initialIndex: 0, vsync: this);
    Get.find<ReviewController>().initRatingData(widget.orderDetailsList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: 'rate_review'.tr),
      endDrawer: const MenuDrawer(),
      endDrawerEnableOpenDragGesture: false,
      body: Column(children: [
        Center(
          child: Container(
            width: Dimensions.webMaxWidth,
            color: Theme.of(context).cardColor,
            child: TabBar(
              controller: _tabController,
              labelColor: Theme.of(context).textTheme.bodyLarge!.color,
              indicatorColor: Theme.of(context).primaryColor,
              indicatorWeight: 3,
              unselectedLabelStyle: robotoRegular.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeSmall),
              labelStyle: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
              tabs: widget.orderDetailsList.isNotEmpty
                  ? widget.deliveryMan != null
                      ? [
                          Tab(text: widget.orderDetailsList.length > 1 ? 'items'.tr : 'item'.tr),
                          Tab(text: 'delivery_man'.tr),
                        ]
                      : [
                          Tab(text: widget.orderDetailsList.length > 1 ? 'items'.tr : 'item'.tr),
                        ]
                  : [
                      Tab(text: 'delivery_man'.tr),
                    ],
            ),
          ),
        ),
        Expanded(
            child: TabBarView(
          controller: _tabController,
          children: widget.orderDetailsList.isNotEmpty
              ? widget.deliveryMan != null
                  ? [
                      ItemReviewWidget(orderDetailsList: widget.orderDetailsList),
                      DeliveryManReviewWidget(deliveryMan: widget.deliveryMan, orderID: widget.orderID.toString()),
                    ]
                  : [
                      ItemReviewWidget(orderDetailsList: widget.orderDetailsList),
                    ]
              : [
                  DeliveryManReviewWidget(deliveryMan: widget.deliveryMan, orderID: widget.orderID.toString()),
                ],
        )),
      ]),
    );
  }
}
