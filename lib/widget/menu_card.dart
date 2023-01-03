import 'package:restaurant_app/data/Menus.dart';
import 'package:restaurant_app/data/Restaurants.dart';
import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: 140,
        width: 140,
        child: Stack(
          children: [
            Image.asset(
              'assets/menu.png',
              height: 140,
            ),
            Align(
              alignment: AlignmentDirectional.bottomStart,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    const Text(
                      'IDR.XX.XXX,XX',
                      style: TextStyle(color: Colors.white, fontSize: 8),
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
