import 'package:flutter/material.dart';
import 'package:skincare_recomendation/core/core.dart';

class AppBackdrop extends StatelessWidget {
  final Widget child;

  const AppBackdrop({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final Color lime = context.colors.lime.withValues(alpha: 0.8);
    final Color mint = context.colors.mint.withValues(alpha: 0.7);
    final Color yellow = context.colors.yellow.withValues(alpha: 0.6);

    return Stack(
      children: [
        Positioned.fill(
          child: Container(color: context.colors.surface),
        ),
        
        // Orb 1: Top Left - Mint
        Positioned(
          top: -150,
          left: -100,
          child: _Orb(color: mint, size: 550),
        ),
        
        // Orb 2: Top Right - Lime
        Positioned(
          top: -50,
          right: -100,
          child: _Orb(color: lime, size: 500),
        ),
        
        // Orb 3: Middle Right - Yellow (Sentuhan hangat di sisi kanan)
        Positioned(
          top: 350,
          right: -150,
          child: _Orb(color: yellow, size: 450),
        ),
        
        // Orb 4: Bottom Left - Mixed Lime
        Positioned(
          bottom: -100,
          left: -100,
          child: _Orb(color: lime, size: 450),
        ),
        
        child,
      ],
    );
  }
}

class _Orb extends StatelessWidget {
  final Color color;
  final double size;

  const _Orb({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color,
            color.withValues(alpha: 0.0),
          ],
          stops: const [0.2, 1.0], // Pusat sedikit lebih luas agar warna lebih 'kick'
        ),
      ),
    );
  }
}
