import 'dart:ui';

import 'package:flutter/material.dart';

class FrostedGlassContainer extends StatelessWidget {
  const FrostedGlassContainer({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius = 28,
    this.blur = 10,
  });

  final Widget child;
  final double width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double blur;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          margin: margin,
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(borderRadius),
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
          child: child,
        ),
      ),
    );
  }
}
