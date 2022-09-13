class Pledge {
  String id;
  double amount;
  String transaction;
  int status;
  DateTime createdAt;
  // "investor_id": "631a00c31d06c11d1924eea5",
  // "investor_name": "Smart Dev",
  // "referrer_id": "631a00811d06c11d1924eea3",
  // "referrer_name": "Founder 1",

  Pledge({
    required this.id,
    required this.amount,
    required this.transaction,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'transaction': transaction,
      'status': status,
      'createdAt': createdAt,
    };
  }

  factory Pledge.fromJson(Map<String, dynamic> map) {
    return Pledge(
      id: map['id'] ?? "",
      amount: (map['amount'] == null) ? 0 : map['amount'].toDouble(),
      transaction: map['transaction'] ?? "",
      status: map['status'] ?? 0,
      createdAt: (map['createdAt'] == null)
          ? DateTime(2022)
          : (map['createdAt'] is DateTime)
              ? map['createdAt']
              : (map['createdAt'] is String)
                  ? DateTime.parse(map['createdAt'])
                  : DateTime.parse(map['createdAt'].toDate().toString()),
    );
  }

  static List<Pledge> fromJsonList(jsonList) {
    if (jsonList == null) return [];
    return jsonList.map<Pledge>((obj) => Pledge.fromJson(obj)).toList();
  }
}
