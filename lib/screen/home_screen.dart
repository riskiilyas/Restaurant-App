import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:restaurant_app/bloc/bloc_list.dart';
import 'package:restaurant_app/bloc/bloc_search.dart';
import 'package:restaurant_app/widget/restaurant_item.dart';
import 'package:restaurant_app/widget/restaurant_search_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<RestaurantListBloc>(context);
    bloc.add(RestaurantEventList());
    FlutterNativeSplash.remove();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: SafeArea(
            child: BlocBuilder<RestaurantListBloc, RestaurantStateList>(
                builder: (context, state) {
                  return NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          actions: [
                            IconButton(
                                onPressed: () {
                                  showSearch(
                                    context: context,
                                    delegate:
                                    RestaurantSearchDelegate(bloc: BlocProvider.of<RestaurantSearchBloc>(context)),
                                  );
                                },
                                icon: const Icon(Icons.search))
                          ],
                          flexibleSpace: FlexibleSpaceBar(
                            title: const Text("Restaurant App"),
                            background: Image.asset(
                              'assets/header.png',
                              fit: BoxFit.fill,
                            ),
                            titlePadding:
                            const EdgeInsets.only(left: 8, bottom: 16),
                          ),
                          expandedHeight: 200,
                          pinned: true,
                        )
                      ];
                    },
                    body: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildList(state)
                    ),
                  );
                }
            )
        )
    );
  }

  Widget buildList(RestaurantStateList state) {
    if(state is RestaurantStateListSuccess) {
      return ListView.separated(
          itemBuilder: (context, i) => state.data.restaurants
              .map((e) => RestaurantItem(restaurants: e))
              .toList()[i],
          separatorBuilder: (ctx, id) => const SizedBox(),
          itemCount: state.data.restaurants.length);
    } else if(state is RestaurantStateSearchError) {
      return Text('');
    }
    return Text('');
  }
}
