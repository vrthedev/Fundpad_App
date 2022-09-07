class Referee {
  String id;
  String investorID;
  String investorName;
  String referrerID;
  String referrerName;
  double amount;
  DateTime createdAt;

  Referee({
    required this.id,
    required this.investorID,
    required this.investorName,
    required this.referrerID,
    required this.amount,
    required this.referrerName,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'investor_id': investorID,
      'investor_name': investorName,
      'referrer_id': referrerID,
      'referrer_name': referrerName,
      'amount': amount,
      'createdAt': createdAt,
    };
  }

  factory Referee.fromJson(Map<String, dynamic> map) {
    return Referee(
      id: map['id'] ?? "",
      investorID: map['investor_id'] ?? "",
      investorName: map['investor_name'] ?? "",
      referrerID: map['referrer_id'] ?? "",
      referrerName: map['referrer_name'] ?? "",
      amount: (map['amount'] == null) ? 0 : map['amount'].toDouble(),
      createdAt: (map['createdAt'] == null)
          ? DateTime(2022)
          : (map['createdAt'] is DateTime)
              ? map['createdAt']
              : (map['createdAt'] is String)
                  ? DateTime.parse(map['createdAt'])
                  : DateTime.parse(map['createdAt'].toDate().toString()),
    );
  }

  static List<Referee> fromJsonList(jsonList) {
    if (jsonList == null) return [];
    return jsonList.map<Referee>((obj) => Referee.fromJson(obj)).toList();
  }
}
