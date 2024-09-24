import '../../../../interfaces/repository_interface.dart';
import '../models/cart_model.dart';

abstract class CartRepositoryInterface<OnlineCart> extends RepositoryInterface<OnlineCart> {
  Future<void> addSharedPrefCartList(List<CartModel> cartProductList);
  @override
  Future<dynamic> update(Map<String, dynamic> body, int? id, {double price, int quantity, bool isUpdateQty = false});
  @override
  Future<bool> delete(int? id, {bool isRemoveAll = false});
}
