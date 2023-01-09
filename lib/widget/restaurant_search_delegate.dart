import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:restaurant_app/bloc/bloc_search.dart';
import 'package:restaurant_app/widget/restaurant_item.dart';

import '../model/restaurants.dart';

class RestaurantSearchDelegate extends SearchDelegate {
  RestaurantSearchDelegate(
      {this.bloc, required this.onSearch, this.restaurants});

  final RestaurantSearchBloc? bloc;
  final Function(String) onSearch;
  final List<Restaurants>? restaurants;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (bloc != null && query.isNotEmpty) {
      bloc!.add(RestaurantEventSearch(query: query));
    }

    return (restaurants == null)
        ? BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if (state is RestaurantStateSearchSuccess) {
                var list = state.data.restaurants;
                return ListView.separated(
                    itemBuilder: (context, i) => list
                        .map((e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: RestaurantItem(
                                restaurants: e,
                                onClicked: onSearch,
                              ),
                            ))
                        .toList()[i],
                    separatorBuilder: (ctx, id) => const SizedBox(),
                    itemCount: list.length);
              } else if (state is RestaurantStateSearchError) {
                return const Center(child: Text("Failed to Load Data!"));
              } else if (state is RestaurantStateSearchLoading) {
                return const Center(
                  child: SpinKitWave(
                    color: Colors.deepOrange,
                    size: 64,
                  ),
                );
              }
              return Container();
            })
        : match();
  }

  Widget match() {
    var list = [];

    for (var res in restaurants!) {
      if (res.name.toLowerCase().contains(query.toLowerCase())) list.add(res);
    }

    return ListView.separated(
        itemBuilder: (context, i) => list
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: RestaurantItem(
                    restaurants: e,
                    onClicked: onSearch,
                  ),
                ))
            .toList()[i],
        separatorBuilder: (ctx, id) => const SizedBox(),
        itemCount: list.length);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
