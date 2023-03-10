import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant_app/bloc/bloc_detail.dart';
import 'package:restaurant_app/bloc/bloc_favorite.dart';
import 'package:restaurant_app/util/network.dart';
import 'package:restaurant_app/widget/menu_card.dart';
import 'package:restaurant_app/widget/review_item.dart';

import '../model/restaurants.dart';
import '../widget/toast_layout.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var isFav = false;
  late FavoriteBloc favbloc;
  late RestaurantDetailBloc bloc;

  @override
  void dispose() {
    bloc.add(RestaurantEvent());
    favbloc.add(FavoriteEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<RestaurantDetailBloc>(context);
    favbloc = BlocProvider.of<FavoriteBloc>(context);
    favbloc.add(FavoriteEventGet());
    bloc.add(RestaurantEventDetail(id: widget.id));
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final nameController = TextEditingController();
          final reviewController = TextEditingController();

          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('Write Your Review'),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: nameController,
                            cursorColor: Colors.deepOrange,
                            decoration: const InputDecoration(
                              hintText: 'Enter Your Name',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.deepOrange, width: 2)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.deepOrange)),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextField(
                            controller: reviewController,
                            cursorColor: Colors.deepOrange,
                            maxLines: 6,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                              hintText: 'Enter Your Review',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.deepOrange, width: 2)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.deepOrange)),
                            ),
                          )
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.black54),
                          )),
                      TextButton(
                          onPressed: () {
                            var fToast = FToast();
                            fToast.init(context);

                            var network = Network();
                            network
                                .postReview(widget.id, nameController.text,
                                    reviewController.text)
                                .then((result) {
                              fToast.showToast(
                                child: const ToastLayout(
                                    msg: 'Successfully Sent Your Review!'),
                                gravity: ToastGravity.BOTTOM,
                                toastDuration: const Duration(seconds: 2),
                              );
                              if (result.error) throw Exception();
                              bloc.add(RestaurantEventDetail(id: widget.id));
                            }).catchError((e) {
                              fToast.showToast(
                                child: const ToastLayout(
                                    msg: 'Failed Sending Review!'),
                                gravity: ToastGravity.BOTTOM,
                                toastDuration: const Duration(seconds: 2),
                              );
                            }).whenComplete(() => Navigator.pop(context));
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.deepOrange),
                          )),
                    ],
                  ));
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(
          Icons.reviews,
        ),
      ),
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
                        actions: [
                          IconButton(
                            onPressed: () {
                              if (bloc.state is RestaurantStateDetailSuccess) {
                                var data =
                                    (bloc.state as RestaurantStateDetailSuccess)
                                        .data
                                        .restaurant;
                                if (isFav) {
                                  favbloc.add(FavoriteEventDelete(id: data.id));
                                  isFav = false;
                                } else {
                                  favbloc.add(FavoriteEventInsert(
                                      restaurants: Restaurants(
                                          id: data.id,
                                          name: data.name,
                                          description: data.description,
                                          pictureId: data.pictureId,
                                          city: data.city,
                                          rating: data.rating)));
                                }
                              }
                            },
                            icon: BlocBuilder(
                              bloc: favbloc,
                              builder: (ctx, stateFav) {
                                if (stateFav is FavoriteStateRestaurants) {
                                  var data = (bloc.state
                                          as RestaurantStateDetailSuccess)
                                      .data
                                      .restaurant;
                                  for (var res in stateFav.data) {
                                    if (res.id == data.id) {
                                      isFav = true;
                                      break;
                                    }
                                  }
                                  if (isFav) return const Icon(Icons.favorite);
                                }
                                return const Icon(Icons.favorite_border);
                              },
                            ),
                          )
                        ],
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
                              const SizedBox(
                                height: 4,
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
                              const SizedBox(
                                height: 12,
                              ),
                              const Text(
                                'Reviews',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              BlocBuilder(
                                  bloc: bloc,
                                  builder: (context, stateReview) {
                                    var reviews = (stateReview
                                            is RestaurantStateDetailReview)
                                        ? stateReview.reviews
                                        : restaurants.customerReviews;
                                    return SizedBox(
                                      child: ListView.builder(
                                        itemBuilder: (ctx, i) {
                                          return ReviewItem(
                                              customerReviews: reviews[i]);
                                        },
                                        itemCount: reviews.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                      ),
                                    );
                                  })
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
                      const Text(
                        'Failed to Load Data!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () =>
                            bloc.add(RestaurantEventDetail(id: widget.id)),
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
