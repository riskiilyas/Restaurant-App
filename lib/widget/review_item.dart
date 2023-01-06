import 'package:flutter/material.dart';
import 'package:restaurant_app/model/detail_restaurant/customer_reviews.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({Key? key, required this.customerReviews}) : super(key: key);

  final CustomerReviews customerReviews;

  @override
  Widget build(BuildContext context) {
    var colors = [
      Colors.deepOrange,
      Colors.blueAccent,
      Colors.redAccent,
      Colors.green,
      Colors.pink,
      Colors.deepPurple,
      Colors.brown,
      Colors.black38,
      Colors.teal
    ];
    colors.shuffle();
    var color = colors[0];
    return Column(
      children: [
        const Divider(),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: Text(
                  customerReviews.name.characters.first,
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customerReviews.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    customerReviews.review,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Text(
                        customerReviews.date,
                        style: const TextStyle(fontSize: 10),
                      )),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
