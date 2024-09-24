import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../common/models/transaction_model.dart';
import '../repositories/loyalty_repository_interface.dart';
import 'loyalty_service_interface.dart';

class LoyaltyService implements LoyaltyServiceInterface {
  final LoyaltyRepositoryInterface loyaltyRepositoryInterface;
  LoyaltyService({required this.loyaltyRepositoryInterface});

  @override
  Future<TransactionModel?> getLoyaltyTransactionList(String offset) async {
    return await loyaltyRepositoryInterface.getList(offset: int.parse(offset));
  }

  @override
  Future<Response> pointToWallet({int? point}) async {
    return await loyaltyRepositoryInterface.pointToWallet(point: point);
  }
}
