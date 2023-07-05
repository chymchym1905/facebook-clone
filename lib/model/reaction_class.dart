import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class Reaction {
  final String key;
  final AnimationController controller;
  final Color color;
  final Animation<double> animation;

  Reaction(this.key,
      {required this.animation, required this.controller, required this.color});

  String get gif => "assets/images/$key.gif";

  String get png => "assets/images/$key.png";

  String get text => key.substring(0, 1).toUpperCase() + key.substring(1);

  TickerFuture reverse({double? from}) => controller.reverse(from: from);

  TickerFuture forward({double? from}) => controller.forward(from: from);
}