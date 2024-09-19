import 'package:user_app_web/common/models/transaction_model.dart';
import 'package:user_app_web/features/wallet/domain/models/fund_bonus_model.dart';

abstract class WalletServiceInterface {
  Future<TransactionModel?> getWalletTransactionList(String offset, String sortingType);
  Future<dynamic> addFundToWallet(double amount, String paymentMethod);
  Future<List<FundBonusModel>?> getWalletBonusList();
  Future<void> setWalletAccessToken(String token);
  String getWalletAccessToken();
}
