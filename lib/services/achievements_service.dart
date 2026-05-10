import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Achievement {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final int target;
  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.target,
  });
}

class AchievementsService {
  AchievementsService._();
  static final instance = AchievementsService._();

  static const _kTotalFoundKey = 'achTotalFound';
  static const _kCompletedLevelsKey = 'achCompletedLevels';
  static const _kBestTimeKey = 'achBestTimeSeconds';
  static const _kNoHintLevelsKey = 'achNoHintLevels';
  static const _kUnlockedKey = 'achUnlocked';

  static const List<Achievement> all = [
    Achievement(
      id: 'first_find',
      title: 'First Find',
      description: 'Găsește primul obiect',
      icon: Icons.search,
      color: Color(0xFF42A5F5),
      target: 1,
    ),
    Achievement(
      id: 'garden_master',
      title: 'Garden Master',
      description: 'Termină Grădina Magică',
      icon: Icons.local_florist,
      color: Color(0xFF66BB6A),
      target: 1,
    ),
    Achievement(
      id: 'halfway_hero',
      title: 'Halfway Hero',
      description: 'Termină 4 scene',
      icon: Icons.flag,
      color: Color(0xFFFFCA28),
      target: 4,
    ),
    Achievement(
      id: 'master_detective',
      title: 'Master Detective',
      description: 'Termină toate 8 scenele',
      icon: Icons.workspace_premium,
      color: Color(0xFFAB47BC),
      target: 8,
    ),
    Achievement(
      id: 'hawk_eye',
      title: 'Hawk Eye',
      description: 'Găsește 50 de obiecte total',
      icon: Icons.visibility,
      color: Color(0xFF26A69A),
      target: 50,
    ),
    Achievement(
      id: 'eagle_eye',
      title: 'Eagle Eye',
      description: 'Găsește 200 de obiecte total',
      icon: Icons.remove_red_eye,
      color: Color(0xFFEF5350),
      target: 200,
    ),
    Achievement(
      id: 'no_cheat',
      title: 'No Cheat',
      description: 'Termină o scenă fără indiciu',
      icon: Icons.lightbulb_outline,
      color: Color(0xFFFF7043),
      target: 1,
    ),
    Achievement(
      id: 'speed_runner',
      title: 'Speed Runner',
      description: 'Termină o scenă sub 30 secunde',
      icon: Icons.bolt,
      color: Color(0xFFFFD740),
      target: 1,
    ),
  ];

  Future<int> totalFound() async {
    final p = await SharedPreferences.getInstance();
    return p.getInt(_kTotalFoundKey) ?? 0;
  }

  Future<Set<int>> completedLevels() async {
    final p = await SharedPreferences.getInstance();
    final l = p.getStringList(_kCompletedLevelsKey) ?? [];
    return l.map(int.parse).toSet();
  }

  Future<Set<int>> noHintLevels() async {
    final p = await SharedPreferences.getInstance();
    final l = p.getStringList(_kNoHintLevelsKey) ?? [];
    return l.map(int.parse).toSet();
  }

  Future<int> bestTimeSeconds() async {
    final p = await SharedPreferences.getInstance();
    return p.getInt(_kBestTimeKey) ?? 99999;
  }

  Future<Set<String>> unlocked() async {
    final p = await SharedPreferences.getInstance();
    return (p.getStringList(_kUnlockedKey) ?? []).toSet();
  }

  Future<List<Achievement>> _newlyUnlocked(Set<String> alreadyUnlocked) async {
    final tf = await totalFound();
    final cl = await completedLevels();
    final nh = await noHintLevels();
    final bt = await bestTimeSeconds();
    final newly = <Achievement>[];
    for (final a in all) {
      if (alreadyUnlocked.contains(a.id)) continue;
      bool got = false;
      switch (a.id) {
        case 'first_find':
          got = tf >= 1;
          break;
        case 'garden_master':
          got = cl.contains(0);
          break;
        case 'halfway_hero':
          got = cl.length >= 4;
          break;
        case 'master_detective':
          got = cl.length >= 8;
          break;
        case 'hawk_eye':
          got = tf >= 50;
          break;
        case 'eagle_eye':
          got = tf >= 200;
          break;
        case 'no_cheat':
          got = nh.isNotEmpty;
          break;
        case 'speed_runner':
          got = bt <= 30;
          break;
      }
      if (got) newly.add(a);
    }
    return newly;
  }

  Future<List<Achievement>> recordObjectFound() async {
    final p = await SharedPreferences.getInstance();
    await p.setInt(_kTotalFoundKey, (await totalFound()) + 1);
    final already = await unlocked();
    final newly = await _newlyUnlocked(already);
    if (newly.isNotEmpty) {
      already.addAll(newly.map((a) => a.id));
      await p.setStringList(_kUnlockedKey, already.toList());
    }
    return newly;
  }

  Future<List<Achievement>> recordLevelComplete({
    required int levelIndex,
    required int seconds,
    required bool usedHint,
  }) async {
    final p = await SharedPreferences.getInstance();
    final cl = await completedLevels();
    cl.add(levelIndex);
    await p.setStringList(_kCompletedLevelsKey, cl.map((i) => i.toString()).toList());
    if (!usedHint) {
      final nh = await noHintLevels();
      nh.add(levelIndex);
      await p.setStringList(_kNoHintLevelsKey, nh.map((i) => i.toString()).toList());
    }
    if (seconds < await bestTimeSeconds()) {
      await p.setInt(_kBestTimeKey, seconds);
    }
    final already = await unlocked();
    final newly = await _newlyUnlocked(already);
    if (newly.isNotEmpty) {
      already.addAll(newly.map((a) => a.id));
      await p.setStringList(_kUnlockedKey, already.toList());
    }
    return newly;
  }

  Future<double> progressFor(Achievement a) async {
    int current = 0;
    final tf = await totalFound();
    final cl = await completedLevels();
    final nh = await noHintLevels();
    final bt = await bestTimeSeconds();
    switch (a.id) {
      case 'first_find':
      case 'hawk_eye':
      case 'eagle_eye':
        current = tf;
        break;
      case 'garden_master':
        current = cl.contains(0) ? 1 : 0;
        break;
      case 'halfway_hero':
      case 'master_detective':
        current = cl.length;
        break;
      case 'no_cheat':
        current = nh.isNotEmpty ? 1 : 0;
        break;
      case 'speed_runner':
        current = bt <= 30 ? 1 : 0;
        break;
    }
    return (current / a.target).clamp(0.0, 1.0);
  }
}
