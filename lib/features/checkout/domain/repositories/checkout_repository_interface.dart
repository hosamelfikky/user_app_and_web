import 'package:get/get_connect/http/src/response/response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../api/api_client.dart';
import '../../../../interfaces/repository_interface.dart';
import '../models/place_order_body_model.dart';

abstract class CheckoutRepositoryInterface extends RepositoryInterface {
  Future<int> getDmTipMostTapped();
  String getSharedPrefDmTipIndex();
  Future<bool> saveSharedPrefDmTipIndex(String index);
  Future<Response> getDistanceInMeter(LatLng originLatLng, LatLng destinationLatLng);
  Future<double> getExtraCharge(double? distance);
  Future<Response> placeOrder(PlaceOrderBodyModel orderBody, List<MultipartBody>? orderAttachment);
  Future<Response> placePrescriptionOrder(int? storeId, double? distance, String address, String longitude, String latitude, String note,
      List<MultipartBody> orderAttachment, String dmTips, String deliveryInstruction);
}
