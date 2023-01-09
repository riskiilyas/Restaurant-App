import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/bloc/bloc_detail.dart';
import 'package:restaurant_app/bloc/bloc_favorite.dart';
import 'package:restaurant_app/bloc/bloc_list.dart';
import 'package:restaurant_app/bloc/bloc_search.dart';
import 'package:restaurant_app/bloc/bloc_settings.dart';
import 'package:restaurant_app/screen/home_screen.dart';
import 'package:restaurant_app/util/background_service.dart';
import 'package:restaurant_app/util/date_time_helper.dart';
import 'package:restaurant_app/util/notification_helper.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  AndroidAlarmManager.periodic(
    const Duration(hours: 24),
    1,
    BackgroundService.callback,
    startAt: DateTimeHelper.format(),
    exact: true,
    wakeup: true,
  );
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
              primaryColor: Colors.deepOrange),
          home: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => RestaurantListBloc()),
              BlocProvider(create: (_) => RestaurantDetailBloc()),
              BlocProvider(create: (_) => RestaurantSearchBloc()),
              BlocProvider(create: (_) => FavoriteBloc()),
              BlocProvider(create: (_) => SettingBloc())
            ],
            child: const HomeScreen(title: 'Restaurant App'),
          )),
    );
  }
}
