


import 'package:airtel_lms/utils/app_theme.dart';
import 'package:flutter/material.dart';

class CustomClipperWidget extends CustomClipper<Path> {


  final double bottom;
  final double holeRadius;
  CustomClipperWidget({required this.bottom, required this.holeRadius});
  @override
  Path getClip(Size size) {

    final path = Path()
      ..moveTo(0, 0)

      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height - 100)
      ..arcToPoint(
        Offset(size.width, size.height -100 - holeRadius),
        clockwise: true,
        radius: Radius.circular(1),
      )

    ..lineTo(size.width-15, size.height-25)
    ..arcToPoint(
    Offset(size.width-15, size.height - 35 - holeRadius),
    clockwise: true,
    radius: Radius.circular(1),
    );


    path.lineTo(size.width, 0.0);

    path.close();


    return path;
  }

  @override
  bool shouldReclip(CustomClipperWidget oldClipper) => true;
}