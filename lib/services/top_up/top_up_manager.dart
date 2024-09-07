import 'package:collection/collection.dart';
import 'package:mobile_top_up/model/beneficiary/beneficiary_model.dart';
import 'package:mobile_top_up/model/beneficiary_top_up_info.dart';
import 'package:mobile_top_up/model/transaction_history/transaction_history_model.dart';
import 'package:mobile_top_up/services/top_up_service/i_top_up_service.dart';

class TopUpManager {
  static const double maxMonthlyLimit = 3000;
  static const double maxVerifiedBeneficiaryMonthlyLimit = 500;
  static const double maxUnverifiedBeneficiaryMonthlyLimit = 1000;
  static const double chargePerTransaction = 1;
  static const List<double> topUpOptions = [5, 10, 20, 30, 50, 75, 100];

  final ITopUpService _topUpService;

  TopUpManager({
    required ITopUpService topUpService,
  }) : _topUpService = topUpService;

  Future<void> addBeneficiary(String nickname, String phoneNumber) async {
    if (nickname.length > 20) {
      throw Exception("Nickname exceeds 20 characters.");
    }

    final beneficiaries = await _topUpService.fetchBeneficiaries();
    if (beneficiaries.length >= 5) {
      throw Exception("Cannot add more than 5 beneficiaries.");
    }

    final existingPhone =
        beneficiaries.firstWhereOrNull((b) => b.phoneNumber == phoneNumber);
    if (existingPhone != null) {
      throw Exception("Beneficiary phone number already exist");
    }

    final existingNickname = beneficiaries.firstWhereOrNull(
        (b) => b.nickname.toLowerCase() == nickname.toLowerCase());
    if (existingNickname != null) {
      throw Exception("Beneficiary nick name already exist");
    }

    return _topUpService.addBeneficiary(nickname, phoneNumber);
  }

  Future<List<TransactionHistoryModel>> getTransactionHistory() =>
      _topUpService.fetchTransactionHistory();

  Future<List<BeneficiaryModel>> getBeneficiaries() =>
      _topUpService.fetchBeneficiaries();

  double beneficiaryLimit() {
    return _topUpService.getIsVerified()
        ? maxVerifiedBeneficiaryMonthlyLimit
        : maxUnverifiedBeneficiaryMonthlyLimit;
  }

  Future<BeneficiaryTopUpInfo> fetchTopUpInfo(String phoneNumber) {
    return _topUpService.fetchTopUpInfo(phoneNumber);
  }

  Future<bool> topUp(
      String phoneNumber, double amount, BeneficiaryTopUpInfo model) async {
    if (!topUpOptions.contains(amount)) {
      throw Exception("Invalid top-up amount.");
    }

    final beneficiaries = await _topUpService.fetchBeneficiaries();
    final beneficiary =
        beneficiaries.firstWhereOrNull((b) => b.phoneNumber == phoneNumber);

    if (beneficiary == null) {
      throw Exception("Beneficiary not found.");
    }

    if (model.balance < amount + chargePerTransaction) {
      throw Exception("Insufficient balance.");
    }

    if (model.topUpSoFarForBeneficiary + amount > beneficiaryLimit()) {
      throw Exception("Beneficiary's monthly limit exceeded.");
    }

    if (model.topUpSoFarForAll + amount > maxMonthlyLimit) {
      throw Exception("User's total monthly limit exceeded.");
    }

    try {
      final isSuccess = await _topUpService.performTopUp(phoneNumber, amount);

      if (isSuccess) {
        return true;
      }

      throw Exception('Error during top-up');
    } catch (e) {
      throw Exception('Error during top-up: $e');
    }
  }
}
