import 'package:flutter/material.dart';
import 'package:flutter_bookbee/Widgets/stretch_physics.dart';
import 'package:flutter_bookbee/screens/Shelf/shelf_categories.dart';
import 'package:flutter_bookbee/screens/Shelf/shelf_header.dart';
//import 'package:flutter_bookbee/screens/Shelf/shelf_chips.dart';
//import 'package:flutter_bookbee/screens/Profile/user_card.dart';

class ShelfScreen extends StatefulWidget {
  const ShelfScreen({super.key});

  @override
  State<ShelfScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ShelfScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SafeArea(
            top: false,
            child: const Column(
              children: [
                ShelfChips(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: Mycustomphysics(),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 68),
                      child: ShelfCategories(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
