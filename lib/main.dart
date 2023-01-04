import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:restaurant_app/bloc/bloc_detail.dart';
import 'package:restaurant_app/bloc/bloc_list.dart';
import 'package:restaurant_app/bloc/bloc_search.dart';
import 'package:restaurant_app/model/list_restaurant/restaurant_list.dart';
import 'package:restaurant_app/widget/restaurant_item.dart';
import 'package:restaurant_app/widget/restaurant_search_delegate.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resturant App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => RestaurantListBloc()),
          BlocProvider(create: (_) => RestaurantDetailBloc()),
          BlocProvider(create: (_) => RestaurantSearchBloc()),
        ],
        child: const MyHomePage(title: 'Restaurant App'),
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
                                        RestaurantSearchDelegate(),
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
