import 'package:user_app_web/interfaces/repository_interface.dart';

abstract class FlashSaleRepositoryInterface<T> implements RepositoryInterface {
  Future<dynamic> getFlashSale();
  Future<dynamic> getFlashSaleWithId(int id, int offset);
}
