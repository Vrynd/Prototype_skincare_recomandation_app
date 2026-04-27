import 'package:flutter/material.dart';
import 'dart:math' as math;

class TopographyPainter extends CustomPainter {
  final Color color;
  final double opacity;

  TopographyPainter({required this.color, this.opacity = 0.1});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth =
          0.8 // Garis lebih tipis untuk kepadatan tinggi
      ..isAntiAlias = true;

    // Titik pusat pusaran di sudut atas (sedikit keluar canvas)
    final centerX = size.width * 0.1;
    final centerY = size.height * 0.1;

    for (var i = 1; i <= 35; i++) {
      final path = Path();
      final baseRadius = i * 14.0;

      for (var angle = 0.0; angle <= 360.0; angle += 2.0) {
        final radians = angle * (math.pi / 180.0);

        // Algoritma distorsi untuk efek "Ridge" organik
        final distortion =
            8.0 * math.sin(radians * 3 + i * 0.2) +
            4.0 * math.cos(radians * 5 - i * 0.5);

        final r = baseRadius + distortion;
        final x = centerX + r * math.cos(radians);
        final y = centerY + r * math.sin(radians);

        if (angle == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
