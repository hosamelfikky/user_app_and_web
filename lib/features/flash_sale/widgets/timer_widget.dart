import 'package:flutter/material.dart';
import 'package:user_app_web/helper/responsive_helper.dart';
import 'package:user_app_web/util/dimensions.dart';
import 'package:user_app_web/util/styles.dart';

class TimerWidget extends StatelessWidget {
  final int timeCount;
  final String timeUnit;
  const TimerWidget({super.key, required this.timeUnit, required this.timeCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.isMobile(context) ? Dimensions.paddingSizeSmall : Dimensions.paddingSizeExtraSmall,
            vertical: ResponsiveHelper.isMobile(context) ? Dimensions.paddingSizeSmall : Dimensions.paddingSizeExtraSmall,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          ),
          child: Text(timeCount > 9 ? timeCount.toString() : '0${timeCount.toString()}', style: robotoBold.copyWith(color: Colors.white)),
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        Text(timeUnit, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
