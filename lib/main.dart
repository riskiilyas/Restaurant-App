import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:restaurant_app/data/Data.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.deepOrange,
        ),
      ),
      body: SafeArea(
          child: (_data != null)
              ? NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  actions: [
                    IconButton(
                        onPressed: () {
                          showSearch(context: context,
                            delegate: RestaurantSearchDelegate(data: _data!),);
                        }, icon: const Icon(Icons.search))
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text("Restaurant App"),
                    background: Image.asset(
                      'assets/header.png',
                      fit: BoxFit.fill,
                    ),
                    titlePadding: const EdgeInsets.only(left: 8, bottom: 16),
                  ),
                  expandedHeight: 200,
                  pinned: true,
                )
              ];
            },
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                  itemBuilder: (context, i) =>
                  _data!.restaurants
                      .map((e) => RestaurantItem(restaurants: e))
                      .toList()[i],
                  separatorBuilder: (ctx, id) => const SizedBox(),
                  itemCount: _data!.restaurants.length),
            ),
          )
              : const Center(
                  child: Text(
                    'Failed to load data :(\nPlease Restart the App!',
                    style: TextStyle(),
                  ))),
    );
  }

  void initData() async {
    _data ??= Data.fromJson(
        json.decode(await rootBundle.loadString("assets/data.json")));
    setState(() {
      FlutterNativeSplash.remove();
    });
  }
}
