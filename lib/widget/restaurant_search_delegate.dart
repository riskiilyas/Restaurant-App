import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/bloc_list.dart';
import 'package:restaurant_app/bloc/bloc_search.dart';
import 'package:restaurant_app/widget/restaurant_item.dart';

class RestaurantSearchDelegate extends SearchDelegate {

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
    var bloc = BlocProvider.of<RestaurantSearchBloc>(context);
    bloc.add(RestaurantEventSearch(query: query));

    return BlocBuilder(
      builder: (context, state) {
        if (state is RestaurantStateSearchSuccess) {
          var list = state.data.restaurants;
            ListView.separated(
              itemBuilder: (context, i) =>
              list
                  .map((e) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: RestaurantItem(restaurants: e),
              ))
                  .toList()[i],
              separatorBuilder: (ctx, id) => const SizedBox(),
              itemCount: list.length);
        } else if(state is RestaurantStateSearchError) {

        }
        return Text('');
      }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
