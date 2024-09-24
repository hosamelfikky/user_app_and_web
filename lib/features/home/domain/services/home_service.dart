import '../models/cashback_model.dart';
import '../repositories/home_repository_interface.dart';
import 'home_service_interface.dart';

class HomeService implements HomeServiceInterface {
  final HomeRepositoryInterface homeRepositoryInterface;
  HomeService({required this.homeRepositoryInterface});

  @override
  Future<List<CashBackModel>> getCashBackOfferList() async {
    return await homeRepositoryInterface.getList();
  }

  @override
  Future<CashBackModel?> getCashBackData(double amount) async {
    return await homeRepositoryInterface.getCashBackData(amount);
  }

  @override
  Future<bool> saveRegistrationSuccessful(bool status) async {
    return await homeRepositoryInterface.saveRegistrationSuccessful(status);
  }

  @override
  Future<bool> saveIsRestaurantRegistration(bool status) async {
    return await homeRepositoryInterface.saveIsRestaurantRegistration(status);
  }

  @override
  bool getRegistrationSuccessful() {
    return homeRepositoryInterface.getRegistrationSuccessful();
  }

  @override
  bool getIsRestaurantRegistration() {
    return homeRepositoryInterface.getIsRestaurantRegistration();
  }
}
