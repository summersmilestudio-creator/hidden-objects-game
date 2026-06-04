import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../services/rewards_service.dart';
import '../services/ads_service.dart';

class DailyRewardScreen extends StatefulWidget {
  final int day;
  final int reward;
  const DailyRewardScreen({super.key, required this.day, required this.reward});

  @override
  State<DailyRewardScreen> createState() => _DailyRewardScreenState();
}

class _DailyRewardScreenState extends State<DailyRewardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..forward();
    HapticFeedback.heavyImpact();
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  bool _doubling = false;
  Future<void> _doubleViaAd() async {
    if (_doubling) return;
    _doubling = true;
    final earned = await AdsService.instance.showRewarded();
    if (!mounted) return;
    if (earned) {
      await RewardsService().addCoins(widget.reward); // second time => x2
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.bonusDoubled(widget.reward))),
      );
      Navigator.pop(context);
    } else {
      _doubling = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.adNotAvailable)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: Tween(begin: 0.6, end: 1.0).animate(
                    CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut),
                  ),
                  child: const Text('🔍', style: TextStyle(fontSize: 100)),
                ),
                const SizedBox(height: 16),
                ShaderMask(
                  shaderCallback: (r) => const LinearGradient(
                    colors: [Color(0xFFFF6F00), Color(0xFFFFCA28)],
                  ).createShader(r),
                  child: Text(l.dailyBonus,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.w900,
                          color: Colors.white, letterSpacing: 4)),
                ),
                const SizedBox(height: 8),
                Text(l.dayOfSeven(widget.day),
                    style: const TextStyle(color: Colors.white60, fontSize: 16)),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFFF6F00), width: 2),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.monetization_on, color: Color(0xFFFFD740), size: 48),
                      const SizedBox(width: 12),
                      Text('+${widget.reward}',
                          style: const TextStyle(
                              fontSize: 48, fontWeight: FontWeight.w900,
                              color: Color(0xFFFFD740))),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(7, (i) {
                    final day = i + 1;
                    final claimed = day <= widget.day;
                    final isToday = day == widget.day;
                    return Container(
                      width: 60, height: 80,
                      decoration: BoxDecoration(
                        color: isToday
                            ? const Color(0xFFFF6F00).withValues(alpha: 0.4)
                            : (claimed ? Colors.green.withValues(alpha: 0.3) : Colors.white12),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isToday ? const Color(0xFFFF6F00) : Colors.white24,
                          width: isToday ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(l.dayShort(day),
                              style: TextStyle(
                                  color: claimed ? Colors.white : Colors.white60, fontSize: 11)),
                          const SizedBox(height: 4),
                          if (claimed)
                            const Icon(Icons.check, color: Colors.white, size: 18)
                          else
                            const Icon(Icons.monetization_on, color: Color(0xFFFFD740), size: 18),
                          Text('${RewardsService.dailyRewards[i]}',
                              style: TextStyle(
                                  color: claimed ? Colors.white : Colors.white60,
                                  fontSize: 12, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 28),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD740),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  onPressed: _doubleViaAd,
                  icon: const Icon(Icons.smart_display),
                  label: Text(l.doubleX2WithReward(widget.reward)),
                ),
                const SizedBox(height: 12),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(l.claim),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
