import 'package:mobile_top_up/model/beneficiary/beneficiary_model.dart';

class TransactionHistoryModel {
  final BeneficiaryModel beneficiary;
  final double amountSent;
  final DateTime dateTime;

  TransactionHistoryModel(
    this.beneficiary,
    this.amountSent,
  ) : dateTime = DateTime.now();
}
