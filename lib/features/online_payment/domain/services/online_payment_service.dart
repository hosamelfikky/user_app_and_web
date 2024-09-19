import 'package:user_app_web/features/online_payment/domain/repositories/online_payment_repo_interface.dart';
import 'online_payment_service_interface.dart';

class OnlinePaymentService implements OnlinePaymentServiceInterface {
  final OnlinePaymentRepoInterface onlinePaymentRepoInterface;
  OnlinePaymentService({required this.onlinePaymentRepoInterface});
}
