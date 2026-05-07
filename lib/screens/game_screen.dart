import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../game/level_data.dart';
import '../services/rewards_service.dart';
import '../widgets/scene_background.dart';

class GameScreen extends StatefulWidget {
  final int levelIndex;
  const GameScreen({super.key, required this.levelIndex});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Level _level;
  int _seconds = 0;
  Timer? _timer;
  bool _completed = false;
  final _rewards = RewardsService();

  @override
  void initState() {
    super.initState();
    _level = LevelGenerator.generateAll()[widget.levelIndex];
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_completed && mounted) setState(() => _seconds++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _onTapObject(int idx) {
    if (!_level.targetIndexes.contains(idx)) {
      HapticFeedback.heavyImpact();
      setState(() => _seconds += 3);
      return;
    }
    if (_level.allObjects[idx].found) return;
    HapticFeedback.lightImpact();
    setState(() => _level.allObjects[idx].found = true);
    if (_level.isComplete) {
      _completed = true;
      _timer?.cancel();
      final coins = (200 - _seconds).clamp(20, 200);
      _rewards.addCoins(coins);
      Future.microtask(() {
        if (!mounted) return;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (c) => AlertDialog(
            backgroundColor: const Color(0xFF1A0033),
            title: const Text('🎉 Nivel complet!',
                style: TextStyle(color: Colors.white)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Toate ${_level.totalTargets} obiectele găsite în ${_fmt(_seconds)}',
                    style: const TextStyle(color: Colors.white70)),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.monetization_on, color: Color(0xFFFFD740)),
                      const SizedBox(width: 8),
                      Text('+$coins',
                          style: const TextStyle(
                              color: Color(0xFFFFD740),
                              fontSize: 24,
                              fontWeight: FontWeight.w900)),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(c);
                  Navigator.pop(context);
                },
                child: const Text('Înapoi', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      });
    }
  }

  String _fmt(int s) {
    final m = (s ~/ 60).toString().padLeft(2, '0');
    final ss = (s % 60).toString().padLeft(2, '0');
    return '$m:$ss';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_level.name),
        backgroundColor: Colors.black54,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(_fmt(_seconds),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(child: SceneBackground(type: _level.scene)),
          Column(
            children: [
              _targetsBar(),
              Expanded(child: _scene()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _targetsBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        border: const Border(bottom: BorderSide(color: Colors.white24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 6),
            child: Text(
              'Găsește (${_level.foundCount}/${_level.totalTargets})',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
                letterSpacing: 1,
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _level.targetIndexes.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (ctx, i) {
                final idx = _level.targetIndexes[i];
                final obj = _level.allObjects[idx];
                final found = obj.found;
                return Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color: found
                        ? Colors.green.withValues(alpha: 0.3)
                        : Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: found ? Colors.greenAccent : Colors.white60,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(obj.icon,
                          color: found ? obj.color.withValues(alpha: 0.4) : obj.color,
                          size: 30),
                      if (found)
                        const Icon(Icons.check_circle, color: Colors.greenAccent, size: 22),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _scene() {
    return LayoutBuilder(builder: (ctx, c) {
      final w = c.maxWidth;
      final h = c.maxHeight;
      return Stack(
        children: [
          for (var i = 0; i < _level.allObjects.length; i++)
            Positioned(
              left: _level.allObjects[i].x * w - _level.allObjects[i].size / 2,
              top: _level.allObjects[i].y * h - _level.allObjects[i].size / 2,
              child: GestureDetector(
                onTap: () => _onTapObject(i),
                child: Transform.rotate(
                  angle: _level.allObjects[i].rotation,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: _level.allObjects[i].found &&
                            _level.targetIndexes.contains(i)
                        ? 0.2
                        : 1.0,
                    child: Icon(
                      _level.allObjects[i].icon,
                      size: _level.allObjects[i].size,
                      color: _level.allObjects[i].color,
                      shadows: const [
                        Shadow(color: Colors.black87, blurRadius: 6, offset: Offset(2, 2)),
                        Shadow(color: Colors.black54, blurRadius: 12),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
