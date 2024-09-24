import '../models/offline_method_model.dart';

abstract class PaymentServiceInterface {
  Future<List<OfflineMethodModel>?> getOfflineMethodList();
  Future<bool> saveOfflineInfo(String data);
  Future<bool> updateOfflineInfo(String data);
}
