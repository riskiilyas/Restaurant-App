class Foods {
  Foods({
      required this.name,});

  Foods.fromJson(dynamic json) {
    name = json['name'];
  }
  late String name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    return map;
  }

}