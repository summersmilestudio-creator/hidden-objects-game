import 'dart:async';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../game/events.dart';
import '../game/level_data.dart';
import '../game/scene_names.dart';
import '../services/rewards_service.dart';
import '../services/ads_service.dart';
import '../services/lives_service.dart';
import '../services/purchase_service.dart';
import '../services/locale_controller.dart';
import '../widgets/banner_ad_widget.dart';
import '../widgets/game_juice.dart';
import '../widgets/language_picker.dart';
import 'achievements_screen.dart';
import 'daily_reward_screen.dart';
import 'events_screen.dart';
import 'game_screen.dart';
import 'shop_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final _rewards = RewardsService();
  final _lives = LivesService.instance;
  int _coins = 0;
  int _livesCount = LivesService.maxLives;
  int _msToNext = 0;
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkDaily();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _refreshLives());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _ticker?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _refreshLives();
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
    _refreshLives();
  }

  Future<void> _refreshLives() async {
    final lives = await _lives.getLives();
    final ms = await _lives.millisToNextLife();
    if (mounted) {
      setState(() {
        _livesCount = lives;
        _msToNext = ms;
      });
    }
  }

  String _fmtTime(int ms) {
    final total = (ms / 1000).ceil();
    final m = total ~/ 60;
    final s = total % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  /// Starts a level after spending one life; offers refills when out.
  Future<void> _startLevel(int index) async {
    final ok = await _lives.consume();
    if (!ok) {
      _showOutOfLives();
      return;
    }
    await _refreshLives();
    if (!mounted) return;
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => GameScreen(levelIndex: index)));
    _load();
  }

  void _showOutOfLives() {
    final l = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (c) => StatefulBuilder(
        builder: (c, setLocal) {
          bool busy = false;
          return AlertDialog(
            backgroundColor: const Color(0xFF1A0033),
            title: Text(l.outOfLivesTitle, style: const TextStyle(color: Colors.white)),
            content: Text(l.outOfLivesBody,
                textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(c),
                child: Text(l.waitButton, style: const TextStyle(color: Colors.white)),
              ),
              TextButton.icon(
                icon: const Icon(Icons.monetization_on, color: Color(0xFFFFD740)),
                label: Text(l.getLifeCoins(LivesService.lifeCoinCost),
                    style: const TextStyle(color: Color(0xFFFFD740))),
                onPressed: () async {
                  final coins = await _rewards.getCoins();
                  if (coins < LivesService.lifeCoinCost) {
                    if (c.mounted) {
                      ScaffoldMessenger.of(c).showSnackBar(
                        SnackBar(content: Text(l.notEnoughCoins)));
                    }
                    return;
                  }
                  await _rewards.addCoins(-LivesService.lifeCoinCost);
                  await _lives.add(1);
                  await _refreshLives();
                  if (c.mounted) Navigator.pop(c);
                },
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6F00),
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.favorite),
                label: Text(l.getLifeAd),
                onPressed: () async {
                  if (busy) return;
                  setLocal(() => busy = true);
                  final earned = await AdsService.instance.showRewarded();
                  if (earned) {
                    await _lives.add(1);
                    await _refreshLives();
                    if (c.mounted) Navigator.pop(c);
                  } else {
                    setLocal(() => busy = false);
                    if (c.mounted) {
                      ScaffoldMessenger.of(c).showSnackBar(
                        SnackBar(content: Text(l.adNotAvailable)));
                    }
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _openShop() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (_) => const ShopScreen()));
    _load();
  }

  bool _watching = false;
  Future<void> _watchForCoins() async {
    if (_watching) return;
    setState(() => _watching = true);
    final earned = await AdsService.instance.showRewarded();
    if (!mounted) return;
    if (earned) {
      await _rewards.addCoins(10);
      await _load();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.coinsEarned)));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.adNotAvailable)));
    }
    if (mounted) setState(() => _watching = false);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final lang = Localizations.localeOf(context).languageCode;
    final levels = LevelGenerator.generateAll();
    return Scaffold(
      bottomNavigationBar: const BannerAdWidget(),
      body: AnimatedGradientBackground(
        colors: const [Color(0xFF0B0B14), Color(0xFF1A0033), Color(0xFF0B0B14)],
        child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    IconButton(
                      tooltip: l.tooltipAchievements,
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const AchievementsScreen())),
                      icon: const Icon(Icons.emoji_events, color: Color(0xFFFFCA28), size: 28),
                    ),
                    IconButton(
                      tooltip: l.tooltipEvents,
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const EventsScreen())),
                      icon: const Icon(Icons.event_available, color: Color(0xFFFF6F00), size: 28),
                    ),
                    IconButton(
                      tooltip: l.tooltipShop,
                      onPressed: _openShop,
                      icon: const Icon(Icons.storefront, color: Color(0xFFFFD740), size: 28),
                    ),
                    IconButton(
                      tooltip: l.language,
                      onPressed: () => showLanguagePicker(context),
                      icon: Text(
                        LocaleController.flagFor(Localizations.localeOf(context).languageCode),
                        style: const TextStyle(fontSize: 26),
                      ),
                    ),
                  ]),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: _openShop,
                      child: Container(
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
                            const SizedBox(width: 4),
                            const Icon(Icons.add_circle, color: Color(0xFFFFD740), size: 18),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ShaderMask(
                shaderCallback: (r) => const LinearGradient(
                  colors: [Color(0xFFFF6F00), Color(0xFFFFCA28)],
                ).createShader(r),
                child: Text(l.homeTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1.0,
                        letterSpacing: 2)),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(l.homeSubtitle,
                    style: const TextStyle(color: Colors.white54)),
              ),
              const SizedBox(height: 12),
              _livesCard(l),
              const SizedBox(height: 12),
              _TodayEventCard(onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const EventsScreen()))),
              const SizedBox(height: 12),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: _watching ? null : _watchForCoins,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xFF43A047), Color(0xFF1B5E20)]),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFFFD740)),
                    ),
                    child: Row(children: [
                      const Icon(Icons.smart_display, color: Colors.white),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(l.watchAd10Coins,
                            style: const TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w800)),
                      ),
                      const Icon(Icons.monetization_on, color: Color(0xFFFFD740)),
                    ]),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _removeAdsButton(l),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(l.scenesHeader,
                    style: const TextStyle(
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
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withValues(alpha: 0.5),
                              blurRadius: 14,
                              offset: const Offset(0, 8)),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: SizedBox(
                          height: 104,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              // Real scene art as the card background (premium look).
                              Image.asset(
                                'assets/scenes/${lvl.scene.name}.jpg',
                                fit: BoxFit.cover,
                                cacheWidth: 600,
                                errorBuilder: (_, __, ___) => DecoratedBox(
                                    decoration: BoxDecoration(gradient: _gradientFor(lvl.scene))),
                              ),
                              // Dark scrim so the text stays readable.
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.black.withValues(alpha: 0.80),
                                      Colors.black.withValues(alpha: 0.25),
                                    ],
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => _startLevel(i),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 42,
                                          height: 42,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: _gradientFor(lvl.scene),
                                            border: Border.all(color: Colors.white70, width: 2),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black.withValues(alpha: 0.4),
                                                  blurRadius: 6),
                                            ],
                                          ),
                                          child: Text('${i + 1}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w900, color: Colors.white)),
                                        ),
                                        const SizedBox(width: 14),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(sceneNameFor(lvl.scene, lang, lvl.name),
                                                  style: const TextStyle(
                                                      fontSize: 21,
                                                      fontWeight: FontWeight.w900,
                                                      color: Colors.white,
                                                      shadows: [
                                                        Shadow(color: Colors.black, blurRadius: 6)
                                                      ])),
                                              Text(l.objectsToFind(lvl.totalTargets),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12.5,
                                                      shadows: [
                                                        Shadow(color: Colors.black, blurRadius: 6)
                                                      ])),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black.withValues(alpha: 0.35),
                                          ),
                                          child: const Icon(Icons.play_arrow,
                                              color: Colors.white, size: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
      ),
    );
  }

  Widget _livesCard(AppLocalizations l) {
    final full = _livesCount >= LivesService.maxLives;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFF6F00).withValues(alpha: 0.6)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < LivesService.maxLives; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Icon(
                i < _livesCount ? Icons.favorite : Icons.favorite_border,
                color: i < _livesCount ? const Color(0xFFFF5252) : Colors.white30,
                size: 22,
              ),
            ),
          const SizedBox(width: 10),
          Text(
            full ? l.livesFull : l.nextLifeIn(_fmtTime(_msToNext)),
            style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _removeAdsButton(AppLocalizations l) {
    final svc = PurchaseService.instance;
    return ValueListenableBuilder<bool>(
      valueListenable: svc.noAdsNotifier,
      builder: (ctx, noAds, _) {
        if (noAds) return const SizedBox.shrink();
        final price = svc.productFor(PurchaseService.noAdsId)?.price;
        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: _openShop,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFFF6F00), Color(0xFFE65100)]),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: const Color(0xFFFF6F00).withValues(alpha: 0.5), blurRadius: 10),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.block, color: Colors.white),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      price != null ? '${l.removeAdsTitle} • $price' : l.removeAdsTitle,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16),
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.white),
                ],
              ),
            ),
          ),
        );
      },
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
      case SceneType.bedroom:
        return const LinearGradient(colors: [Color(0xFFCE93D8), Color(0xFF6A1B9A)]);
      case SceneType.bathroom:
        return const LinearGradient(colors: [Color(0xFF80DEEA), Color(0xFF006064)]);
      case SceneType.livingRoom:
        return const LinearGradient(colors: [Color(0xFFFFAB91), Color(0xFFBF360C)]);
      case SceneType.office:
        return const LinearGradient(colors: [Color(0xFF90CAF9), Color(0xFF0D47A1)]);
      case SceneType.workshop:
        return const LinearGradient(colors: [Color(0xFFA1887F), Color(0xFF3E2723)]);
      case SceneType.cellar:
        return const LinearGradient(colors: [Color(0xFF6A1B9A), Color(0xFF311B92)]);
      case SceneType.ballroom:
        return const LinearGradient(colors: [Color(0xFFFFD740), Color(0xFFB8860B)]);
      case SceneType.greenhouse:
        return const LinearGradient(colors: [Color(0xFFA5D6A7), Color(0xFF2E7D32)]);
      case SceneType.cave:
        return const LinearGradient(colors: [Color(0xFF7E57C2), Color(0xFF311B92)]);
      case SceneType.castle:
        return const LinearGradient(colors: [Color(0xFF90A4AE), Color(0xFF263238)]);
      case SceneType.dungeon:
        return const LinearGradient(colors: [Color(0xFF455A64), Color(0xFF000000)]);
      case SceneType.ship:
        return const LinearGradient(colors: [Color(0xFF42A5F5), Color(0xFF01579B)]);
      case SceneType.underwater:
        return const LinearGradient(colors: [Color(0xFF26C6DA), Color(0xFF004D40)]);
      case SceneType.spaceStation:
        return const LinearGradient(colors: [Color(0xFF7C4DFF), Color(0xFF000051)]);
      case SceneType.observatory:
        return const LinearGradient(colors: [Color(0xFF3F51B5), Color(0xFF1A237E)]);
      case SceneType.magicShop:
        return const LinearGradient(colors: [Color(0xFFEC407A), Color(0xFF4A148C)]);
      case SceneType.desert:
        return const LinearGradient(colors: [Color(0xFFFFCA28), Color(0xFFBF360C)]);
      case SceneType.snow:
        return const LinearGradient(colors: [Color(0xFFB3E5FC), Color(0xFF01579B)]);
      case SceneType.circus:
        return const LinearGradient(colors: [Color(0xFFEF5350), Color(0xFFAD1457)]);
      case SceneType.carnival:
        return const LinearGradient(colors: [Color(0xFFFF80AB), Color(0xFF880E4F)]);
      case SceneType.bakery:
        return const LinearGradient(colors: [Color(0xFFFFCC80), Color(0xFFE65100)]);
      case SceneType.cafe:
        return const LinearGradient(colors: [Color(0xFFD7CCC8), Color(0xFF4E342E)]);
      case SceneType.flowerShop:
        return const LinearGradient(colors: [Color(0xFFF8BBD0), Color(0xFFAD1457)]);
      case SceneType.toyStore:
        return const LinearGradient(colors: [Color(0xFFFFAB40), Color(0xFFE91E63)]);
      case SceneType.toolShed:
        return const LinearGradient(colors: [Color(0xFF8D6E63), Color(0xFF3E2723)]);
      case SceneType.musicRoom:
        return const LinearGradient(colors: [Color(0xFF9575CD), Color(0xFF311B92)]);
      case SceneType.artStudio:
        return const LinearGradient(colors: [Color(0xFFFF8A65), Color(0xFFD84315)]);
      case SceneType.gym:
        return const LinearGradient(colors: [Color(0xFF4FC3F7), Color(0xFF01579B)]);
      case SceneType.laundry:
        return const LinearGradient(colors: [Color(0xFF80DEEA), Color(0xFF00838F)]);
      case SceneType.pharmacy:
        return const LinearGradient(colors: [Color(0xFF81C784), Color(0xFF1B5E20)]);
      case SceneType.fishMarket:
        return const LinearGradient(colors: [Color(0xFF4DD0E1), Color(0xFF006064)]);
      case SceneType.candyShop:
        return const LinearGradient(colors: [Color(0xFFF48FB1), Color(0xFFAD1457)]);
      case SceneType.jewelryStore:
        return const LinearGradient(colors: [Color(0xFFFFD740), Color(0xFF9E7B00)]);
      case SceneType.barberShop:
        return const LinearGradient(colors: [Color(0xFF90A4AE), Color(0xFF37474F)]);
      case SceneType.gasStation:
        return const LinearGradient(colors: [Color(0xFFEF5350), Color(0xFFB71C1C)]);
      case SceneType.barn:
        return const LinearGradient(colors: [Color(0xFFFFB74D), Color(0xFF8D6E63)]);
      case SceneType.vineyard:
        return const LinearGradient(colors: [Color(0xFFBA68C8), Color(0xFF4A148C)]);
      case SceneType.lighthouse:
        return const LinearGradient(colors: [Color(0xFF4FC3F7), Color(0xFF0D47A1)]);
      case SceneType.aquarium:
        return const LinearGradient(colors: [Color(0xFF26C6DA), Color(0xFF00695C)]);
      case SceneType.museum:
        return const LinearGradient(colors: [Color(0xFFA1887F), Color(0xFF4E342E)]);
      case SceneType.classroom:
        return const LinearGradient(colors: [Color(0xFFFFD54F), Color(0xFFEF6C00)]);
      case SceneType.playground:
        return const LinearGradient(colors: [Color(0xFF81C784), Color(0xFF2E7D32)]);
    }
  }
}

class _TodayEventCard extends StatelessWidget {
  final VoidCallback onTap;
  const _TodayEventCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final e = EventService.today();
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: e.colors, begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: e.colors.last.withValues(alpha: 0.55),
                  blurRadius: 18, offset: const Offset(0, 8)),
            ],
          ),
          child: Row(children: [
            Text(e.emoji, style: const TextStyle(fontSize: 36)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(l.eventToday,
                    style: const TextStyle(color: Colors.white70, fontSize: 10,
                        fontWeight: FontWeight.w800, letterSpacing: 1.4)),
                Text(e.localizedName(l),
                    style: const TextStyle(color: Colors.white, fontSize: 18,
                        fontWeight: FontWeight.w900)),
                Text(e.localizedDescription(l),
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
              ]),
            ),
            const Icon(Icons.chevron_right, color: Colors.white),
          ]),
        ),
      ),
    );
  }
}
