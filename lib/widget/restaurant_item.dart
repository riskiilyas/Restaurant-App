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
          ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                restaurants.pictureId,
                height: 100,
                width: 160,
                alignment: Alignment.centerLeft,
                fit: BoxFit.fill,
              )),
          const SizedBox(
            width: 12,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
