import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/menu_drawer.dart';
import '../../../helper/auth_helper.dart';
import '../../../helper/responsive_helper.dart';
import '../../../util/dimensions.dart';
import '../../../util/styles.dart';
import '../controllers/order_controller.dart';
import '../widgets/guest_track_order_input_view_widget.dart';
import '../widgets/order_view_widget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> with TickerProviderStateMixin {
  TabController? _tabController;
  bool _isLoggedIn = AuthHelper.isLoggedIn();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    initCall();
  }

  void initCall() {
    if (AuthHelper.isLoggedIn()) {
      Get.find<OrderController>().getRunningOrders(1);
      Get.find<OrderController>().getHistoryOrders(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    _isLoggedIn = AuthHelper.isLoggedIn();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(title: 'my_orders'.tr, backButton: ResponsiveHelper.isDesktop(context)),
      endDrawer: const MenuDrawer(),
      endDrawerEnableOpenDragGesture: false,
      body: GetBuilder<OrderController>(
        builder: (orderController) {
          return _isLoggedIn
              ? Column(children: [
                  Container(
                    color: ResponsiveHelper.isDesktop(context) ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.transparent,
                    child: Column(children: [
                      ResponsiveHelper.isDesktop(context)
                          ? Center(
                              child: Padding(
                              padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                              child: Text('my_orders'.tr, style: robotoMedium),
                            ))
                          : const SizedBox(),
                      Center(
                        child: SizedBox(
                          width: Dimensions.webMaxWidth,
                          child: Align(
                            alignment: ResponsiveHelper.isDesktop(context) ? Alignment.centerLeft : Alignment.center,
                            child: Container(
                              width: ResponsiveHelper.isDesktop(context) ? 300 : Dimensions.webMaxWidth,
                              color: ResponsiveHelper.isDesktop(context) ? Colors.transparent : Theme.of(context).cardColor,
                              child: TabBar(
                                controller: _tabController,
                                indicatorColor: Theme.of(context).primaryColor,
                                indicatorWeight: 3,
                                labelColor: Theme.of(context).primaryColor,
                                unselectedLabelColor: Theme.of(context).disabledColor,
                                unselectedLabelStyle: robotoRegular.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeSmall),
                                labelStyle: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                                tabs: [
                                  Tab(text: 'running'.tr),
                                  Tab(text: 'history'.tr),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                      child: TabBarView(
                    controller: _tabController,
                    children: const [
                      OrderViewWidget(isRunning: true),
                      OrderViewWidget(isRunning: false),
                    ],
                  )),
                ])
              : const GuestTrackOrderInputViewWidget();
        },
      ),
    );
  }
}
