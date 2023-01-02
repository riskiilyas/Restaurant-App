import 'package:restaurant_app/data/Restaurants.dart';
import 'package:flutter/material.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurants restaurants;

  const RestaurantItem({Key? key, required this.restaurants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Image.network(restaurants.pictureId, height: 100,),
          Column(
            children: [
              Text(restaurants.name),
              Text(restaurants.city),
              Text(restaurants.rating.toString())
            ],
          )
        ],
      ),
    );
  }
}
