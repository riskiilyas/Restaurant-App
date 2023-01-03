import 'restaurants.dart';
class Data {
  Data({
      required this.restaurants,});

  Data.fromJson(dynamic json) {
    if (json['restaurants'] != null) {
      restaurants = [];
      json['restaurants'].forEach((v) {
        restaurants.add(Restaurants.fromJson(v));
      });
    }
  }
  late List<Restaurants> restaurants;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['restaurants'] = restaurants.map((v) => v.toJson()).toList();
    return map;
  }

}