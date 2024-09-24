import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../api/api_client.dart';
import '../../../../common/models/transaction_model.dart';
import '../../../../helper/route_helper.dart';
import '../../../../util/app_constants.dart';
import '../models/fund_bonus_model.dart';
import 'wallet_repository_interface.dart';

class WalletRepository implements WalletRepositoryInterface {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  WalletRepository({required this.apiClient, required this.sharedPreferences});

  @override
  Future<Response> addFundToWallet(double amount, String paymentMethod) async {
    String? hostname = html.window.location.hostname;
    String protocol = html.window.location.protocol;

    return await apiClient.postData(AppConstants.addFundUri, {
      "amount": amount,
      "payment_method": paymentMethod,
      "payment_platform": GetPlatform.isWeb ? 'web' : '',
      "callback": '$protocol//$hostname${RouteHelper.wallet}',
    });
  }

  @override
  Future<void> setWalletAccessToken(String token) {
    return sharedPreferences.setString(AppConstants.walletAccessToken, token);
  }

  @override
  String getWalletAccessToken() {
    return sharedPreferences.getString(AppConstants.walletAccessToken) ?? "";
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
  Future getList({int? offset, String? sortingType, bool isBonusList = false}) async {
    if (isBonusList) {
      return await _getWalletBonusList();
    } else {
      return await _getWalletTransactionList(offset.toString(), sortingType!);
    }
  }

  Future<TransactionModel?> _getWalletTransactionList(String offset, String sortingType) async {
    TransactionModel? transactionModel;
    Response response = await apiClient.getData('${AppConstants.walletTransactionUri}?offset=$offset&limit=10&type=$sortingType');
    if (response.statusCode == 200) {
      transactionModel = TransactionModel.fromJson(response.body);
    }
    return transactionModel;
  }

  Future<List<FundBonusModel>?> _getWalletBonusList() async {
    List<FundBonusModel>? fundBonusList;
    Response response = await apiClient.getData(AppConstants.walletBonusUri);
    if (response.statusCode == 200) {
      fundBonusList = [];
      response.body.forEach((value) {
        fundBonusList!.add(FundBonusModel.fromJson(value));
      });
    }
    return fundBonusList;
  }

  @override
  Future update(Map<String, dynamic> body, int? id) {
    throw UnimplementedError();
  }
}
