import 'package:get/get.dart';

import '../../../../api/api_client.dart';
import '../../../../util/app_constants.dart';
import '../models/flash_sale_model.dart';
import '../models/product_flash_sale.dart';
import 'flash_sale_repository_interface.dart';

class FlashSaleRepository implements FlashSaleRepositoryInterface {
  final ApiClient apiClient;
  FlashSaleRepository({required this.apiClient});

  @override
  Future<FlashSaleModel?> getFlashSale() async {
    FlashSaleModel? flashSaleModel;
    Response response = await apiClient.getData(AppConstants.flashSaleUri);
    if (response.statusCode == 200) {
      flashSaleModel = FlashSaleModel.fromJson(response.body);
    }
    return flashSaleModel;
  }

  @override
  Future<ProductFlashSale?> getFlashSaleWithId(int id, int offset) async {
    ProductFlashSale? productFlashSale;
    Response response = await apiClient.getData('${AppConstants.flashSaleProductsUri}?flash_sale_id=$id&offset=$offset&limit=10');
    if (response.statusCode == 200) {
      productFlashSale = ProductFlashSale.fromJson(response.body);
    }
    return productFlashSale;
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
  Future getList({int? offset}) {
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int? id) {
    throw UnimplementedError();
  }
}
