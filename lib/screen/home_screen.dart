import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/bloc/bloc_list.dart';
import 'package:restaurant_app/bloc/bloc_search.dart';
import 'package:restaurant_app/bloc/bloc_favorite.dart';
import 'package:restaurant_app/screen/favorite_screen.dart';
import 'package:restaurant_app/screen/setting_screen.dart';
import 'package:restaurant_app/widget/restaurant_item.dart';
import 'package:restaurant_app/widget/restaurant_search_delegate.dart';

import '../bloc/bloc_detail.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  late RestaurantListBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<RestaurantListBloc>(context);
    bloc.add(RestaurantEventList());
    FlutterNativeSplash.remove();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: SafeArea(child:
            BlocBuilder<RestaurantListBloc, RestaurantStateList>(
                builder: (context, state) {
          return NestedScrollView(
            headerSliverBuilder: (context2, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  actions: [
                    IconButton(
                        onPressed: () {
                          showSearch(
                            context: context,
                            delegate: RestaurantSearchDelegate(
                                bloc: BlocProvider.of<RestaurantSearchBloc>(
                                    context),
                                onSearch: (q) {
                                  Get.to(() => MultiBlocProvider(
                                      providers: [
                                        BlocProvider.value(value: BlocProvider.of<RestaurantDetailBloc>(context)),
                                        BlocProvider.value(value: BlocProvider.of<FavoriteBloc>(context))
                                      ],
                                      child: DetailScreen(id: q)));
                                }),
                          );
                        },
                        icon: const Icon(Icons.search)),
                    IconButton(onPressed: () {
                      Get.to(() => MultiBlocProvider(
                          providers: [
                            BlocProvider.value(value: BlocProvider.of<RestaurantDetailBloc>(context)),
                            BlocProvider.value(value: BlocProvider.of<FavoriteBloc>(context))
                          ],
                          child: FavoriteScreen()));
                    }, icon: const Icon(Icons.favorite)),
                    IconButton(onPressed: () {
                      Get.to(() => const SettingScreen());
                    }, icon: const Icon(Icons.settings)),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    title: const Text("Restaurant App"),
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
                padding: const EdgeInsets.all(8.0), child: buildList(state)),
          );
        })));
  }

  Widget buildList(RestaurantStateList state) {
    if (state is RestaurantStateListSuccess) {
      return ListView.separated(
          itemBuilder: (context, i) => state.data.restaurants
              .map((e) => RestaurantItem(
                    restaurants: e,
                    onClicked: (id) {
                      Get.to(() => MultiBlocProvider(
                          providers: [
                            BlocProvider.value(value: BlocProvider.of<RestaurantDetailBloc>(context)),
                            BlocProvider.value(value: BlocProvider.of<FavoriteBloc>(context))
                          ],
                          child: DetailScreen(id: id)));
                    },
                  ))
              .toList()[i],
          separatorBuilder: (ctx, id) => const SizedBox(),
          itemCount: state.data.restaurants.length);
    } else if (state is RestaurantStateListError) {
      return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Failed to Load Data',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => bloc.add(RestaurantEventList()),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.deepOrange,
                ),
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        'Click here to refresh!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
    return const SpinKitWave(
      color: Colors.deepOrange,
      size: 64,
    );
  }
}
