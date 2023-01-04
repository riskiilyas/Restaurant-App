class CustomerReviews {
  CustomerReviews({
      required this.name,
      required this.review,
      required this.date,});

  CustomerReviews.fromJson(dynamic json) {
    name = json['name'];
    review = json['review'];
    date = json['date'];
  }
  late String name;
  late String review;
  late String date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['review'] = review;
    map['date'] = date;
    return map;
  }

}