import 'dart:math';
import 'package:flutter/material.dart';

enum SceneType { garden, beach, city, forest, kitchen, library, attic, beachSunset }

class HiddenObject {
  final IconData icon;
  final String name;
  final Color color;
  final double x;
  final double y;
  final double size;
  final double rotation;
  bool found;
  HiddenObject({
    required this.icon, required this.name, required this.color,
    required this.x, required this.y, required this.size, required this.rotation,
    this.found = false,
  });
}

class Level {
  final String name;
  final SceneType scene;
  final List<HiddenObject> allObjects;
  final List<int> targetIndexes;
  Level({required this.name, required this.scene, required this.allObjects, required this.targetIndexes});
  int get foundCount => targetIndexes.where((i) => allObjects[i].found).length;
  int get totalTargets => targetIndexes.length;
  bool get isComplete => foundCount == totalTargets;
}

class LevelGenerator {
  static const _decoyIcons = [
    Icons.eco, Icons.cloud, Icons.local_florist, Icons.spa,
    Icons.water_drop, Icons.terrain, Icons.park, Icons.flag,
    Icons.wb_sunny, Icons.nightlight, Icons.shopping_bag, Icons.coffee,
    Icons.local_pizza, Icons.cake, Icons.icecream, Icons.lunch_dining,
    Icons.directions_bus, Icons.directions_car, Icons.flight, Icons.train,
    Icons.casino, Icons.extension, Icons.smart_toy, Icons.celebration,
    Icons.beach_access, Icons.umbrella, Icons.headphones, Icons.camera_alt,
    Icons.book, Icons.brush, Icons.music_note, Icons.movie,
    Icons.pets, Icons.diamond, Icons.bolt, Icons.favorite,
    Icons.star, Icons.access_alarm, Icons.work, Icons.lightbulb,
  ];

  static const _decoyColors = [
    Color(0xFFFF7043), Color(0xFFAB47BC), Color(0xFF42A5F5),
    Color(0xFF26A69A), Color(0xFFEC407A), Color(0xFFEF5350),
    Color(0xFF66BB6A), Color(0xFFFFCA28), Color(0xFF8D6E63),
    Color(0xFF7E57C2), Color(0xFF29B6F6), Color(0xFF9CCC65),
  ];

  static List<Level> generateAll() {
    return [
      _generate('Grădină Magică', SceneType.garden, 8, 30),
      _generate('Plajă la Apus', SceneType.beachSunset, 9, 35),
      _generate('Pădure Misterioasă', SceneType.forest, 10, 40),
      _generate('Bibliotecă Veche', SceneType.library, 12, 45),
      _generate('Bucătăria Bunicii', SceneType.kitchen, 14, 50),
      _generate('Pod cu Comori', SceneType.attic, 14, 55),
      _generate('Oraș de Noapte', SceneType.city, 15, 60),
      _generate('Plajă Tropicală', SceneType.beach, 12, 50),
    ];
  }

  static Level _generate(String name, SceneType scene, int targets, int total) {
    final rng = Random(name.hashCode);
    final objects = <HiddenObject>[];
    for (var i = 0; i < total; i++) {
      objects.add(HiddenObject(
        icon: _decoyIcons[rng.nextInt(_decoyIcons.length)],
        name: 'obj$i',
        color: _decoyColors[rng.nextInt(_decoyColors.length)],
        x: 0.05 + rng.nextDouble() * 0.9,
        y: 0.08 + rng.nextDouble() * 0.85,
        size: 26 + rng.nextDouble() * 24,
        rotation: (rng.nextDouble() - 0.5) * 0.6,
      ));
    }
    final targetIndexes = <int>[];
    final pool = List.generate(total, (i) => i)..shuffle(rng);
    for (var i = 0; i < targets; i++) {
      targetIndexes.add(pool[i]);
    }
    return Level(name: name, scene: scene, allObjects: objects, targetIndexes: targetIndexes);
  }
}
