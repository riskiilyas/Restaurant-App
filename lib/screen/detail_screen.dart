
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/bloc_detail.dart';
import 'package:restaurant_app/widget/menu_card.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<RestaurantDetailBloc>(context);
    bloc.add(RestaurantEventDetail(id: id));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: BlocBuilder(
          builder: (context, state) {
            if(state is RestaurantStateDetailSuccess) {
              var restaurants = state.data.restaurant;
              return NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      title: Text(restaurants.name),
                      floating: true,
                      snap: true,
                    )
                  ];
                },
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      ClipRRect(
                          borderRadius:
                          const BorderRadius.vertical(bottom: Radius.circular(16)),
                          child: Hero(
                              tag: restaurants.pictureId,
                              child: Image.network(restaurants.pictureId))),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              restaurants.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  restaurants.city,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const Divider(),
                            const SizedBox(height: 12),
                            const Text(
                              'Description',
                              style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(restaurants.description),
                            const Divider(),
                            const SizedBox(
                              height: 12,
                            ),
                            const Text(
                              'Foods',
                              style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              height: 140,
                              child: ListView.builder(
                                itemBuilder: (context, i) {
                                  return MenuCard(
                                      name: restaurants.menus.foods[i].name);
                                },
                                itemCount: restaurants.menus.foods.length,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 12,
                            ),
                            const Text(
                              'Drinks',
                              style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              height: 140,
                              child: ListView.builder(
                                itemBuilder: (context, i) {
                                  return MenuCard(
                                      name: restaurants.menus.drinks[i].name);
                                },
                                itemCount: restaurants.menus.drinks.length,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                            const Divider()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else if(state is RestaurantStateDetailError) {
              return Text('');
            }
            return Text('');
          }
        ),
      ),
    );
  }
}
