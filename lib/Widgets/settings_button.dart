import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bookbee/screens/Settings/setting.dart';

class GlassSettingsButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const GlassSettingsButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: Colors.black.withOpacity(0.09),
              width: 0.9,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                spreadRadius: 0.3,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingScreen()),
              );
            },
            icon: const Icon(Icons.settings, size: 32, color: Colors.black87),
          ),
        ),
      ),
    );
  }
}
