class Pledge {
  String id;
  double amount;
  int status;
  DateTime createdAt;

  Pledge({
    required this.id,
    required this.amount,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'status': status,
      'createdAt': createdAt,
    };
  }

  factory Pledge.fromJson(Map<String, dynamic> map) {
    return Pledge(
      id: map['id'] ?? "",
      amount: (map['amount'] == null) ? 0 : map['amount'].toDouble(),
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
