import 'dart:math';
import 'package:flutter/material.dart';

class HiddenObject {
  final IconData icon;
  final String name;
  final Color color;
  final double x; // 0..1 normalized
  final double y; // 0..1 normalized
  final double size; // pixels
  final double rotation;
  bool found;

  HiddenObject({
    required this.icon,
    required this.name,
    required this.color,
    required this.x,
    required this.y,
    required this.size,
    required this.rotation,
    this.found = false,
  });
}

class Level {
  final String name;
  final Color background;
  final List<HiddenObject> allObjects; // all visible icons (decoys + targets)
  final List<int> targetIndexes; // indexes in allObjects that must be found

  Level({
    required this.name,
    required this.background,
    required this.allObjects,
    required this.targetIndexes,
  });

  int get foundCount =>
      targetIndexes.where((i) => allObjects[i].found).length;
  int get totalTargets => targetIndexes.length;
  bool get isComplete => foundCount == totalTargets;
}

class LevelGenerator {
  static const _decoyIcons = [
    Icons.eco, Icons.cloud, Icons.local_florist, Icons.nature,
    Icons.spa, Icons.water_drop, Icons.terrain, Icons.park,
    Icons.flag, Icons.wb_sunny, Icons.nightlight, Icons.air,
    Icons.shopping_bag, Icons.coffee, Icons.local_pizza, Icons.cake,
    Icons.icecream, Icons.lunch_dining, Icons.bakery_dining, Icons.fastfood,
    Icons.directions_bus, Icons.local_taxi, Icons.directions_bike, Icons.directions_boat,
    Icons.flight, Icons.train, Icons.directions_car, Icons.toys,
    Icons.casino, Icons.extension, Icons.smart_toy, Icons.celebration,
    Icons.beach_access, Icons.umbrella, Icons.hiking, Icons.surfing,
    Icons.headphones, Icons.camera_alt, Icons.book, Icons.brush,
  ];

  static const _decoyColors = [
    Color(0xFFFF7043), Color(0xFFAB47BC), Color(0xFF42A5F5),
    Color(0xFF26A69A), Color(0xFFEC407A), Color(0xFFEF5350),
    Color(0xFF66BB6A), Color(0xFFFFCA28), Color(0xFF8D6E63),
    Color(0xFF7E57C2),
  ];

  static List<Level> generateAll() {
    return [
      _generate('Grădină', const Color(0xFF1B5E20), 8, 30),
      _generate('Plajă', const Color(0xFF01579B), 10, 35),
      _generate('Oraș', const Color(0xFF263238), 12, 42),
      _generate('Cer Înstelat', const Color(0xFF1A237E), 14, 50),
      _generate('Junglă', const Color(0xFF004D40), 16, 60),
    ];
  }

  static Level _generate(String name, Color bg, int targets, int total) {
    final rng = Random(name.hashCode);
    final objects = <HiddenObject>[];
    for (var i = 0; i < total; i++) {
      objects.add(HiddenObject(
        icon: _decoyIcons[rng.nextInt(_decoyIcons.length)],
        name: 'obj$i',
        color: _decoyColors[rng.nextInt(_decoyColors.length)],
        x: 0.05 + rng.nextDouble() * 0.9,
        y: 0.05 + rng.nextDouble() * 0.9,
        size: 28 + rng.nextDouble() * 22,
        rotation: (rng.nextDouble() - 0.5) * 0.8,
      ));
    }
    final targetIndexes = <int>[];
    final pool = List.generate(total, (i) => i)..shuffle(rng);
    for (var i = 0; i < targets; i++) {
      targetIndexes.add(pool[i]);
    }
    return Level(
      name: name,
      background: bg,
      allObjects: objects,
      targetIndexes: targetIndexes,
    );
  }
}
