import 'package:get/get.dart';

import '../../../../api/api_client.dart';
import '../../../../util/app_constants.dart';
import '../../../item/domain/models/item_model.dart';
import '../models/brands_model.dart';
import 'brands_repository_interface.dart';

class BrandsRepository implements BrandsRepositoryInterface {
  final ApiClient apiClient;
  BrandsRepository({required this.apiClient});

  @override
  Future<List<BrandModel>?> getList({int? offset}) async {
    List<BrandModel>? brandList;
    Response response = await apiClient.getData(AppConstants.brandListUri);
    if (response.statusCode == 200) {
      brandList = [];
      response.body.forEach((brand) => brandList!.add(BrandModel.fromJson(brand)));
    }
    return brandList;
  }

  @override
  Future<ItemModel?> getBrandItemList({required int brandId, int? offset}) async {
    ItemModel? brandItemModel;
    Response response = await apiClient.getData('${AppConstants.brandItemUri}/$brandId?offset=$offset&limit=12');
    if (response.statusCode == 200) {
      brandItemModel = ItemModel.fromJson(response.body);
    }
    return brandItemModel;
  }

  @override
  Future add(value) {
    throw UnimplementedError();
  }

  @override
  Future delete(int? id) {
    throw UnimplementedError();
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
