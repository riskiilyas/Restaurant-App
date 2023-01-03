import 'package:restaurant_app/data/Restaurants.dart';
import 'package:flutter/material.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurants restaurants;

  const RestaurantItem({Key? key, required this.restaurants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      height: 100,
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                restaurants.pictureId,
                height: 100,
                width: 140,
                alignment: Alignment.centerLeft,
                fit: BoxFit.fill,
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(restaurants.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    const SizedBox(height: 2,),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.red,size: 14,),
                        const SizedBox(width: 4,),
                        Text(restaurants.city),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber,size: 14,),
                    const SizedBox(width: 4,),
                    Text(restaurants.rating.toString())
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
