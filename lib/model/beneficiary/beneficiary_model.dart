class BeneficiaryModel {
  String nickname;
  String phoneNumber;

  /// Total top up amount so far for current calendar month
  double topUpAmountSoFar;

  BeneficiaryModel({
    required this.nickname,
    required this.phoneNumber,
  }) : topUpAmountSoFar = 0;

  factory BeneficiaryModel.fromJson(Map<String, dynamic> json) {
    return BeneficiaryModel(
      nickname: json['nickname'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
    )..topUpAmountSoFar = (json['totalTopUpAmount'] ?? 0).toDouble();
  }

  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
      'phoneNumber': phoneNumber,
      'totalTopUpAmount': topUpAmountSoFar,
    };
  }
}
