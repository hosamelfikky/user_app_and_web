import 'package:get/get_connect/connect.dart';

import '../../../../interfaces/repository_interface.dart';
import '../models/business_plan_body.dart';

abstract class BusinessRepoInterface<T> implements RepositoryInterface<T> {
  Future<Response> setUpBusinessPlan(BusinessPlanBody businessPlanBody);
  Future<Response> subscriptionPayment(String id, String? paymentName);
}
