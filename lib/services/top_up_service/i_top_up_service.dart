import 'package:mobile_top_up/model/beneficiary/beneficiary_model.dart';
import 'package:mobile_top_up/model/beneficiary_top_up_info.dart';
import 'package:mobile_top_up/model/transaction_history/transaction_history_model.dart';

abstract class ITopUpService {
  Future<bool> performTopUp(String phoneNumber, double amount);

  Future<BeneficiaryTopUpInfo> fetchTopUpInfo(String phoneNumber);

  bool getIsVerified();

  Future<List<BeneficiaryModel>> fetchBeneficiaries();

  Future<List<TransactionHistoryModel>> fetchTransactionHistory();

  Future<void> addBeneficiary(String nickname, String phoneNumber);
}
