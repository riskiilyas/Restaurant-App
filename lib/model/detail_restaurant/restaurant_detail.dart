import 'restaurant.dart';

class RestaurantDetail {
  RestaurantDetail({
      required this.error,
      required this.message,
      required this.restaurant,});

  RestaurantDetail.fromJson(dynamic json) {
    error = json['error'];
    message = json['message'];
    restaurant = (json['restaurant'] != null ? Restaurant.fromJson(json['restaurant']) : null)!;
  }
  late bool error;
  late String message;
  late Restaurant restaurant;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['message'] = message;
    map['restaurant'] = restaurant.toJson();
    return map;
  }

}