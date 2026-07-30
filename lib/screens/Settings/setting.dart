import 'package:flutter/material.dart';
import 'package:flutter_bookbee/screens/Settings/settings_actions.dart';
import 'package:flutter_bookbee/screens/Settings/settings_appbar.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SettingHeader(),
            Expanded(child: SingleChildScrollView(child: SettingsActions())),
          ],
        ),
      ),
    );
  }
}
