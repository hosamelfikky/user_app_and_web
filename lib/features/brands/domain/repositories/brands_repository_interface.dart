import '../../../../interfaces/repository_interface.dart';
import '../../../item/domain/models/item_model.dart';

abstract class BrandsRepositoryInterface extends RepositoryInterface {
  Future<ItemModel?> getBrandItemList({required int brandId, int? offset});
}
