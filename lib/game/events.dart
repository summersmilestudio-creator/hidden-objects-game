import 'package:flutter/material.dart';

/// A scheduled in-game event shown in the event calendar.
class GameEvent {
  final DateTime date;
  final String name;
  final String emoji;
  final String description;
  final int rewardStars;
  final bool special;
  final List<Color> colors;
  const GameEvent({
    required this.date,
    required this.name,
    required this.emoji,
    required this.description,
    required this.rewardStars,
    required this.special,
    required this.colors,
  });
}

/// Deterministic event schedule so every day has its own event (a real calendar).
class EventService {
  static const _epoch = 20089; // days since 1970 for a stable rotation anchor

  // name, emoji, description, stars, special, gradient colors
  static const List<List<Object>> _templates = [
    ['Provocarea Zilei', '🎯', 'Găsește toate obiectele într-o singură scenă', 3, false, [Color(0xFF42A5F5), Color(0xFF1565C0)]],
    ['Ochi de Vultur', '🦅', 'Termină o scenă fără să folosești indiciu', 5, false, [Color(0xFFAB47BC), Color(0xFF6A1B9A)]],
    ['Vânătoarea Rapidă', '⚡', 'Găsește 5 obiecte sub 60 de secunde', 4, false, [Color(0xFFFFA726), Color(0xFFEF6C00)]],
    ['Detectiv Maraton', '🔍', 'Joacă 3 scene diferite astăzi', 4, false, [Color(0xFF26C6DA), Color(0xFF00838F)]],
    ['Colecționarul', '💎', 'Strânge 25 de obiecte azi', 3, false, [Color(0xFF66BB6A), Color(0xFF2E7D32)]],
  ];

  // weekend specials
  static const List<Object> _saturday = [
    'Vânătoarea de Comori', '🏆', 'Termină 5 scene la rând cu toate obiectele', 8, true,
    [Color(0xFFFFCA28), Color(0xFFF57F17)],
  ];
  static const List<Object> _sunday = [
    'Maestrul Indiciilor', '👁️', 'Găsește 50 de obiecte în weekend', 10, true,
    [Color(0xFFEC407A), Color(0xFFAD1457)],
  ];

  static GameEvent eventFor(DateTime day) {
    final d = DateTime(day.year, day.month, day.day);
    final List<Object> t;
    if (d.weekday == DateTime.saturday) {
      t = _saturday;
    } else if (d.weekday == DateTime.sunday) {
      t = _sunday;
    } else {
      final idx = (d.millisecondsSinceEpoch ~/ Duration.millisecondsPerDay - _epoch) % _templates.length;
      t = _templates[idx.abs()];
    }
    return GameEvent(
      date: d,
      name: t[0] as String,
      emoji: t[1] as String,
      description: t[2] as String,
      rewardStars: t[3] as int,
      special: t[4] as bool,
      colors: (t[5] as List).cast<Color>(),
    );
  }

  static GameEvent today() => eventFor(DateTime.now());

  static List<GameEvent> upcoming(int days) {
    final now = DateTime.now();
    return List.generate(days, (i) => eventFor(now.add(Duration(days: i))));
  }
}
