import 'package:get/get_connect.dart';

import '../../../../api/api_client.dart';
import '../../../../common/models/transaction_model.dart';
import '../../../../util/app_constants.dart';
import 'loyalty_repository_interface.dart';

class LoyaltyRepository implements LoyaltyRepositoryInterface {
  final ApiClient apiClient;
  LoyaltyRepository({required this.apiClient});

  @override
  Future<Response> pointToWallet({int? point}) async {
    return await apiClient.postData(AppConstants.loyaltyPointTransferUri, {"point": point});
  }

  @override
  Future add(value) {
    throw UnimplementedError();
  }

  @override
  Future delete(int? id) {
    throw UnimplementedError();
  }

  @override
  Future get(String? id) {
    throw UnimplementedError();
  }

  @override
  Future getList({int? offset}) async {
    return await _getLoyaltyTransactionList(offset);
  }

  Future<TransactionModel?> _getLoyaltyTransactionList(int? offset) async {
    TransactionModel? transactionModel;
    Response response = await apiClient.getData('${AppConstants.loyaltyTransactionUri}?offset=$offset&limit=10');
    if (response.statusCode == 200) {
      transactionModel = TransactionModel.fromJson(response.body);
    }
    return transactionModel;
  }

  @override
  Future update(Map<String, dynamic> body, int? id) {
    throw UnimplementedError();
  }
}
