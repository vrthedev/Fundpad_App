class Faq {
  String id;
  String title;
  String content;
  DateTime createdAt;

  Faq({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt,
    };
  }

  factory Faq.fromJson(Map<String, dynamic> map) {
    return Faq(
      id: map['id'] ?? "",
      title: map['title'] ?? "",
      content: map['content'] ?? "",
      createdAt: (map['createdAt'] == null)
          ? DateTime(2022)
          : (map['createdAt'] is DateTime)
              ? map['createdAt']
              : (map['createdAt'] is String)
                  ? DateTime.parse(map['createdAt'])
                  : DateTime.parse(map['createdAt'].toDate().toString()),
    );
  }

  static List<Faq> fromJsonList(jsonList) {
    if (jsonList == null) return [];
    return jsonList.map<Faq>((obj) => Faq.fromJson(obj)).toList();
  }
}
