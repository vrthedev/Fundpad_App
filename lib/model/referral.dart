class Referral {
  String id;
  String appUserName;
  double baseAmount;
  double amount;
  double percentage;
  int year;
  int month;

  Referral({
    required this.id,
    required this.appUserName,
    required this.baseAmount,
    required this.amount,
    required this.percentage,
    required this.year,
    required this.month,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'app_user_name': appUserName,
      'base_amount': baseAmount,
      'amount': amount,
      'percentage': percentage,
      'year': year,
      'month': month,
    };
  }

  factory Referral.fromJson(Map<String, dynamic> map) {
    return Referral(
      id: map['_id'] ?? "",
      appUserName: map['app_user_name'] ?? "",
      baseAmount:
          (map['base_amount'] == null) ? 0 : map['base_amount'].toDouble(),
      amount: (map['amount'] == null) ? 0 : map['amount'].toDouble(),
      percentage:
          (map['percentage'] == null) ? 0 : map['percentage'].toDouble(),
      year: map['year'] ?? 0,
      month: map['month'] ?? 0,
    );
  }

  static List<Referral> fromJsonList(jsonList) {
    if (jsonList == null) return [];
    return jsonList.map<Referral>((obj) => Referral.fromJson(obj)).toList();
  }
}
