import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class GradientDottedBorder extends StatelessWidget {
  final Widget child;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final List<Color> gradientColors;
  final double cornerRadius;

  const GradientDottedBorder({
    super.key,
    required this.child,
    this.strokeWidth = 2.0,
    this.dashWidth = 5.0,
    this.dashSpace = 5.0,
    this.gradientColors = const [
      Colors.blue,
      Colors.purple,
      Colors.pink,
    ],
    this.cornerRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: _GradientDottedBorderPainter(
            strokeWidth: strokeWidth,
            dashWidth: dashWidth,
            dashSpace: dashSpace,
            gradientColors: gradientColors,
            cornerRadius: cornerRadius,
          ),
          child: Container(
            padding: EdgeInsets.all(strokeWidth + 2),
            child: child,
          ),
        ),
      ],
    );
  }

  Widget _buildWatermarkBackground() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(cornerRadius),
      child: Container(
        color: Colors.grey[900],
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: List.generate(10, (index) {
                return Positioned(
                  top: (index * 60.0) - 20,
                  left: -50,
                  right: -50,
                  child: Transform.rotate(
                    angle: -math.pi / 12,
                    child: Text(
                      'stitching fabrics',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey[800],
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}

class _GradientDottedBorderPainter extends CustomPainter {
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final List<Color> gradientColors;
  final double cornerRadius;

  _GradientDottedBorderPainter({
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.gradientColors,
    required this.cornerRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    final rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(cornerRadius),
    );

    final path = Path()..addRRect(rrect);

    // Create a linear gradient shader for the border
    final shader = LinearGradient(
      colors: gradientColors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(rect);

    final paint = Paint()
      ..shader = shader
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Calculate the path length
    final PathMetrics pathMetrics = path.computeMetrics();
    final PathMetric pathMetric = pathMetrics.single;
    final double pathLength = pathMetric.length;

    // Draw dashed path
    double distance = 0.0;
    bool draw = true;

    while (distance < pathLength) {
      final double nextDistance = distance + (draw ? dashWidth : dashSpace);

      if (nextDistance > pathLength) {
        // Draw the remaining path
        final Path dashPath = pathMetric.extractPath(distance, pathLength);
        canvas.drawPath(dashPath, paint);
        break;
      } else {
        // Draw dash or skip space
        if (draw) {
          final Path dashPath = pathMetric.extractPath(distance, nextDistance);
          canvas.drawPath(dashPath, paint);
        }

        distance = nextDistance;
        draw = !draw;
      }
    }
  }

  @override
  bool shouldRepaint(_GradientDottedBorderPainter oldDelegate) {
    return oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashSpace != dashSpace ||
        oldDelegate.gradientColors != gradientColors ||
        oldDelegate.cornerRadius != cornerRadius;
  }
}
