import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app/data/Restaurants.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.restaurants}) : super(key: key);

  final Restaurants restaurants;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  children: [
                    Text(
                      restaurants.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
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
                    ),
                    const Text(
                      'Description',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(restaurants.description)
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
