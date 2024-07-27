import 'dart:math';

import 'package:flutter/material.dart';

class SnowflakePainter extends CustomPainter {
  final List<SnowSlake> snowfakes;

  SnowflakePainter(this.snowfakes);

  @override
  void paint(Canvas canvas, Size size) {
    final whitePaint = Paint()..color = Colors.white.withOpacity(0.4);
    // canvas.drawCircle(size.center(const Offset(0, 130)), 50, whitePaint);
    // canvas.drawOval(Rect.fromCenter(center: size.center(const Offset(0, 280)), width: 200, height: 250), whitePaint);
    for (var snowSlake in snowfakes) {
      canvas.drawCircle(Offset(snowSlake.x, snowSlake.y), snowSlake.radius, whitePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class SnowSlake {
  double x = Random().nextDouble() * 400;
  double y = Random().nextDouble() * 800;
  double radius = Random().nextDouble() * 2 + 2;
  double velocity = Random().nextDouble() * 4 + 2;

  fall() {
    y += velocity;
    if (y > 800) {
      y = 0;
      x = Random().nextDouble() * 400;
      radius = Random().nextDouble() * 2 + 2;
      velocity = Random().nextDouble() * 4 + 2;
    }
  }
}
