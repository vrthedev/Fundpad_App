class AppUser {
  String id;
  String fullname;
  String email;
  String wallet;

  String referralCode;
  String address;
  String dialcode;
  String phone;
  bool notificationActive;
  DateTime createdAt;

  AppUser({
    required this.id,
    required this.fullname,
    required this.email,
    required this.referralCode,
    required this.address,
    required this.wallet,
    required this.dialcode,
    required this.phone,
    required this.notificationActive,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'referral_code': referralCode,
      'address': address,
      'wallet': wallet,
      'dialcode': dialcode,
      'phone': phone,
      'notification_active': notificationActive,
      'createdAt': createdAt,
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] ?? "",
      fullname: map['fullname'] ?? "",
      email: map['email'] ?? "",
      referralCode: map['referral_code'] ?? "",
      address: map['address'] ?? "",
      wallet: map['wallet'] ?? "",
      dialcode: map['dialcode'] ?? "",
      phone: map['phone'] ?? "",
      notificationActive: map['notification_active'] ?? false,
      createdAt: (map['created_at'] == null)
          ? DateTime(2022)
          : (map['createdAt'] is DateTime)
              ? map['createdAt']
              : (map['createdAt'] is String)
                  ? DateTime.parse(map['createdAt'])
                  : DateTime.parse(map['createdAt'].toDate().toString()),
    );
  }

  static List<AppUser> fromJsonList(jsonList) {
    if (jsonList == null) return [];
    return jsonList.map<AppUser>((obj) => AppUser.fromJson(obj)).toList();
  }
}
