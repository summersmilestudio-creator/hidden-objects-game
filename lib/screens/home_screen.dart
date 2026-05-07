import 'package:flutter/material.dart';
import '../game/level_data.dart';
import '../services/rewards_service.dart';
import 'daily_reward_screen.dart';
import 'game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _rewards = RewardsService();
  int _coins = 0;

  @override
  void initState() {
    super.initState();
    _checkDaily();
  }

  Future<void> _checkDaily() async {
    final r = await _rewards.claimDailyIfAvailable();
    if (r.reward > 0 && mounted) {
      await Navigator.push(context,
          MaterialPageRoute(builder: (_) => DailyRewardScreen(day: r.day, reward: r.reward)));
    }
    _load();
  }

  Future<void> _load() async {
    final c = await _rewards.getCoins();
    if (mounted) setState(() => _coins = c);
  }

  @override
  Widget build(BuildContext context) {
    final levels = LevelGenerator.generateAll();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFFFD740)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.monetization_on, color: Color(0xFFFFD740), size: 20),
                        const SizedBox(width: 6),
                        Text('$_coins',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ShaderMask(
                shaderCallback: (r) => const LinearGradient(
                  colors: [Color(0xFFFF6F00), Color(0xFFFFCA28)],
                ).createShader(r),
                child: const Text('OBIECTE\nASCUNSE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1.0,
                        letterSpacing: 2)),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text('Găsește obiectele în scenele pictate',
                    style: TextStyle(color: Colors.white54)),
              ),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text('Scene',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2)),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: levels.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (ctx, i) {
                    final lvl = levels[i];
                    return Container(
                      decoration: BoxDecoration(
                        gradient: _gradientFor(lvl.scene),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white12),
                        boxShadow: const [
                          BoxShadow(color: Colors.black54, blurRadius: 8, offset: Offset(0, 4)),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () async {
                            await Navigator.push(ctx,
                                MaterialPageRoute(builder: (_) => GameScreen(levelIndex: i)));
                            _load();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white.withValues(alpha: 0.3),
                                  child: Text('${i + 1}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900, color: Colors.white)),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(lvl.name,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white,
                                              shadows: [Shadow(color: Colors.black87, blurRadius: 4)])),
                                      Text('${lvl.totalTargets} obiecte de găsit',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              shadows: [Shadow(color: Colors.black87, blurRadius: 4)])),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.chevron_right, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Gradient _gradientFor(SceneType scene) {
    switch (scene) {
      case SceneType.garden:
        return const LinearGradient(colors: [Color(0xFF66BB6A), Color(0xFF1B5E20)]);
      case SceneType.beachSunset:
        return const LinearGradient(colors: [Color(0xFFE91E63), Color(0xFFFF6F00)]);
      case SceneType.forest:
        return const LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF004D40)]);
      case SceneType.library:
        return const LinearGradient(colors: [Color(0xFF5D4037), Color(0xFF3E2723)]);
      case SceneType.kitchen:
        return const LinearGradient(colors: [Color(0xFFFFE0B2), Color(0xFFFFB74D)]);
      case SceneType.attic:
        return const LinearGradient(colors: [Color(0xFF6D4C41), Color(0xFF3E2723)]);
      case SceneType.city:
        return const LinearGradient(colors: [Color(0xFF1A237E), Color(0xFF0D0D2E)]);
      case SceneType.beach:
        return const LinearGradient(colors: [Color(0xFF00BCD4), Color(0xFFFFE082)]);
    }
  }
}
