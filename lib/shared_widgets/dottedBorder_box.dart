import 'package:flutter/material.dart';

import '../core/utils/constants/colors.dart';

class DottedBorderBox extends StatelessWidget {
  final double strokeWidth;
  final double gap;
  final Color color;
  final double borderRadius;
  final Widget? child;

  const DottedBorderBox({
    super.key,
    this.strokeWidth = 2,
    this.gap = 6,
    this.color = DColors.primary,
    this.borderRadius = 20, // default corner radius
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedBorderPainter(
        strokeWidth: strokeWidth,
        gap: gap,
        color: color,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

class _DottedBorderPainter extends CustomPainter {
  final double strokeWidth;
  final double gap;
  final Color color;
  final double borderRadius;

  _DottedBorderPainter({
    required this.strokeWidth,
    required this.gap,
    required this.color,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ));

    final dashWidth = gap;
    final dashSpace = gap;
    double distance = 0.0;

    for (final metric in path.computeMetrics()) {
      while (distance < metric.length) {
        final start = distance;
        final end = distance + dashWidth;
        canvas.drawPath(metric.extractPath(start, end), paint);
        distance += dashWidth + dashSpace;
      }
      distance = 0.0;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
