import 'dart:convert';

import 'package:restaurant_app/model/list_restaurant/restaurant_list.dart';
import 'package:restaurant_app/model/search_restaurant/restaurant_search.dart';

import '../model/detail_restaurant/restaurant_detail.dart';
import 'package:http/http.dart' as http;

class Network {
  static const _baseurl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantDetail> getDetail(String id) async {
    final result = await http.Client().get(Uri.parse('$_baseurl/detail/$id'));
    if(result.statusCode>=400) throw Exception();
    return RestaurantDetail.fromJson(result.body);
  }

  Future<RestaurantList> getList() async {
    final result = await http.Client().get(Uri.parse('$_baseurl/list'));
    if(result.statusCode>=400) throw Exception();
    return RestaurantList.fromJson(result.body);
  }

  Future<SearchRestaurant> getSearch(String query) async {
    final result = await http.Client().get(Uri.parse('$_baseurl/search?q=$query'));
    if(result.statusCode>=400) throw Exception();
    return SearchRestaurant.fromJson(result.body);
  }

}