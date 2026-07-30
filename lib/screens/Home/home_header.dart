import 'package:flutter/material.dart';

void main() {
  runApp(HomeHeader());
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: 'Book',
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: 'Bee',
                  style: TextStyle(color: Color(0xFFFE9A34)),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.hive_rounded, size: 28),
          ),
        ],
      ),
    );
  }
}
