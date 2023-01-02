import 'Menus.dart';

class Restaurants {
  Restaurants({
      required this.id,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.rating,
      required this.menus,});

  Restaurants.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    pictureId = json['pictureId'];
    city = json['city'];
    rating = json['rating'];
    menus = (json['menus'] != null ? Menus.fromJson(json['menus']) : null)!;
  }
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late dynamic rating;
  late Menus menus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['pictureId'] = pictureId;
    map['city'] = city;
    map['rating'] = rating;
    if (menus != null) {
      map['menus'] = menus.toJson();
    }
    return map;
  }

}