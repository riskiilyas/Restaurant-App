import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/bloc/bloc_detail.dart';
import 'package:restaurant_app/bloc/bloc_list.dart';
import 'package:restaurant_app/bloc/bloc_search.dart';
import 'package:restaurant_app/screen/home_screen.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MaterialApp(
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
          child: const HomeScreen(title: 'Restaurant App'),
        )
      ),
    );
  }
}
