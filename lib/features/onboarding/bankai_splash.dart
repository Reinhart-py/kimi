import 'dart:math' as math;
import 'package:flutter/material.dart';

class BankaiSplash extends StatelessWidget {
  const BankaiSplash({super.key, required this.progress, this.size = 220});
  final double progress;
  final double size;

  @override
  Widget build(BuildContext context) {
    double t = progress.clamp(0.0, 1.0);
    
    // Slash sweeps from 0.0 to 0.7
    double cutProgress = (t / 0.7).clamp(0.0, 1.0);
    double easeCut = 1.0 - math.pow(1.0 - cutProgress, 3).toDouble();
    
    // Pulse happens from 0.7 to 1.0
    double pulseProgress = ((t - 0.7) / 0.3).clamp(0.0, 1.0);
    double scale = 1.0 + math.sin(pulseProgress * math.pi) * 0.05;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Logo revealed by slash
          if (t > 0.0)
            ClipPath(
              clipper: _SlashClipper(easeCut),
              child: Transform.scale(
                scale: scale,
                child: Image.asset('assets/icon/app_icon.png', width: size, height: size, fit: BoxFit.contain),
              ),
            ),
          
          // Glowing laser line
          if (easeCut > 0.0 && easeCut < 1.0)
            Positioned.fill(
              child: CustomPaint(
                painter: _LaserPainter(easeCut),
              ),
            ),
            
          // Impact glint
          if (easeCut > 0.4 && easeCut < 0.9)
            Positioned.fill(
              child: CustomPaint(
                painter: _ImpactPainter(easeCut),
              ),
            ),
        ],
      ),
    );
  }
}

class _SlashClipper extends CustomClipper<Path> {
  _SlashClipper(this.progress);
  final double progress;
  @override
  Path getClip(Size size) {
    Path path = Path();
    double w = size.width;
    double h = size.height;
    double sweep = (w * 2.5) * progress - (w * 0.75);
    
    path.moveTo(-w, -h);
    path.lineTo(sweep, -h);
    path.lineTo(sweep - w, h * 2);
    path.lineTo(-w, h * 2);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(_SlashClipper oldClipper) => oldClipper.progress != progress;
}

class _LaserPainter extends CustomPainter {
  _LaserPainter(this.progress);
  final double progress;
  @override
  void paint(Canvas canvas, Size size) {
    double w = size.width;
    double h = size.height;
    double sweep = (w * 2.5) * progress - (w * 0.75);
    
    Offset p1 = Offset(sweep, -h);
    Offset p2 = Offset(sweep - w, h * 2);

    // Glow
    canvas.drawLine(
      p1, p2,
      Paint()
        ..color = const Color(0xFF66FF66).withValues(alpha: 0.8) // Greenish kiwi glow
        ..strokeWidth = 12.0
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12.0)
    );
    // Core
    canvas.drawLine(
      p1, p2,
      Paint()
        ..color = Colors.white
        ..strokeWidth = 3.0
    );
  }
  @override
  bool shouldRepaint(_LaserPainter oldDelegate) => oldDelegate.progress != progress;
}

class _ImpactPainter extends CustomPainter {
  _ImpactPainter(this.progress);
  final double progress;
  @override
  void paint(Canvas canvas, Size size) {
    // Flash a glint when the laser is crossing the center
    double intensity = 1.0 - ((progress - 0.65).abs() * 4.0).clamp(0.0, 1.0);
    if (intensity <= 0) return;
    
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width * 0.8 * intensity,
      Paint()
        ..color = const Color(0xFF66FF66).withValues(alpha: 0.3 * intensity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30.0)
    );
  }
  @override
  bool shouldRepaint(_ImpactPainter old) => old.progress != progress;
}
