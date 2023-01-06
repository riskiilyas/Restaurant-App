class Drinks {
  Drinks({
    required this.name,
  });

  Drinks.fromJson(dynamic json) {
    name = json['name'];
  }

  late String name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    return map;
  }
}
