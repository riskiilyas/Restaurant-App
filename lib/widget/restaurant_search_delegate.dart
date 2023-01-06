import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:restaurant_app/bloc/bloc_search.dart';
import 'package:restaurant_app/widget/restaurant_item.dart';

class RestaurantSearchDelegate extends SearchDelegate {
  RestaurantSearchDelegate({required this.bloc, required this.onSearch});

  final RestaurantSearchBloc bloc;
  final Function(String) onSearch;

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
    if (query.isNotEmpty) {
      bloc.add(RestaurantEventSearch(query: query));
    }

    return BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is RestaurantStateSearchSuccess) {
            var list = state.data.restaurants;
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
          } else if (state is RestaurantStateSearchError) {
            return Center(
                child: Text(state.msg == null ? "" : "Error: ${state.msg}"));
          } else if (state is RestaurantStateSearchLoading) {
            return const Center(
              child: SpinKitWave(
                color: Colors.deepOrange,
                size: 64,
              ),
            );
          }
          return Container();
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
