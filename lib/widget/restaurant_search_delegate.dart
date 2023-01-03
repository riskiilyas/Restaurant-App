import 'package:flutter/material.dart';
import 'package:restaurant_app/data/restaurants.dart';
import 'package:restaurant_app/widget/restaurant_item.dart';

import '../data/data.dart';

class RestaurantSearchDelegate extends SearchDelegate {
  RestaurantSearchDelegate({Key? key, required this.data}) : super();

  final Data data;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {
        query = '';
      }, icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {
      close(context, null);
    }, icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Restaurants> list = [];
    for(var res in data.restaurants) {
      if(res.name.toLowerCase().contains(query.toLowerCase())) {
        list.add(res);
      }
    }

    return ListView.separated(
        itemBuilder: (context, i) =>
        list
            .map((e) => RestaurantItem(restaurants: e))
            .toList()[i],
        separatorBuilder: (ctx, id) => const SizedBox(),
        itemCount: list.length);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
