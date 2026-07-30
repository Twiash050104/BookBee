import 'package:flutter/material.dart';
import 'package:flutter_bookbee/Widgets/stretch_physics.dart';
import 'package:flutter_bookbee/screens/Home/new_from_friends.dart';
import '../Home/home_header.dart';
import '../Home/top_books.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: HomeHeader(),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: Mycustomphysics(),
            child: Column(children: [TopBooks(), NewFromFriends()]),
          ),
        ),
      ],
    );
  }
}
