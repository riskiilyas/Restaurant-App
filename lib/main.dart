import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:restaurant_app/bloc/bloc_list.dart';
import 'package:restaurant_app/data/data.dart';
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
        providers: [BlocProvider(create: (BuildContext) => RestaurantBloc())],
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
  RestaurantList? _restaurantList;

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<RestaurantBloc>(context);
    bloc.add(RestaurantEventList());
    FlutterNativeSplash.remove();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
          child: BlocBuilder<RestaurantBloc, RestaurantState>(
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

  Widget buildList(RestaurantState state) {
    if(state is RestaurantStateList) {
      return ListView.separated(
          itemBuilder: (context, i) => _restaurantList!.restaurants
              .map((e) => RestaurantItem(restaurants: e))
              .toList()[i],
          separatorBuilder: (ctx, id) => const SizedBox(),
          itemCount: _restaurantList!.restaurants.length);
    } else if(state is RestaurantStateError) {
      return Text('');
    }
    return Text('');
  }
}
