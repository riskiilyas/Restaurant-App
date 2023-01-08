import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/bloc/bloc_favorite.dart';

import '../bloc/bloc_detail.dart';
import '../widget/restaurant_item.dart';
import '../widget/restaurant_search_delegate.dart';
import 'detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<FavoriteBloc>(context);
    bloc.add(FavoriteEventGet());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: SafeArea(child: BlocBuilder(
          bloc: bloc,
          builder: (context1, state) {
            if (state is FavoriteStateRestaurants) {
              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      backgroundColor: Colors.deepOrange,
                      actions: [
                        IconButton(
                            onPressed: () {
                              showSearch(
                                context: context,
                                delegate: RestaurantSearchDelegate(
                                  onSearch: (q) {
                                   toDetail(context, q);
                                  },
                                  restaurants: state.data
                                ),
                              );
                            },
                            icon: const Icon(Icons.search))
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        title: const Text("Favorites"),
                        background: Container(
                          color: Colors.deepOrange,
                        ),
                      ),
                      expandedHeight: 150,
                      pinned: true,
                    )
                  ];
                },
                body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                        itemBuilder: (context2, i) => state.data
                            .map((e) => Dismissible(
                                  key: Key(e.id),
                                  background: Container(
                                    color: Colors.white,
                                  ),
                                  onDismissed: (direction) {
                                    bloc.add(FavoriteEventDelete(id: e.id));
                                  },
                                  child: RestaurantItem(
                                    onClicked: (q) {
                                      toDetail(context, q);
                                    },
                                    restaurants: e,
                                  ),
                                ))
                            .toList()[i],
                        separatorBuilder: (ctx, id) => const SizedBox(),
                        itemCount: state.data.length)),
              );
            } else if (state is FavoriteStateLoading) {
              return const Center(
                child: SpinKitWave(
                  color: Colors.deepOrange,
                  size: 64,
                ),
              );
            } else {
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Failed to Load Data!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () => bloc.add(FavoriteEventGet()),
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
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
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
          },
        )));
  }

  void toDetail(BuildContext context, String id) {
    Get.to(() => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: BlocProvider.of<RestaurantDetailBloc>(context)),
          BlocProvider.value(value: BlocProvider.of<FavoriteBloc>(context)),
        ],
        child: DetailScreen(id: id)));
  }
}
