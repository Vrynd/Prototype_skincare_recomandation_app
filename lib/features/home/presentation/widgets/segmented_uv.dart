import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/core.dart';
import 'package:skincare_recomendation/features/home/models/uv_index.dart';

class SegmentedUV extends StatelessWidget {
  final double uvIndex;

  const SegmentedUV({super.key, required this.uvIndex});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double positionFraction = (uvIndex / 12).clamp(0.0, 1.0);

        return CustomPaint(
          size: Size(constraints.maxWidth, 48),
          painter: _BarPainter(
            currentPositionFraction: positionFraction,
            indicatorColor: context.colors.surface,
            segmentColor: context.colors.surface.withValues(alpha: 0.2),
          ),
        );
      },
    );
  }
}

class _BarPainter extends CustomPainter {
  final double currentPositionFraction;
  final Color indicatorColor;
  final Color segmentColor;

  _BarPainter({
    required this.currentPositionFraction,
    required this.indicatorColor,
    required this.segmentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double barHeight = 40;
    final double barY = (size.height - barHeight) / 2;
    const double gapWidth = 4;
    final double indicatorX = size.width * currentPositionFraction;
    const double indicatorWidth = 3;

    final Paint barPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          UVIndex.low,
          UVIndex.moderate,
          UVIndex.high,
          UVIndex.veryHigh,
          UVIndex.extreme,
        ],
      ).createShader(Rect.fromLTWH(0, barY, size.width, barHeight));

    // 1. Left Bar
    final double leftBarEnd = (indicatorX - gapWidth / 2).clamp(
      0.0,
      size.width,
    );
    if (leftBarEnd > 0) {
      final RRect leftRRect = RRect.fromLTRBR(
        0,
        barY,
        leftBarEnd,
        barY + barHeight,
        const Radius.circular(20),
      );
      canvas.drawRRect(leftRRect, barPaint);
      canvas.save();
      canvas.clipRRect(leftRRect);
      _drawSegments(canvas, 0, leftBarEnd, barY, barHeight);
      canvas.restore();
    }

    // 2. Right Bar
    final double rightBarStart = (indicatorX + gapWidth / 2).clamp(
      0.0,
      size.width,
    );
    if (rightBarStart < size.width) {
      final RRect rightRRect = RRect.fromLTRBR(
        rightBarStart,
        barY,
        size.width,
        barY + barHeight,
        const Radius.circular(20),
      );
      canvas.drawRRect(rightRRect, barPaint);
      canvas.save();
      canvas.clipRRect(rightRRect);
      _drawSegments(canvas, rightBarStart, size.width, barY, barHeight);
      canvas.restore();
    }

    // 3. Indicator Metrics
    final double indicatorHeight = barHeight * 0.6;

    // 4. Indicator Shadow
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(indicatorX, size.height / 2),
          width: indicatorWidth + 2,
          height: indicatorHeight + 2,
        ),
        const Radius.circular(indicatorWidth),
      ),
      Paint()
        ..color = Colors.black.withValues(alpha: 0.15)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    );

    // 5. Main Indicator Pill
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(indicatorX, size.height / 2),
          width: indicatorWidth,
          height: indicatorHeight,
        ),
        Radius.circular(indicatorWidth / 2),
      ),
      Paint()
        ..color = indicatorColor
        ..style = PaintingStyle.fill,
    );

    // 6. Indicator Border
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(indicatorX, size.height / 2),
          width: indicatorWidth,
          height: indicatorHeight,
        ),
        Radius.circular(indicatorWidth / 2),
      ),
      Paint()
        ..color = Colors.black.withValues(alpha: 0.2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5,
    );
  }

  void _drawSegments(
    Canvas canvas,
    double startX,
    double endX,
    double y,
    double height,
  ) {
    if (endX <= startX) return;
    final Paint segmentPaint = Paint()
      ..color = segmentColor
      ..strokeWidth = 1;
    const double interval = 4.0;
    double currentX = startX;
    while (currentX < endX) {
      canvas.drawLine(
        Offset(currentX, y),
        Offset(currentX, y + height),
        segmentPaint,
      );
      currentX += interval;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
