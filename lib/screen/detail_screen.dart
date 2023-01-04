import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:restaurant_app/bloc/bloc_detail.dart';
import 'package:restaurant_app/widget/menu_card.dart';
import 'package:restaurant_app/widget/review_item.dart';

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
            bloc: bloc,
            builder: (context, state) {
              if (state is RestaurantStateDetailSuccess) {
                var restaurants = state.data.restaurant;
                return NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        title: Text(restaurants.name),
                        backgroundColor: Colors.deepOrange,
                        floating: true,
                        snap: true,
                      )
                    ];
                  },
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(16)),
                          child: Hero(
                              tag: restaurants.pictureId,
                              child: Image.network(
                                  "https://restaurant-api.dicoding.dev/images/large/${restaurants.pictureId}")),
                        ),
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
                              const SizedBox(height: 4,),
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
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
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
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
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
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
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
                              const Divider(),
                              const SizedBox(height: 12,),
                              const Text(
                                'Reviews',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),                          SizedBox(
                                child: ListView.builder(
                                  itemBuilder: (ctx, i) {
                                    return ReviewItem(
                                        customerReviews:
                                            restaurants.customerReviews[i]);
                                  },
                                  itemCount: restaurants.customerReviews.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else if (state is RestaurantStateDetailError) {
                return SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Error: ${state.msg}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () => bloc.add(RestaurantEventDetail(id: id)),
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
              return const Center(
                child: SpinKitWave(
                  color: Colors.deepOrange,
                  size: 64,
                ),
              );
            }),
      ),
    );
  }
}
