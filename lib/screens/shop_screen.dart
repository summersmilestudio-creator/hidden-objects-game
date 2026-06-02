import 'package:flutter/material.dart';
import '../services/purchase_service.dart';
import '../services/rewards_service.dart';

/// In-app store: Remove Ads + coin packs. Reachable from the home screen
/// (coin pill and the store button), so every In-App Purchase is one tap away.
class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final _rewards = RewardsService();
  final _purchases = PurchaseService.instance;
  int _coins = 0;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _purchases.purchaseTick.addListener(_onPurchase);
    _load();
  }

  @override
  void dispose() {
    _purchases.purchaseTick.removeListener(_onPurchase);
    super.dispose();
  }

  void _onPurchase() {
    _load();
    if (mounted) {
      setState(() => _busy = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Cumpărare reușită. Mulțumim!')));
    }
  }

  Future<void> _load() async {
    final c = await _rewards.getCoins();
    if (mounted) setState(() => _coins = c);
  }

  Future<void> _buy(String logicalId) async {
    if (_busy) return;
    setState(() => _busy = true);
    final ok = await _purchases.buy(logicalId);
    // On success the native purchase sheet drives _onPurchase via the stream.
    if (!ok && mounted) {
      setState(() => _busy = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Magazinul nu este disponibil acum. Încearcă din nou.')));
    }
  }

  Future<void> _restore() async {
    await _purchases.restore();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Se restaurează cumpărăturile…')));
    }
  }

  String _priceFor(String logicalId, String fallback) =>
      _purchases.productFor(logicalId)?.price ?? fallback;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magazin', style: TextStyle(fontWeight: FontWeight.w900)),
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: _restore,
            child: const Text('Restaurează', style: TextStyle(color: Color(0xFFFFD740))),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // current balance
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFFD740)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.monetization_on, color: Color(0xFFFFD740)),
                  const SizedBox(width: 10),
                  const Text('Monedele tale',
                      style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w700)),
                  const Spacer(),
                  Text('$_coins',
                      style: const TextStyle(
                          color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Remove Ads
            ValueListenableBuilder<bool>(
              valueListenable: _purchases.noAdsNotifier,
              builder: (_, noAds, child) {
                if (noAds) {
                  return _Banner(
                    icon: Icons.verified,
                    colors: const [Color(0xFF43A047), Color(0xFF1B5E20)],
                    title: 'Reclame eliminate',
                    subtitle: 'Mulțumim pentru susținere!',
                  );
                }
                return _ShopCard(
                  icon: Icons.block,
                  iconColor: const Color(0xFFFF6F00),
                  title: 'Elimină reclamele',
                  subtitle: 'Fără bannere și reclame interstițiale',
                  price: _priceFor(PurchaseService.noAdsId, '2.99 \$'),
                  busy: _busy,
                  onTap: () => _buy(PurchaseService.noAdsId),
                );
              },
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text('PACHETE DE MONEDE',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2)),
            ),
            const SizedBox(height: 12),
            for (final pack in PurchaseService.coinPacks) ...[
              _ShopCard(
                icon: Icons.monetization_on,
                iconColor: const Color(0xFFFFD740),
                title: pack.bonus > 0
                    ? '${pack.coins} + ${pack.bonus} bonus monede'
                    : '${pack.coins} monede',
                subtitle: pack.bonus > 0 ? 'Cea mai bună valoare' : 'Mai multe indicii',
                price: _priceFor(pack.id, '—'),
                busy: _busy,
                onTap: () => _buy(pack.id),
              ),
              const SizedBox(height: 12),
            ],
            const SizedBox(height: 8),
            const Center(
              child: Text('Plata se face prin contul tău App Store.',
                  style: TextStyle(color: Colors.white38, fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShopCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String price;
  final bool busy;
  final VoidCallback onTap;

  const _ShopCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.busy,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: busy ? null : onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white24),
          ),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 32),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
                    Text(subtitle,
                        style: const TextStyle(color: Colors.white54, fontSize: 12)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color(0xFFFF6F00), Color(0xFFFFCA28)]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(price,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w900, fontSize: 15)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  final IconData icon;
  final List<Color> colors;
  final String title;
  final String subtitle;

  const _Banner({
    required this.icon,
    required this.colors,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900)),
                Text(subtitle,
                    style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
