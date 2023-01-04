class Restaurants {
  Restaurants({
      required this.id,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.rating,});

  Restaurants.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    pictureId = json['pictureId'];
    city = json['city'];
    rating = json['rating'];
  }
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late dynamic rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['pictureId'] = pictureId;
    map['city'] = city;
    map['rating'] = rating;
    return map;
  }

}