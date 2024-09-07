class BeneficiaryTopUpInfo {
  final String beneficiaryPhoneNumber;
  final double balance;
  final double topUpSoFarForBeneficiary;
  final double topUpSoFarForAll;

  const BeneficiaryTopUpInfo({
    required this.beneficiaryPhoneNumber,
    required this.balance,
    required this.topUpSoFarForBeneficiary,
    required this.topUpSoFarForAll,
  });
}
