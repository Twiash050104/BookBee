import 'package:flutter/material.dart';

class Mycustomphysics extends BouncingScrollPhysics {
  const Mycustomphysics({super.parent});

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value < position.minScrollExtent) {
      return value - position.pixels;
    }
    return super.applyBoundaryConditions(position, value);
  }

  @override
  SpringDescription get spring =>
      const SpringDescription(mass: 1.0, stiffness: 150, damping: 20);
}
