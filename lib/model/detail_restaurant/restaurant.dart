import 'categories.dart';
import 'menus.dart';
import 'customer_reviews.dart';

class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  Restaurant.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    city = json['city'];
    address = json['address'];
    pictureId = json['pictureId'];
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories.add(Categories.fromJson(v));
      });
    }
    menus = (json['menus'] != null ? Menus.fromJson(json['menus']) : null)!;
    rating = json['rating'];
    if (json['customerReviews'] != null) {
      customerReviews = [];
      json['customerReviews'].forEach((v) {
        customerReviews.add(CustomerReviews.fromJson(v));
      });
    }
  }

  late String id;
  late String name;
  late String description;
  late String city;
  late String address;
  late String pictureId;
  late List<Categories> categories;
  late Menus menus;
  late dynamic rating;
  late List<CustomerReviews> customerReviews;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['city'] = city;
    map['address'] = address;
    map['pictureId'] = pictureId;
    map['categories'] = categories.map((v) => v.toJson()).toList();
    map['menus'] = menus.toJson();
    map['rating'] = rating;
    map['customerReviews'] = customerReviews.map((v) => v.toJson()).toList();
    return map;
  }
}
