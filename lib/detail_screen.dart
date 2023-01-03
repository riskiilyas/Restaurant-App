import 'package:flutter/material.dart';
import 'package:restaurant_app/data/restaurants.dart';
import 'package:restaurant_app/widget/menu_card.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.restaurants}) : super(key: key);

  final Restaurants restaurants;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                  borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(16)),
                  child: Image.network(restaurants.pictureId)),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12,),
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
                        const SizedBox(width: 2,),
                        Text(restaurants.city,
                          style: const TextStyle(fontSize: 16),),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 12),
                    const Text(
                      'Description',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8,),
                    Text(restaurants.description),
                    const Divider(),
                    const SizedBox(height: 12,),
                    const Text(
                      'Foods',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    const SizedBox(height: 8,),
                    SizedBox(
                      height: 140,
                      child: ListView.builder(itemBuilder: (context, i) {
                        return MenuCard(name: restaurants.menus.foods[i].name);
                      },
                        itemCount: restaurants.menus.foods.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 12,),
                    const Text(
                      'Drinks',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    const SizedBox(height: 8,),
                    SizedBox(
                      height: 140,
                      child: ListView.builder(itemBuilder: (context, i) {
                        return MenuCard(name: restaurants.menus.drinks[i].name);
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
      ),
    );
  }
}
