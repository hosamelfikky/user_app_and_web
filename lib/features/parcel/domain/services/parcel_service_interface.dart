import 'package:get/get_connect/http/src/response/response.dart';
import 'package:user_app_web/features/checkout/domain/models/place_order_body_model.dart';
import 'package:user_app_web/features/parcel/domain/models/parcel_category_model.dart';
import 'package:user_app_web/features/parcel/domain/models/video_content_model.dart';
import 'package:user_app_web/features/parcel/domain/models/why_choose_model.dart';
import 'package:user_app_web/features/payment/domain/models/offline_method_model.dart';

import '../models/parcel_instruction_model.dart';

abstract class ParcelServiceInterface {
  Future<List<ParcelCategoryModel>?> getParcelCategory();
  Future<List<Data>?> getParcelInstruction(int offset);
  Future<WhyChooseModel?> getWhyChooseDetails();
  Future<VideoContentModel?> getVideoContentDetails();
  Future<Response> getPlaceDetails(String? placeID);
  Future<List<OfflineMethodModel>?> getOfflineMethodList();
  Future<int> getDmTipMostTapped();
  Future<Response> placeOrder(PlaceOrderBodyModel orderBody);
}
