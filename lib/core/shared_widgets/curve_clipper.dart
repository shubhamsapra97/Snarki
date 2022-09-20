import 'dart:ui';

import 'package:flutter/material.dart';

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, size.height/5);
    path.lineTo(size.width/4, size.height/2.5);
    path.lineTo(size.width/4, size.height/1.8);
    path.lineTo(size.width/3, size.height/1.9);
    path.lineTo(size.width/1.8, size.height/1.4);
    path.lineTo(size.width/1.8, size.height);
    path.lineTo(size.width/1.2, size.height/1.2);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}