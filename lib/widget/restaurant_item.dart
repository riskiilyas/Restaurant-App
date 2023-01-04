import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:restaurant_app/bloc/bloc_detail.dart';
import 'package:restaurant_app/widget/toast_layout.dart';

import '../screen/detail_screen.dart';
import '../model/restaurants.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurants restaurants;

  const RestaurantItem({Key? key, required this.restaurants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        var fToast = FToast();
        fToast.init(context);

        fToast.showToast(
          child: ToastLayout(msg: restaurants.name),
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 2),
        );

        Get.to(() => BlocProvider.value(
            value: BlocProvider.of<RestaurantDetailBloc>(context),
            child: DetailScreen(id: restaurants.id))
        );      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        height: 100,
        child: Row(
          children: [
            Expanded(
              flex: 0,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Hero(
                    tag: restaurants.pictureId,
                    child: Image.network(
                      "https://restaurant-api.dicoding.dev/images/medium/${restaurants.pictureId}",
                      height: 100,
                      width: 140,
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.fill,
                    ),
                  )),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurants.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 14,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(restaurants.city),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 14,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(restaurants.rating.toString())
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
