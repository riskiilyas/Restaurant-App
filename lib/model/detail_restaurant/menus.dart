import 'foods.dart';
import 'drinks.dart';

class Menus {
  Menus({
      required this.foods,
      required this.drinks,});

  Menus.fromJson(dynamic json) {
    if (json['foods'] != null) {
      foods = [];
      json['foods'].forEach((v) {
        foods.add(Foods.fromJson(v));
      });
    }
    if (json['drinks'] != null) {
      drinks = [];
      json['drinks'].forEach((v) {
        drinks.add(Drinks.fromJson(v));
      });
    }
  }
  late List<Foods> foods;
  late List<Drinks> drinks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['foods'] = foods.map((v) => v.toJson()).toList();
    map['drinks'] = drinks.map((v) => v.toJson()).toList();
    return map;
  }

}