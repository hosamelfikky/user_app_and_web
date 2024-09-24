import 'package:get/get_connect/http/src/response/response.dart';

import '../../../checkout/domain/models/place_order_body_model.dart';
import '../../../checkout/domain/repositories/checkout_repository_interface.dart';
import '../../../payment/domain/models/offline_method_model.dart';
import '../models/parcel_category_model.dart';
import '../models/parcel_instruction_model.dart';
import '../models/video_content_model.dart';
import '../models/why_choose_model.dart';
import '../repositories/parcel_repository_interface.dart';
import 'parcel_service_interface.dart';

class ParcelService implements ParcelServiceInterface {
  final ParcelRepositoryInterface parcelRepositoryInterface;
  final CheckoutRepositoryInterface checkoutRepositoryInterface;
  ParcelService({required this.parcelRepositoryInterface, required this.checkoutRepositoryInterface});

  @override
  Future<List<ParcelCategoryModel>?> getParcelCategory() async {
    return await parcelRepositoryInterface.getList();
  }

  @override
  Future<List<Data>?> getParcelInstruction(int offset) async {
    return await parcelRepositoryInterface.getList(offset: offset, parcelCategory: false);
  }

  @override
  Future<WhyChooseModel?> getWhyChooseDetails() async {
    return await parcelRepositoryInterface.get(null, isVideoDetails: false);
  }

  @override
  Future<VideoContentModel?> getVideoContentDetails() async {
    return await parcelRepositoryInterface.get(null, isVideoDetails: true);
  }

  @override
  Future<Response> getPlaceDetails(String? placeID) async {
    return await parcelRepositoryInterface.getPlaceDetails(placeID);
  }

  @override
  Future<List<OfflineMethodModel>?> getOfflineMethodList() async {
    return await checkoutRepositoryInterface.getList();
  }

  @override
  Future<int> getDmTipMostTapped() async {
    return await checkoutRepositoryInterface.getDmTipMostTapped();
  }

  @override
  Future<Response> placeOrder(PlaceOrderBodyModel orderBody) async {
    return await checkoutRepositoryInterface.placeOrder(orderBody, null);
  }
}
