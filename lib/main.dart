import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app/data/Data.dart';
import 'package:restaurant_app/widget/restaurant_item.dart';
import 'package:restaurant_app/widget/sliver_app_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resturant App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Restaurant App'),
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
  Data? _data;

  _MyHomePageState() {
    initData();
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return Scaffold(
      body: SingleChildScrollView(
          child: (_data != null)
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SliverPersistentHeader(
                        delegate: SliverAppBarDelegate(
                          child: Center(
                            child: Column(
                              children: const [
                                Text('Restaurant App'),
                                Text('Here is our Reccomendation for You')
                              ],
                            ),
                          ),
                        ),
                        pinned: true,
                      ),
                      SliverList(
                          delegate: SliverChildListDelegate(_data!.restaurants
                              .map((e) => RestaurantItem(restaurants: e))
                              .toList()))
                    ],
                  ),
                )
              : Column(
                  children: const [
                    Text('Failed to load data :(, Please Restart the App!')
                  ],
                )),
    );
  }

  Future initData() async {
    _data ??= Data.fromJson(
        json.decode(await rootBundle.loadString("assets/data.json")));
  }
}
