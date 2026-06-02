import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../game/level_data.dart';
import '../services/achievements_service.dart';
import '../services/ads_service.dart';
import '../services/rewards_service.dart';
import '../widgets/banner_ad_widget.dart';

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
  bool _hintUsed = false;
  final _rewards = RewardsService();

  // Visual feedback
  String? _hintId;
  Timer? _hintTimer;
  Offset? _missAt; // where the last wrong tap landed (for an X marker)
  Timer? _missTimer;

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
    _hintTimer?.cancel();
    _missTimer?.cancel();
    super.dispose();
  }

  /// Computes the rect the contained scene image occupies inside [area]
  /// (BoxFit.contain), so hotspots map exactly onto the visible art.
  Rect _imageRect(Size area) {
    final s = min(area.width / 1024.0, area.height / 1792.0);
    final dispW = 1024.0 * s;
    final dispH = 1792.0 * s;
    final ox = (area.width - dispW) / 2;
    final oy = (area.height - dispH) / 2;
    return Rect.fromLTWH(ox, oy, dispW, dispH);
  }

  void _onTapScene(Offset local, Rect img) {
    if (_completed) return;
    if (!img.contains(local)) return;
    final nx = (local.dx - img.left) / img.width;
    final ny = (local.dy - img.top) / img.height;
    // Aspect-correct the y delta so the tap zone is a real circle (the scene
    // is much taller than wide), with r expressed in width fractions.
    final aspect = img.height / img.width;
    FindTarget? hit;
    double best = double.infinity;
    for (final t in _level.targets) {
      if (t.found) continue;
      final dx = nx - t.cx;
      final dy = (ny - t.cy) * aspect;
      final d = sqrt(dx * dx + dy * dy);
      if (d < t.r && d < best) {
        best = d;
        hit = t;
      }
    }
    if (hit != null) {
      _onFound(hit);
    } else {
      HapticFeedback.heavyImpact();
      setState(() {
        _seconds += 3;
        _missAt = local;
      });
      _missTimer?.cancel();
      _missTimer = Timer(const Duration(milliseconds: 600), () {
        if (mounted) setState(() => _missAt = null);
      });
    }
  }

  void _onFound(FindTarget t) {
    HapticFeedback.lightImpact();
    setState(() => t.found = true);
    AchievementsService.instance.recordObjectFound().then(_showUnlockToasts);
    if (_level.isComplete) {
      _completed = true;
      _timer?.cancel();
      final coins = (200 - _seconds).clamp(20, 200);
      _rewards.addCoins(coins);
      AchievementsService.instance.recordLevelComplete(
        levelIndex: widget.levelIndex,
        seconds: _seconds,
        usedHint: _hintUsed,
      ).then(_showUnlockToasts);
      AdsService.instance.maybeShowInterstitial();
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
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD740),
                  foregroundColor: Colors.black,
                ),
                onPressed: () => _doubleCoinsViaAd(c, coins),
                icon: const Icon(Icons.smart_display, size: 20),
                label: const Text('Dublează ×2',
                    style: TextStyle(fontWeight: FontWeight.w900)),
              ),
              TextButton(
                onPressed: () => _bonusLevelsViaAd(c),
                child: const Text('+2 niveluri 🎁',
                    style: TextStyle(color: Color(0xFFFFD740), fontWeight: FontWeight.w900)),
              ),
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

  Future<void> _showHintViaAd() async {
    final unfound = _level.targets.where((t) => !t.found).toList();
    if (unfound.isEmpty) return;
    final earned = await AdsService.instance.showRewarded();
    if (!earned || !mounted) return;
    _hintUsed = true;
    setState(() => _hintId = unfound.first.id);
    _hintTimer?.cancel();
    _hintTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => _hintId = null);
    });
  }

  Future<void> _skipLevelViaAd() async {
    if (_completed) return;
    final go = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A0033),
        title: const Text('Sari peste nivel', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Vezi un scurt videoclip pentru a marca nivelul ca rezolvat și a te întoarce acasă.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Renunță', style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(ctx, true),
            icon: const Icon(Icons.play_circle_outline),
            label: const Text('Vezi video'),
          ),
        ],
      ),
    );
    if (go != true || !mounted) return;
    final earned = await AdsService.instance.showRewarded();
    if (!mounted) return;
    if (!earned) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reclama nu e disponibilă acum, încearcă din nou.')),
      );
      return;
    }
    _completed = true;
    _timer?.cancel();
    setState(() {
      for (final t in _level.targets) {
        t.found = true;
      }
    });
    if (mounted) Navigator.pop(context);
  }

  Future<void> _doubleCoinsViaAd(BuildContext dialogCtx, int coins) async {
    final earned = await AdsService.instance.showRewarded();
    if (!mounted) return;
    if (!earned) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reclama nu e disponibilă acum, încearcă din nou.')),
      );
      return;
    }
    await _rewards.addCoins(coins); // a second time => total x2
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('🎬 Recompensă dublată! +$coins monede')),
    );
    if (Navigator.canPop(dialogCtx)) Navigator.pop(dialogCtx);
    if (mounted) Navigator.pop(context);
  }

  Future<void> _bonusLevelsViaAd(BuildContext dialogCtx) async {
    final earned = await AdsService.instance.showRewarded();
    if (!mounted) return;
    if (!earned) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reclama nu e disponibilă acum, încearcă din nou.')),
      );
      return;
    }
    final p = await SharedPreferences.getInstance();
    final cur = p.getInt('hiddenMax') ?? 0;
    await p.setInt('hiddenMax', cur + 2);
    await _rewards.addCoins(400);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('🎁 +2 niveluri bonus + 400 monede!')),
    );
    if (Navigator.canPop(dialogCtx)) Navigator.pop(dialogCtx);
    if (mounted) Navigator.pop(context);
  }

  void _showUnlockToasts(List<Achievement> unlocked) {
    if (unlocked.isEmpty || !mounted) return;
    for (var i = 0; i < unlocked.length; i++) {
      final a = unlocked[i];
      Future.delayed(Duration(milliseconds: 200 + i * 1500), () {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: a.color,
            duration: const Duration(milliseconds: 2200),
            content: Row(
              children: [
                Icon(a.icon, color: Colors.white),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('🏆 Realizare deblocată',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12)),
                      Text(a.title,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15)),
                    ],
                  ),
                ),
              ],
            ),
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

  String _sceneAsset() => 'assets/scenes/${_level.scene.name}.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B14),
      bottomNavigationBar: const BannerAdWidget(),
      appBar: AppBar(
        title: Text(_level.name),
        backgroundColor: Colors.black54,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Indiciu',
            icon: const Icon(Icons.lightbulb_outline),
            onPressed: _completed ? null : _showHintViaAd,
          ),
          IconButton(
            tooltip: 'Sari peste nivel (reclamă)',
            icon: const Icon(Icons.skip_next),
            onPressed: _completed ? null : _skipLevelViaAd,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(_fmt(_seconds),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _targetsBar(),
          Expanded(child: _scene()),
        ],
      ),
    );
  }

  Widget _targetsBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.85),
        border: const Border(bottom: BorderSide(color: Colors.white24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 6),
            child: Text(
              'GĂSEȘTE  ${_level.foundCount}/${_level.totalTargets}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 13,
                letterSpacing: 1.5,
              ),
            ),
          ),
          SizedBox(
            height: 76,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _level.targets.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (ctx, i) {
                final t = _level.targets[i];
                final found = t.found;
                return Opacity(
                  opacity: found ? 0.45 : 1.0,
                  child: Container(
                    width: 64,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: found ? Colors.greenAccent : Colors.white54,
                        width: found ? 2 : 1,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          t.thumb,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const ColoredBox(
                            color: Colors.white12,
                            child: Icon(Icons.search, color: Colors.white54),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            color: Colors.black54,
                            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
                            child: Text(
                              t.label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ),
                        if (found)
                          const Center(
                            child: Icon(Icons.check_circle,
                                color: Colors.greenAccent, size: 30),
                          ),
                      ],
                    ),
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
      final area = Size(c.maxWidth, c.maxHeight);
      final img = _imageRect(area);
      final hint = _hintId == null
          ? null
          : _level.targets.where((t) => t.id == _hintId).cast<FindTarget?>().firstWhere(
              (t) => true,
              orElse: () => null);
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapUp: (d) => _onTapScene(d.localPosition, img),
        child: Stack(
          children: [
            // Blurred fill so the letterbox area is not pure black.
            Positioned.fill(
              child: ClipRect(
                child: ImageFiltered(
                  imageFilter: ui.ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                  child: Image.asset(_sceneAsset(),
                      fit: BoxFit.cover,
                      width: area.width,
                      height: area.height,
                      errorBuilder: (_, __, ___) =>
                          const ColoredBox(color: Color(0xFF14141F))),
                ),
              ),
            ),
            Positioned.fill(child: Container(color: Colors.black.withValues(alpha: 0.25))),
            // The sharp scene.
            Positioned.fromRect(
              rect: img,
              child: Image.asset(_sceneAsset(),
                  fit: BoxFit.fill,
                  errorBuilder: (_, __, ___) => const ColoredBox(color: Color(0xFF1A1A2E))),
            ),
            // Found markers.
            for (final t in _level.targets)
              if (t.found)
                _marker(img, t.cx, t.cy,
                    const Icon(Icons.check_circle,
                        color: Colors.greenAccent, size: 30,
                        shadows: [Shadow(color: Colors.black, blurRadius: 6)])),
            // Hint pulse.
            if (hint != null)
              Positioned(
                left: img.left + hint.cx * img.width - 36,
                top: img.top + hint.cy * img.height - 36,
                child: IgnorePointer(
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.yellowAccent, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.yellowAccent.withValues(alpha: 0.8),
                          blurRadius: 30,
                          spreadRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            // Wrong-tap X.
            if (_missAt != null)
              Positioned(
                left: _missAt!.dx - 18,
                top: _missAt!.dy - 18,
                child: const IgnorePointer(
                  child: Icon(Icons.close,
                      color: Colors.redAccent, size: 36,
                      shadows: [Shadow(color: Colors.black, blurRadius: 6)]),
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _marker(Rect img, double cx, double cy, Widget child) {
    return Positioned(
      left: img.left + cx * img.width - 15,
      top: img.top + cy * img.height - 15,
      child: IgnorePointer(child: child),
    );
  }
}
