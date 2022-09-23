class Referral {
  String id;
  String fullname;
  double confirmedAmount;
  double investorPayouts;
  double commissions;
  DateTime createdAt;

  Referral({
    required this.id,
    required this.fullname,
    required this.confirmedAmount,
    required this.investorPayouts,
    required this.commissions,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'confirmed_amount': confirmedAmount,
      'investor_payouts': investorPayouts,
      'createdAt': createdAt,
    };
  }

  factory Referral.fromJson(Map<String, dynamic> map) {
    double investor = (map['investor_payouts'] == null)
        ? 0
        : map['investor_payouts'].toDouble();
    double commission = investor / 5;

    return Referral(
      id: map['id'] ?? "",
      fullname: map['fullname'] ?? "",
      confirmedAmount: (map['confirmed_amount'] == null)
          ? 0
          : map['confirmed_amount'].toDouble(),
      investorPayouts: investor,
      commissions: commission,
      createdAt: (map['createdAt'] == null)
          ? DateTime(2022)
          : (map['createdAt'] is DateTime)
              ? map['createdAt']
              : (map['createdAt'] is String)
                  ? DateTime.parse(map['createdAt'])
                  : DateTime.parse(map['createdAt'].toDate().toString()),
    );
  }

  static List<Referral> fromJsonList(jsonList) {
    if (jsonList == null) return [];
    return jsonList.map<Referral>((obj) => Referral.fromJson(obj)).toList();
  }
}
