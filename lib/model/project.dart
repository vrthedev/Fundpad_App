class Project {
  String id;
  String name;
  String depositAddress;
  double fundTarget;
  double fundRaised;
  bool isActive;
  DateTime endDate;

  Project({
    required this.id,
    required this.name,
    required this.depositAddress,
    required this.isActive,
    required this.fundTarget,
    required this.fundRaised,
    required this.endDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'deposit_address': depositAddress,
      'isActive': isActive,
      'fund_target': fundTarget,
      'fund_raised': fundRaised,
      'endDate': endDate,
    };
  }

  factory Project.fromJson(Map<String, dynamic> map) {
    return Project(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      depositAddress: map['deposit_address'] ?? "",
      isActive: map['isActive'] ?? false,
      fundTarget:
          (map['fund_target'] == null) ? 0 : map['fund_target'].toDouble(),
      fundRaised:
          (map['fund_raised'] == null) ? 0 : map['fund_raised'].toDouble(),
      endDate: (map['endDate'] == null)
          ? DateTime(2022)
          : (map['endDate'] is DateTime)
              ? map['endDate']
              : (map['endDate'] is String)
                  ? DateTime.parse(map['endDate'])
                  : DateTime.parse(map['endDate'].toDate().toString()),
    );
  }

  static List<Project> fromJsonList(jsonList) {
    if (jsonList == null) return [];
    return jsonList.map<Project>((obj) => Project.fromJson(obj)).toList();
  }
}
