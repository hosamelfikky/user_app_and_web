import 'package:user_app_web/features/item/domain/models/item_model.dart';
import 'package:user_app_web/interfaces/repository_interface.dart';

abstract class BrandsRepositoryInterface extends RepositoryInterface {
  Future<ItemModel?> getBrandItemList({required int brandId, int? offset});
}
