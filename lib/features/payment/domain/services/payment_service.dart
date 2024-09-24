import '../models/offline_method_model.dart';
import '../repositories/payment_repository_interface.dart';
import 'payment_service_interface.dart';

class PaymentService implements PaymentServiceInterface {
  final PaymentRepositoryInterface paymentRepositoryInterface;
  PaymentService({required this.paymentRepositoryInterface});

  @override
  Future<List<OfflineMethodModel>?> getOfflineMethodList() async {
    return await paymentRepositoryInterface.getList();
  }

  @override
  Future<bool> saveOfflineInfo(String data) async {
    return await paymentRepositoryInterface.saveOfflineInfo(data);
  }

  @override
  Future<bool> updateOfflineInfo(String data) async {
    return await paymentRepositoryInterface.updateOfflineInfo(data);
  }
}
