import 'package:flutter/material.dart';
import 'package:flutter_bookbee/screens/Profile/stats.dart';
import 'package:flutter_bookbee/screens/Profile/user_card.dart';
import '../Profile/personality.dart';
import '../Shelf/shelf.dart';
import 'Recommendations/section.dart';
import '../Settings/setting.dart';
import 'package:flutter_bookbee/Widgets/settings_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(
          child: SingleChildScrollView(
            //physics: Mycustomphysics(),
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  Usercard(),
                  SizedBox(height: 12),
                  ProfileStats(),
                  SizedBox(height: 18),
                  Personality(),
                  SizedBox(height: 22),
                  RecommendationSection(),
                  SizedBox(height: 68),
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GlassSettingsButton(),
            ),
          ),
        ),
      ],
    );
  }
}
