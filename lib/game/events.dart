import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

/// A scheduled in-game event shown in the event calendar.
class GameEvent {
  final DateTime date;
  final String key; // stable id used to look up localized name/description
  final String name;
  final String emoji;
  final String description;
  final int rewardStars;
  final bool special;
  final List<Color> colors;
  const GameEvent({
    required this.date,
    required this.key,
    required this.name,
    required this.emoji,
    required this.description,
    required this.rewardStars,
    required this.special,
    required this.colors,
  });

  /// Localized event name (falls back to the embedded RO [name]).
  String localizedName(AppLocalizations l) {
    switch (key) {
      case 'daily_challenge': return l.evtDailyChallengeName;
      case 'hawk_eye': return l.evtHawkEyeName;
      case 'quick_hunt': return l.evtQuickHuntName;
      case 'marathon': return l.evtMarathonName;
      case 'collector': return l.evtCollectorName;
      case 'treasure_hunt': return l.evtTreasureHuntName;
      case 'hint_master': return l.evtHintMasterName;
    }
    return name;
  }

  /// Localized event description (falls back to the embedded RO [description]).
  String localizedDescription(AppLocalizations l) {
    switch (key) {
      case 'daily_challenge': return l.evtDailyChallengeDesc;
      case 'hawk_eye': return l.evtHawkEyeDesc;
      case 'quick_hunt': return l.evtQuickHuntDesc;
      case 'marathon': return l.evtMarathonDesc;
      case 'collector': return l.evtCollectorDesc;
      case 'treasure_hunt': return l.evtTreasureHuntDesc;
      case 'hint_master': return l.evtHintMasterDesc;
    }
    return description;
  }
}

/// Deterministic event schedule so every day has its own event (a real calendar).
class EventService {
  static const _epoch = 20089; // days since 1970 for a stable rotation anchor

  // key, name, emoji, description, stars, special, gradient colors
  static const List<List<Object>> _templates = [
    ['daily_challenge', 'Provocarea Zilei', '🎯', 'Găsește toate obiectele într-o singură scenă', 3, false, [Color(0xFF42A5F5), Color(0xFF1565C0)]],
    ['hawk_eye', 'Ochi de Vultur', '🦅', 'Termină o scenă fără să folosești indiciu', 5, false, [Color(0xFFAB47BC), Color(0xFF6A1B9A)]],
    ['quick_hunt', 'Vânătoarea Rapidă', '⚡', 'Găsește 5 obiecte sub 60 de secunde', 4, false, [Color(0xFFFFA726), Color(0xFFEF6C00)]],
    ['marathon', 'Detectiv Maraton', '🔍', 'Joacă 3 scene diferite astăzi', 4, false, [Color(0xFF26C6DA), Color(0xFF00838F)]],
    ['collector', 'Colecționarul', '💎', 'Strânge 25 de obiecte azi', 3, false, [Color(0xFF66BB6A), Color(0xFF2E7D32)]],
  ];

  // weekend specials
  static const List<Object> _saturday = [
    'treasure_hunt', 'Vânătoarea de Comori', '🏆', 'Termină 5 scene la rând cu toate obiectele', 8, true,
    [Color(0xFFFFCA28), Color(0xFFF57F17)],
  ];
  static const List<Object> _sunday = [
    'hint_master', 'Maestrul Indiciilor', '👁️', 'Găsește 50 de obiecte în weekend', 10, true,
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
      key: t[0] as String,
      name: t[1] as String,
      emoji: t[2] as String,
      description: t[3] as String,
      rewardStars: t[4] as int,
      special: t[5] as bool,
      colors: (t[6] as List).cast<Color>(),
    );
  }

  static GameEvent today() => eventFor(DateTime.now());

  static List<GameEvent> upcoming(int days) {
    final now = DateTime.now();
    return List.generate(days, (i) => eventFor(now.add(Duration(days: i))));
  }
}
