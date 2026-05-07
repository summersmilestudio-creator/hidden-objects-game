import 'dart:math';
import 'package:flutter/material.dart';
import '../game/level_data.dart';

class SceneBackground extends StatelessWidget {
  final SceneType type;
  const SceneBackground({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _ScenePainter(type),
    );
  }
}

class _ScenePainter extends CustomPainter {
  final SceneType type;
  _ScenePainter(this.type);

  @override
  void paint(Canvas canvas, Size size) {
    switch (type) {
      case SceneType.garden:
        _paintGarden(canvas, size);
        break;
      case SceneType.beachSunset:
        _paintBeachSunset(canvas, size);
        break;
      case SceneType.forest:
        _paintForest(canvas, size);
        break;
      case SceneType.library:
        _paintLibrary(canvas, size);
        break;
      case SceneType.kitchen:
        _paintKitchen(canvas, size);
        break;
      case SceneType.attic:
        _paintAttic(canvas, size);
        break;
      case SceneType.city:
        _paintCity(canvas, size);
        break;
      case SceneType.beach:
        _paintBeach(canvas, size);
        break;
    }
  }

  void _paintGarden(Canvas canvas, Size size) {
    // Sky gradient
    final skyPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF81D4FA), Color(0xFFB3E5FC), Color(0xFFC8E6C9)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), skyPaint);
    // Sun
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.15), 50,
        Paint()..color = const Color(0xFFFFF59D).withValues(alpha: 0.8));
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.15), 40,
        Paint()..color = const Color(0xFFFFEE58));
    // Clouds
    _paintCloud(canvas, size.width * 0.2, size.height * 0.18, 60);
    _paintCloud(canvas, size.width * 0.5, size.height * 0.10, 80);
    // Grass
    final grassPath = Path()
      ..moveTo(0, size.height * 0.55)
      ..quadraticBezierTo(size.width * 0.5, size.height * 0.5, size.width, size.height * 0.55)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);
    canvas.drawPath(grassPath,
        Paint()..shader = const LinearGradient(
          colors: [Color(0xFF66BB6A), Color(0xFF2E7D32)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(0, size.height * 0.5, size.width, size.height * 0.5)));
    // Trees
    _paintTree(canvas, size.width * 0.15, size.height * 0.55, 90);
    _paintTree(canvas, size.width * 0.85, size.height * 0.58, 70);
    _paintTree(canvas, size.width * 0.45, size.height * 0.5, 110);
    // Flowers scattered
    final rng = Random(42);
    for (var i = 0; i < 15; i++) {
      final fx = rng.nextDouble() * size.width;
      final fy = size.height * 0.6 + rng.nextDouble() * size.height * 0.35;
      _paintFlower(canvas, fx, fy);
    }
  }

  void _paintBeachSunset(Canvas canvas, Size size) {
    // Sunset sky
    final skyPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF311B92), Color(0xFFE91E63), Color(0xFFFF6F00), Color(0xFFFFB300)],
        stops: [0, 0.4, 0.7, 1],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height * 0.65));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height * 0.65), skyPaint);
    // Sun
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.6), 80,
        Paint()..color = const Color(0xFFFFAB00).withValues(alpha: 0.6));
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.6), 60,
        Paint()..color = const Color(0xFFFFD740));
    // Sea
    canvas.drawRect(Rect.fromLTWH(0, size.height * 0.65, size.width, size.height * 0.2),
        Paint()..shader = const LinearGradient(
          colors: [Color(0xFFFF6F00), Color(0xFF4527A0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(0, size.height * 0.65, size.width, size.height * 0.2)));
    // Wave reflections
    final wavePaint = Paint()
      ..color = const Color(0xFFFFD740).withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    for (var i = 0; i < 5; i++) {
      final y = size.height * 0.67 + i * 8;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), wavePaint);
    }
    // Sand
    canvas.drawRect(Rect.fromLTWH(0, size.height * 0.85, size.width, size.height * 0.15),
        Paint()..shader = const LinearGradient(
          colors: [Color(0xFFFFCC80), Color(0xFFA1887F)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(0, size.height * 0.85, size.width, size.height * 0.15)));
    // Palm trees silhouette
    _paintPalm(canvas, size.width * 0.15, size.height * 0.85, 80);
    _paintPalm(canvas, size.width * 0.9, size.height * 0.85, 70);
  }

  void _paintForest(Canvas canvas, Size size) {
    // Dark forest
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..shader = const LinearGradient(
          colors: [Color(0xFF1B5E20), Color(0xFF004D40), Color(0xFF0D1F1B)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)));
    // Light rays
    final rayPaint = Paint()
      ..color = const Color(0xFFFFF59D).withValues(alpha: 0.15);
    for (var i = 0; i < 4; i++) {
      final path = Path()
        ..moveTo(size.width * (0.2 + i * 0.2), 0)
        ..lineTo(size.width * (0.2 + i * 0.2 + 0.05), 0)
        ..lineTo(size.width * (0.4 + i * 0.2), size.height)
        ..lineTo(size.width * (0.35 + i * 0.2), size.height);
      canvas.drawPath(path, rayPaint);
    }
    // Trees
    final rng = Random(7);
    for (var i = 0; i < 8; i++) {
      _paintTree(canvas,
          rng.nextDouble() * size.width,
          size.height * (0.5 + rng.nextDouble() * 0.4),
          60 + rng.nextDouble() * 80);
    }
  }

  void _paintLibrary(Canvas canvas, Size size) {
    // Wood walls
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..shader = const LinearGradient(
          colors: [Color(0xFF5D4037), Color(0xFF3E2723)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)));
    // Bookshelves: rows of books
    final rng = Random(11);
    for (var row = 0; row < 4; row++) {
      final y = size.height * (0.15 + row * 0.18);
      // shelf
      canvas.drawRect(Rect.fromLTWH(0, y + 80, size.width, 8),
          Paint()..color = const Color(0xFF8D6E63));
      var x = 10.0;
      while (x < size.width - 10) {
        final w = 16 + rng.nextDouble() * 12;
        final h = 70 + rng.nextDouble() * 20;
        final color = [
          const Color(0xFFD32F2F),
          const Color(0xFF388E3C),
          const Color(0xFF1976D2),
          const Color(0xFFF57C00),
          const Color(0xFF7B1FA2),
          const Color(0xFF5D4037),
          const Color(0xFF455A64),
        ][rng.nextInt(7)];
        canvas.drawRect(Rect.fromLTWH(x, y + 80 - h, w, h), Paint()..color = color);
        // gold band
        canvas.drawRect(Rect.fromLTWH(x, y + 80 - h + 8, w, 3),
            Paint()..color = const Color(0xFFFFD740).withValues(alpha: 0.6));
        x += w + 1;
      }
    }
  }

  void _paintKitchen(Canvas canvas, Size size) {
    // Wall
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height * 0.55),
        Paint()..color = const Color(0xFFFFE0B2));
    // Tiles backsplash
    final tilePaint = Paint()..color = const Color(0xFFEF5350).withValues(alpha: 0.5);
    final tileBorder = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    for (var r = 0; r < 4; r++) {
      for (var c = 0; c < 12; c++) {
        final tx = c * size.width / 12;
        final ty = r * 30 + size.height * 0.15;
        canvas.drawRect(Rect.fromLTWH(tx, ty, size.width / 12, 30), tilePaint);
        canvas.drawRect(Rect.fromLTWH(tx, ty, size.width / 12, 30), tileBorder);
      }
    }
    // Counter
    canvas.drawRect(Rect.fromLTWH(0, size.height * 0.55, size.width, size.height * 0.05),
        Paint()..color = const Color(0xFF6D4C41));
    // Cabinets
    canvas.drawRect(Rect.fromLTWH(0, size.height * 0.6, size.width, size.height * 0.4),
        Paint()..color = const Color(0xFFFFFFFF));
    // Cabinet doors
    for (var i = 0; i < 4; i++) {
      final x = i * size.width / 4 + 10;
      canvas.drawRect(
        Rect.fromLTWH(x, size.height * 0.62, size.width / 4 - 20, size.height * 0.35),
        Paint()
          ..color = const Color(0xFFF5F5F5)
          ..style = PaintingStyle.fill,
      );
      canvas.drawRect(
        Rect.fromLTWH(x, size.height * 0.62, size.width / 4 - 20, size.height * 0.35),
        Paint()
          ..color = const Color(0xFFBDBDBD)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
      // handle
      canvas.drawCircle(
        Offset(x + size.width / 4 - 30, size.height * 0.78),
        4,
        Paint()..color = const Color(0xFF424242),
      );
    }
  }

  void _paintAttic(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..shader = const LinearGradient(
          colors: [Color(0xFF6D4C41), Color(0xFF3E2723)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)));
    // Wooden beams
    final beamPaint = Paint()..color = const Color(0xFF4E342E);
    for (var i = 0; i < 6; i++) {
      canvas.drawRect(Rect.fromLTWH(0, i * size.height / 6, size.width, 4), beamPaint);
    }
    canvas.drawRect(Rect.fromLTWH(size.width * 0.2, 0, 4, size.height), beamPaint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.5, 0, 4, size.height), beamPaint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.8, 0, 4, size.height), beamPaint);
    // Window with light
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.4, size.height * 0.1, size.width * 0.2, size.height * 0.2),
      Paint()..color = const Color(0xFFFFF59D).withValues(alpha: 0.7),
    );
    // Old chest silhouette
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.65, size.height * 0.65, size.width * 0.25, size.height * 0.2),
        const Radius.circular(8),
      ),
      Paint()..color = const Color(0xFF3E2723),
    );
  }

  void _paintCity(Canvas canvas, Size size) {
    // Night sky
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..shader = const LinearGradient(
          colors: [Color(0xFF0D0D2E), Color(0xFF1A237E), Color(0xFF311B92)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)));
    // Stars
    final rng = Random(99);
    for (var i = 0; i < 80; i++) {
      canvas.drawCircle(
        Offset(rng.nextDouble() * size.width, rng.nextDouble() * size.height * 0.5),
        rng.nextDouble() * 1.5 + 0.5,
        Paint()..color = Colors.white.withValues(alpha: rng.nextDouble()),
      );
    }
    // Moon
    canvas.drawCircle(Offset(size.width * 0.85, size.height * 0.15), 30,
        Paint()..color = const Color(0xFFEEEEEE));
    // Buildings silhouette with windows
    final buildingPaint = Paint()..color = const Color(0xFF1A1A2E);
    final windowPaint = Paint()..color = const Color(0xFFFFEB3B);
    var x = 0.0;
    while (x < size.width) {
      final h = 80 + rng.nextDouble() * 200;
      final w = 40 + rng.nextDouble() * 60;
      canvas.drawRect(Rect.fromLTWH(x, size.height - h, w, h), buildingPaint);
      // windows
      for (var wy = size.height - h + 10; wy < size.height - 10; wy += 18) {
        for (var wx = x + 5; wx < x + w - 5; wx += 14) {
          if (rng.nextDouble() > 0.4) {
            canvas.drawRect(
              Rect.fromLTWH(wx, wy, 8, 10),
              Paint()..color = windowPaint.color.withValues(alpha: 0.4 + rng.nextDouble() * 0.5),
            );
          }
        }
      }
      x += w;
    }
  }

  void _paintBeach(Canvas canvas, Size size) {
    // Sky
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height * 0.55),
        Paint()..shader = const LinearGradient(
          colors: [Color(0xFF81D4FA), Color(0xFFE1F5FE), Color(0xFFFFF59D)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height * 0.55)));
    // Sea
    canvas.drawRect(Rect.fromLTWH(0, size.height * 0.55, size.width, size.height * 0.2),
        Paint()..shader = const LinearGradient(
          colors: [Color(0xFF00BCD4), Color(0xFF006064)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(0, size.height * 0.55, size.width, size.height * 0.2)));
    // Sand
    canvas.drawRect(Rect.fromLTWH(0, size.height * 0.75, size.width, size.height * 0.25),
        Paint()..shader = const LinearGradient(
          colors: [Color(0xFFFFE082), Color(0xFFFFB74D)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(0, size.height * 0.75, size.width, size.height * 0.25)));
    // Sun
    canvas.drawCircle(Offset(size.width * 0.85, size.height * 0.18), 35,
        Paint()..color = const Color(0xFFFFEB3B));
    _paintCloud(canvas, size.width * 0.2, size.height * 0.15, 50);
    _paintCloud(canvas, size.width * 0.55, size.height * 0.25, 70);
    _paintPalm(canvas, size.width * 0.1, size.height * 0.78, 100);
    _paintPalm(canvas, size.width * 0.92, size.height * 0.75, 90);
  }

  // Helpers
  void _paintCloud(Canvas canvas, double cx, double cy, double r) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.85);
    canvas.drawCircle(Offset(cx, cy), r * 0.5, paint);
    canvas.drawCircle(Offset(cx + r * 0.4, cy), r * 0.55, paint);
    canvas.drawCircle(Offset(cx - r * 0.4, cy), r * 0.45, paint);
    canvas.drawCircle(Offset(cx + r * 0.1, cy - r * 0.2), r * 0.5, paint);
  }

  void _paintTree(Canvas canvas, double cx, double bottomY, double height) {
    // trunk
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(cx, bottomY - height * 0.2),
        width: height * 0.12,
        height: height * 0.4,
      ),
      Paint()..color = const Color(0xFF5D4037),
    );
    // foliage layers
    final foliagePaint1 = Paint()..color = const Color(0xFF388E3C);
    final foliagePaint2 = Paint()..color = const Color(0xFF66BB6A);
    canvas.drawCircle(Offset(cx, bottomY - height * 0.6), height * 0.45, foliagePaint1);
    canvas.drawCircle(Offset(cx - height * 0.15, bottomY - height * 0.55), height * 0.32, foliagePaint2);
    canvas.drawCircle(Offset(cx + height * 0.15, bottomY - height * 0.65), height * 0.32, foliagePaint2);
  }

  void _paintFlower(Canvas canvas, double cx, double cy) {
    final rng = Random((cx * 1000 + cy).toInt());
    final color = [
      const Color(0xFFE91E63),
      const Color(0xFFFFEB3B),
      const Color(0xFF9C27B0),
      const Color(0xFFFF5722),
    ][rng.nextInt(4)];
    final petalPaint = Paint()..color = color;
    for (var i = 0; i < 5; i++) {
      final angle = i * 2 * pi / 5;
      canvas.drawCircle(
        Offset(cx + cos(angle) * 5, cy + sin(angle) * 5),
        4, petalPaint,
      );
    }
    canvas.drawCircle(Offset(cx, cy), 3, Paint()..color = const Color(0xFFFFEB3B));
  }

  void _paintPalm(Canvas canvas, double baseX, double baseY, double height) {
    // trunk
    final trunkPaint = Paint()
      ..color = const Color(0xFF6D4C41)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;
    final trunkPath = Path()
      ..moveTo(baseX, baseY)
      ..quadraticBezierTo(baseX - 15, baseY - height * 0.5, baseX - 5, baseY - height);
    canvas.drawPath(trunkPath, trunkPaint);
    // leaves
    final leafPaint = Paint()..color = const Color(0xFF2E7D32);
    final tipX = baseX - 5;
    final tipY = baseY - height;
    for (var i = 0; i < 6; i++) {
      final angle = (i / 6) * 2 * pi - pi / 2;
      final endX = tipX + cos(angle) * height * 0.4;
      final endY = tipY + sin(angle) * height * 0.4;
      final path = Path()
        ..moveTo(tipX, tipY)
        ..quadraticBezierTo(
            (tipX + endX) / 2 + cos(angle + pi / 2) * 10,
            (tipY + endY) / 2 + sin(angle + pi / 2) * 10,
            endX, endY);
      canvas.drawPath(path,
          Paint()
            ..color = const Color(0xFF2E7D32)
            ..strokeWidth = 8
            ..style = PaintingStyle.stroke
            ..strokeCap = StrokeCap.round);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
