import 'package:flutter/material.dart';
import 'package:flutter_bookbee/screens/Profile/user_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            //physics: Mycustomphysics(),
            child: SafeArea(
              top: false,
              child: const Column(children: [Usercard(), SizedBox(height: 8)]),
            ),
          ),
        ),
      ],
    );
  }
}
