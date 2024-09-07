import 'package:collection/collection.dart';
import 'package:mobile_top_up/model/beneficiary/beneficiary_model.dart';
import 'package:mobile_top_up/model/beneficiary_top_up_info.dart';
import 'package:mobile_top_up/model/transaction_history/transaction_history_model.dart';
import 'package:mobile_top_up/services/exceptions/exceptions.dart';
import 'package:mobile_top_up/services/top_up/top_up_manager.dart';
import 'package:mobile_top_up/services/top_up_service/i_top_up_service.dart';

class TopUpMockService implements ITopUpService {
  final List<TransactionHistoryModel> _transactionHistoryList = [];
  double _totalMonthlyTopUp = 0;
  final List<BeneficiaryModel> _beneficiaryModelList = [];
  double _availableBalance = 0;
  final bool _isVerified = true;

  TopUpMockService() {
    _availableBalance = 5000;
  }

  @override
  Future<bool> performTopUp(String phoneNumber, double amount) async {
    await Future.delayed(const Duration(seconds: 2));

    final beneficiary = _beneficiaryModelList
        .firstWhereOrNull((b) => b.phoneNumber == phoneNumber);
    if (beneficiary == null) {
      throw AppException('Beneficiary not found');
    }

    _availableBalance -= amount + TopUpManager.chargePerTransaction;
    _totalMonthlyTopUp += amount;
    beneficiary.topUpAmountSoFar += amount;

    _transactionHistoryList.add(TransactionHistoryModel(beneficiary, amount));

    return true;
  }

  @override
  Future<BeneficiaryTopUpInfo> fetchTopUpInfo(String phoneNumber) async {
    final beneficiary = _beneficiaryModelList
        .firstWhereOrNull((b) => b.phoneNumber == phoneNumber);
    return BeneficiaryTopUpInfo(
      beneficiaryPhoneNumber: phoneNumber,
      balance: _availableBalance,
      topUpSoFarForBeneficiary: beneficiary?.topUpAmountSoFar ?? 0,
      topUpSoFarForAll: _totalMonthlyTopUp,
    );
  }

  @override
  bool getIsVerified() => _isVerified;

  @override
  Future<List<BeneficiaryModel>> fetchBeneficiaries() async {
    return _beneficiaryModelList;
  }

  @override
  Future<List<TransactionHistoryModel>> fetchTransactionHistory() async {
    return _transactionHistoryList;
  }

  @override
  Future<void> addBeneficiary(String nickname, String phoneNumber) async {
    _beneficiaryModelList
        .add(BeneficiaryModel(nickname: nickname, phoneNumber: phoneNumber));
  }
}
