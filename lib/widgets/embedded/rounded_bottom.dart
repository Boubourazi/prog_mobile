import 'package:flutter/material.dart';

class RoundedBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height - 80)
      ..quadraticBezierTo(
          size.width / 2, size.height - 50, size.width, size.height - 80)
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
