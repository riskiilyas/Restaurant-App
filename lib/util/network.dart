import 'dart:convert';

import 'package:restaurant_app/model/list_restaurant/restaurant_list.dart';
import 'package:restaurant_app/model/review_restaurant/restaurant_review.dart';
import 'package:restaurant_app/model/search_restaurant/restaurant_search.dart';

import '../model/detail_restaurant/restaurant_detail.dart';
import 'package:http/http.dart' as http;

class Network {
  static const _baseurl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantDetail> getDetail(String id) async {
    final result = await http.Client().get(Uri.parse('$_baseurl/detail/$id'));
    if(result.statusCode>=400) throw Exception();
    return RestaurantDetail.fromJson(json.decode(result.body));
  }

  Future<RestaurantList> getList() async {
    final result = await http.Client().get(Uri.parse('$_baseurl/list'));
    if(result.statusCode>=400) throw Exception();
    return RestaurantList.fromJson(json.decode(result.body));
  }

  Future<SearchRestaurant> getSearch(String query) async {
    final result = await http.Client().get(Uri.parse('$_baseurl/search?q=$query'));
    if(result.statusCode>=400) throw Exception(result.statusCode.toString());
    return SearchRestaurant.fromJson(json.decode(result.body));
  }

  Future<RestaurantReview> postReview(String id, String name, String review) async {
     var result = await http.post(
      Uri.parse('$_baseurl/review'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'name': name,
        'review': review
      }),
    );
    if(result.statusCode>=400) throw Exception(result.statusCode.toString());
    return RestaurantReview.fromJson(json.decode(result.body));
  }

}