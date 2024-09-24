import 'package:get/get.dart';

import '../../../../api/api_client.dart';
import '../../../../common/models/response_model.dart';
import '../../../../util/app_constants.dart';
import 'favourite_repository_interface.dart';

class FavouriteRepository implements FavouriteRepositoryInterface<ResponseModel> {
  final ApiClient apiClient;
  FavouriteRepository({required this.apiClient});

  @override
  Future<Response> getList({int? offset}) async {
    return await apiClient.getData(AppConstants.wishListGetUri);
  }

  @override
  Future<ResponseModel> add(dynamic a, {bool isStore = false, int? id}) async {
    ResponseModel responseModel;
    Response response = await apiClient.postData('${AppConstants.addWishListUri}${isStore ? 'store_id=' : 'item_id='}$id', null, handleError: false);
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body['message']);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    return responseModel;
  }

  @override
  Future<ResponseModel> delete(int? id, {bool isStore = false}) async {
    ResponseModel responseModel;
    Response response = await apiClient.deleteData('${AppConstants.removeWishListUri}${isStore ? 'store_id=' : 'item_id='}$id', handleError: false);
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body['message']);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    return responseModel;
  }

  @override
  Future get(String? id) {
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int? id) {
    throw UnimplementedError();
  }
}
