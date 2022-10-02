class Referee {
  String id;
  String fullname;
  String email;
  double confirmedAmount;
  double investorPayouts;

  Referee({
    required this.id,
    required this.fullname,
    required this.email,
    required this.confirmedAmount,
    required this.investorPayouts,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullname': fullname,
      'email': email,
      'confirmed_amount': confirmedAmount,
      'investor_payouts': investorPayouts,
    };
  }

  factory Referee.fromJson(Map<String, dynamic> map) {
    return Referee(
      id: map['_id'] ?? "",
      fullname: map['fullname'] ?? "",
      email: map['email'] ?? "",
      confirmedAmount: (map['confirmed_amount'] == null)
          ? 0
          : map['confirmed_amount'].toDouble(),
      investorPayouts: (map['investor_payouts'] == null)
          ? 0
          : map['investor_payouts'].toDouble(),
    );
  }

  static List<Referee> fromJsonList(jsonList) {
    if (jsonList == null) return [];
    return jsonList.map<Referee>((obj) => Referee.fromJson(obj)).toList();
  }
}
