import 'package:flutter/material.dart';

class CardBorderPainter extends CustomPainter {
  final Color borderColor;
  final Color leftBorderColor;
  final double leftBorderWidth;
  final double radius;

  CardBorderPainter({
    required this.borderColor,
    required this.leftBorderColor,
    required this.leftBorderWidth,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final RRect rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );

    // Draw the grey border on all sides
    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    
    // Draw the grey border inside the bounds
    canvas.drawRRect(rrect.deflate(0.5), borderPaint);

    // Now draw the thick colored left border
    // We can do this by drawing a thick stroke and clipping it to the left side
    // Or we can construct a Path for the left border exactly
    
    // A simple way to get a perfect left border is to draw a filled RRect,
    // and clip out the inner part.
    final RRect innerRRect = RRect.fromLTRBAndCorners(
      leftBorderWidth, 0, size.width, size.height,
      topLeft: Radius.circular(radius > leftBorderWidth ? radius - leftBorderWidth : 0),
      bottomLeft: Radius.circular(radius > leftBorderWidth ? radius - leftBorderWidth : 0),
      topRight: Radius.circular(radius),
      bottomRight: Radius.circular(radius),
    );

    final Path leftBorderPath = Path.combine(
      PathOperation.difference,
      Path()..addRRect(rrect),
      Path()..addRRect(innerRRect),
    );

    final Paint leftBorderPaint = Paint()
      ..color = leftBorderColor
      ..style = PaintingStyle.fill;

    canvas.drawPath(leftBorderPath, leftBorderPaint);
  }

  @override
  bool shouldRepaint(covariant CardBorderPainter oldDelegate) {
    return oldDelegate.borderColor != borderColor ||
        oldDelegate.leftBorderColor != leftBorderColor ||
        oldDelegate.leftBorderWidth != leftBorderWidth ||
        oldDelegate.radius != radius;
  }
}
