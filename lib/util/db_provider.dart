import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurants.dart';
import 'db.dart';

class DbProvider extends ChangeNotifier {
  List<Restaurants> _restaurants = [];
  late DatabaseHelper _dbHelper;

  List<Restaurants> get restaurants => _restaurants;

  // DbProvider() {
  //   _dbHelper = DatabaseHelper();
  //   _getAllRestaurants();
  // }
  //
  // void _getAllRestaurants() async {
  //   _restaurants = await _dbHelper.getRestaurants();
  //   notifyListeners();
  // }
  //
  // Future<void> addRestaurant(Restaurants restaurants) async {
  //   await _dbHelper.insertRestaurant(restaurants);
  //   _getAllRestaurants();
  // }
  //
  // void deleteRestaurant(String id) async {
  //   await _dbHelper.deleteRestaurant(id);
  //   _getAllRestaurants();
  // }
}