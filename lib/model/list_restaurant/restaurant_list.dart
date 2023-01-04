import '../restaurants.dart';

class RestaurantList {
  RestaurantList({
      required this.error,
      required this.message,
      required this.count,
      required this.restaurants,});

  RestaurantList.fromJson(dynamic json) {
    error = json['error'];
    message = json['message'];
    count = json['count'];
    if (json['restaurants'] != null) {
      restaurants = [];
      json['restaurants'].forEach((v) {
        restaurants.add(Restaurants.fromJson(v));
      });
    }
  }
  late bool error;
  late String message;
  late int count;
  late List<Restaurants> restaurants;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['message'] = message;
    map['count'] = count;
    map['restaurants'] = restaurants.map((v) => v.toJson()).toList();
    return map;
  }

}