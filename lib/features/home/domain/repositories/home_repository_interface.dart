import '../../../../interfaces/repository_interface.dart';
import '../models/cashback_model.dart';

abstract class HomeRepositoryInterface<T> implements RepositoryInterface {
  Future<CashBackModel?> getCashBackData(double amount);
  Future<bool> saveRegistrationSuccessful(bool status);
  Future<bool> saveIsRestaurantRegistration(bool status);
  bool getRegistrationSuccessful();
  bool getIsRestaurantRegistration();
}
