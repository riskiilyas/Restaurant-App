import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:restaurant_app/data/Data.dart';
import 'package:restaurant_app/widget/restaurant_item.dart';
import 'package:restaurant_app/widget/sliver_app_bar.dart';

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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: (_data != null)
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Text(
                        'Restaurant App',
                        style: TextStyle(),
                      ),
                      Text('Here is our Reccomendation for You!'),
                      Column(
                        children: _data!.restaurants
                            .map((e) => RestaurantItem(restaurants: e))
                            .toList(),
                      )
                    ]),
                  )
                : Expanded(
                  child: Container(
                    child: Center(
                        child: Text(
                    'Failed to load data :(\nPlease Restart the App!',
                    style: TextStyle(),
                      )),
                  ),
                )),
      ),
    );
  }

  Future initData() async {
    _data ??= Data.fromJson(
        json.decode(await rootBundle.loadString("assets/data.json")));
    setState((){});
    FlutterNativeSplash.remove();
  }
}
