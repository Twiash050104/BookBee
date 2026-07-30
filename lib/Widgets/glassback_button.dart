import 'dart:ui';

import 'package:flutter/material.dart';

class GlassBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const GlassBackButton({super.key, this.onPressed});

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
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black87,
              size: 20,
            ),
            onPressed:
                onPressed ??
                () => Navigator.popUntil(context, (route) => route.isFirst),
          ),
        ),
      ),
    );
  }
}
