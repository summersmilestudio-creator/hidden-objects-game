import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';

/// The four in-game special powers for the hidden-object game, bought with
/// coins and consumed during a level.
enum PowerType { hint, scan, freeze, shield }

/// Static presentation + balance data (price, icon, color). Names/descriptions
/// are localized at the call site.
class PowerSpec {
  final PowerType type;
  final int price; // coins
  final IconData icon;
  final Color color;
  const PowerSpec(this.type, this.price, this.icon, this.color);
}

String powerName(AppLocalizations l, PowerType t) {
  switch (t) {
    case PowerType.hint:
      return l.powerHintName;
    case PowerType.scan:
      return l.powerScanName;
    case PowerType.freeze:
      return l.powerFreezeName;
    case PowerType.shield:
      return l.powerShieldName;
  }
}

String powerDesc(AppLocalizations l, PowerType t) {
  switch (t) {
    case PowerType.hint:
      return l.powerHintDesc;
    case PowerType.scan:
      return l.powerScanDesc;
    case PowerType.freeze:
      return l.powerFreezeDesc;
    case PowerType.shield:
      return l.powerShieldDesc;
  }
}

/// Inventory of consumable powers, persisted in SharedPreferences.
class PowersService {
  PowersService._();
  static final instance = PowersService._();

  static const List<PowerSpec> specs = [
    PowerSpec(PowerType.hint, 50, Icons.lightbulb, Color(0xFFFFCA28)),
    PowerSpec(PowerType.scan, 90, Icons.radar, Color(0xFF40C4FF)),
    PowerSpec(PowerType.freeze, 60, Icons.ac_unit, Color(0xFF80DEEA)),
    PowerSpec(PowerType.shield, 40, Icons.shield, Color(0xFF69F0AE)),
  ];

  static PowerSpec specFor(PowerType t) => specs.firstWhere((s) => s.type == t);

  String _key(PowerType t) => 'hoPower_${t.name}';

  Future<int> count(PowerType t) async {
    final p = await SharedPreferences.getInstance();
    return p.getInt(_key(t)) ?? 0;
  }

  Future<Map<PowerType, int>> all() async {
    final p = await SharedPreferences.getInstance();
    return {for (final t in PowerType.values) t: p.getInt(_key(t)) ?? 0};
  }

  Future<void> add(PowerType t, int n) async {
    final p = await SharedPreferences.getInstance();
    await p.setInt(_key(t), (await count(t)) + n);
  }

  /// Consumes one of [t]. Returns false if none are available.
  Future<bool> use(PowerType t) async {
    final c = await count(t);
    if (c <= 0) return false;
    final p = await SharedPreferences.getInstance();
    await p.setInt(_key(t), c - 1);
    return true;
  }
}
