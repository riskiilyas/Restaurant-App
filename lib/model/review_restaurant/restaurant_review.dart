import '../detail_restaurant/customer_reviews.dart';

class RestaurantReview {
  RestaurantReview({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  RestaurantReview.fromJson(dynamic json) {
    error = json['error'];
    message = json['message'];
    if (json['customerReviews'] != null) {
      customerReviews = [];
      json['customerReviews'].forEach((v) {
        customerReviews.add(CustomerReviews.fromJson(v));
      });
    }
  }

  late bool error;
  late String message;
  late List<CustomerReviews> customerReviews;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['message'] = message;
    map['customerReviews'] = customerReviews.map((v) => v.toJson()).toList();
    return map;
  }
}
