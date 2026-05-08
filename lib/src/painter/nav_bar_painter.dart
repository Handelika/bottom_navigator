import 'package:flutter/material.dart';
import '../enums.dart';

class NavBarPainter extends CustomPainter {
  final Color backgroundColor;
  final double borderRadius;
  final double notchRadius;
  final CenterButtonStyle style;
  final double blurAmount;

  NavBarPainter({
    required this.backgroundColor,
    required this.borderRadius,
    this.notchRadius = 35.0,
    this.style = CenterButtonStyle.none,
    this.blurAmount = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final path = Path();

    if (style == CenterButtonStyle.notched) {
      final center = size.width / 2;
      final notchWidth = notchRadius * 2.4;
      final notchDepth = notchRadius * 0.72;
      final notchLeft = center - (notchWidth / 2);
      final notchRight = center + (notchWidth / 2);

      path.moveTo(0, borderRadius);
      path.quadraticBezierTo(0, 0, borderRadius, 0);
      path.lineTo(notchLeft - 14, 0);

      // Curved notch tuned for a standard Material FAB.
      path.cubicTo(
        notchLeft - 4,
        0,
        notchLeft + 2,
        notchDepth,
        center,
        notchDepth,
      );
      path.cubicTo(
        notchRight - 2,
        notchDepth,
        notchRight + 4,
        0,
        notchRight + 14,
        0,
      );

      path.lineTo(size.width - borderRadius, 0);
      path.quadraticBezierTo(size.width, 0, size.width, borderRadius);
      path.lineTo(size.width, size.height - borderRadius);
      path.quadraticBezierTo(
        size.width,
        size.height,
        size.width - borderRadius,
        size.height,
      );
      path.lineTo(borderRadius, size.height);
      path.quadraticBezierTo(0, size.height, 0, size.height - borderRadius);
      path.close();
    } else {
      path.addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(borderRadius),
        ),
      );
    }

    canvas.drawPath(path, paint);

    // Add a subtle border
    final borderPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant NavBarPainter oldDelegate) {
    return oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.style != style ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.notchRadius != notchRadius;
  }
}
