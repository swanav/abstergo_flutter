import 'package:flutter/material.dart';

class CustomScrollPhysics extends ScrollPhysics {
  CustomScrollPhysics({
    ScrollPhysics parent,
    this.numOfItems = 5.0,
  }) : super(parent: parent);

  final double numOfItems;

  @override
  CustomScrollPhysics applyTo(ScrollPhysics ancestor) => CustomScrollPhysics(parent: buildParent(ancestor));
  
  double _getPage(ScrollPosition position) => position.pixels / (position.maxScrollExtent / numOfItems);

  double _getPixels(ScrollPosition position, double page) => page * (position.maxScrollExtent / numOfItems);
  
  double _getTargetPixels(
      ScrollPosition position, Tolerance tolerance, double velocity) {
    double page = _getPage(position);
    if (velocity < -tolerance.velocity)
      page -= 0.5;
    else if (velocity > tolerance.velocity) page += 0.5;
    return _getPixels(position, page.roundToDouble());
  }

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
      return super.createBallisticSimulation(position, velocity);
    final Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels)
      return new ScrollSpringSimulation(
          spring, position.pixels, target, velocity,
          tolerance: tolerance);
    return null;
  }
}
