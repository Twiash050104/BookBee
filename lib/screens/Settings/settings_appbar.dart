import 'package:flutter/material.dart';

import 'package:flutter_bookbee/Widgets/glassback_button.dart';

class SettingHeader extends StatelessWidget {
  const SettingHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: AppBar(
            leading: GlassBackButton(),

            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            title: Text(
              'Settings',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
        ),
      ],
    );
  }
}
