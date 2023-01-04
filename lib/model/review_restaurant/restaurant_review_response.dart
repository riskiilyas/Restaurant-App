import 'package:restaurant_app/model/restaurants.dart';

class RestaurantReviewResponse {
  RestaurantReviewResponse({
      required this.error,
      required this.founded,
      required this.restaurants,});

  RestaurantReviewResponse.fromJson(dynamic json) {
    error = json['error'];
    founded = json['founded'];
    if (json['restaurants'] != null) {
      restaurants = [];
      json['restaurants'].forEach((v) {
        restaurants.add(Restaurants.fromJson(v));
      });
    }
  }
  late bool error;
  late int founded;
  late List<Restaurants> restaurants;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['founded'] = founded;
    map['restaurants'] = restaurants.map((v) => v.toJson()).toList();
    return map;
  }

}