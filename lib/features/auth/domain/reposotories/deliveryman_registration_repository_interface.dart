import '../../../../api/api_client.dart';
import '../../../../interfaces/repository_interface.dart';
import '../models/delivery_man_body.dart';

abstract class DeliverymanRegistrationRepositoryInterface extends RepositoryInterface {
  @override
  Future getList({int? offset, int? zoneId, bool isZone = true, bool isVehicle = false});
  Future<bool> registerDeliveryMan(DeliveryManBody deliveryManBody, List<MultipartBody> multiParts);
}
