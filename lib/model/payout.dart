class Payout {
  String id;
  String profitID;
  String profitName;
  int type;
  double percentage;
  double baseAmount;
  double amount;

  int year;
  int month;

  DateTime createdAt;

  Payout({
    required this.id,
    required this.profitID,
    required this.profitName,
    required this.type,
    required this.amount,
    required this.baseAmount,
    required this.percentage,
    required this.year,
    required this.month,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'profit_id': profitID,
      'profit_name': profitName,
      'type': type,
      'amount': amount,
      'base_amount': baseAmount,
      'percentage': percentage,
      'year': year,
      'month': month,
      'createdAt': createdAt,
    };
  }

  factory Payout.fromJson(Map<String, dynamic> map) {
    return Payout(
      id: map['_id'] ?? "",
      profitID: map['profit_id'] ?? "",
      profitName: map['profit_name'] ?? "",
      type: map['type'] ?? 0,
      amount: (map['amount'] == null) ? 0 : map['amount'].toDouble(),
      baseAmount:
          (map['base_amount'] == null) ? 0 : map['base_amount'].toDouble(),
      percentage:
          (map['percentage'] == null) ? 0 : map['percentage'].toDouble(),
      year: map['year'] ?? 0,
      month: map['month'] ?? 0,
      createdAt: (map['createdAt'] == null)
          ? DateTime(2022)
          : (map['createdAt'] is DateTime)
              ? map['createdAt']
              : (map['createdAt'] is String)
                  ? DateTime.parse(map['createdAt'])
                  : DateTime.parse(map['createdAt'].toDate().toString()),
    );
  }

  static List<Payout> fromJsonList(jsonList) {
    if (jsonList == null) return [];
    return jsonList.map<Payout>((obj) => Payout.fromJson(obj)).toList();
  }
}
