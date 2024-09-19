import 'package:user_app_web/api/api_client.dart';
import 'package:user_app_web/features/auth/domain/models/delivery_man_body.dart';
import 'package:user_app_web/interfaces/repository_interface.dart';

abstract class DeliverymanRegistrationRepositoryInterface extends RepositoryInterface {
  @override
  Future getList({int? offset, int? zoneId, bool isZone = true, bool isVehicle = false});
  Future<bool> registerDeliveryMan(DeliveryManBody deliveryManBody, List<MultipartBody> multiParts);
}
