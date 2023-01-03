import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant_app/widget/toast_layout.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () {
          var fToast = FToast();
          fToast.init(context);

          fToast.showToast(
            child: ToastLayout(msg: name),
            gravity: ToastGravity.BOTTOM,
            toastDuration: const Duration(seconds: 2),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: 140,
            width: 140,
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/menu.png',
                    height: 140,
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
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
        ),
      ),
    );
  }
}
