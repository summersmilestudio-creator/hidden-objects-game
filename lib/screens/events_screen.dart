import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../game/events.dart';
import '../game/level_data.dart';
import 'game_screen.dart';

const _bgTop = Color(0xFF2A1E63);
const _bgMid = Color(0xFF1B1342);
const _bgBottom = Color(0xFF0E0A26);

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  Future<void> _playToday(BuildContext context) async {
    // Pick a level deterministic on the day so today's event keeps the same
    // scene the user already saw on the calendar card.
    final levels = LevelGenerator.generateAll();
    final idx = DateTime.now().day % levels.length;
    if (!context.mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) => GameScreen(levelIndex: idx)));
  }

  String _dayLabel(AppLocalizations l, DateTime d, int i) {
    if (i == 0) return l.today;
    if (i == 1) return l.tomorrow;
    final wd = [
      l.weekdayMon, l.weekdayTue, l.weekdayWed, l.weekdayThu,
      l.weekdayFri, l.weekdaySat, l.weekdaySun,
    ];
    return '${wd[d.weekday - 1]} ${d.day}';
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final events = EventService.upcoming(14);
    final today = events.first;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: _bgMid,
      appBar: AppBar(
        title: Text(l.eventsTitle, style: const TextStyle(fontWeight: FontWeight.w700)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.5), radius: 1.3,
            colors: [_bgTop, _bgMid, _bgBottom], stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: today.colors, begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: today.colors.last.withValues(alpha: 0.5),
                        blurRadius: 24, offset: const Offset(0, 10)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(today.emoji, style: const TextStyle(fontSize: 40)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(l.eventOfTheDay,
                              style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
                          Text(today.localizedName(l),
                              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800)),
                        ]),
                      ),
                    ]),
                    const SizedBox(height: 10),
                    Text(today.localizedDescription(l), style: const TextStyle(color: Colors.white, fontSize: 15)),
                    const SizedBox(height: 8),
                    Row(children: [
                      const Icon(Icons.star_rounded, color: Colors.amberAccent, size: 20),
                      Text(' ${l.rewardStars(today.rewardStars)}',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                    ]),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: today.colors.last,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        onPressed: () => _playToday(context),
                        icon: const Icon(Icons.play_arrow_rounded),
                        label: Text(l.playNow, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 8),
                child: Text(l.eventCalendar,
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
              ),
              for (var i = 1; i < events.length; i++)
                _EventRow(event: events[i], label: _dayLabel(l, events[i].date, i)),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventRow extends StatelessWidget {
  final GameEvent event;
  final String label;
  const _EventRow({required this.event, required this.label});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Container(
            width: 48, height: 48, alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: event.colors),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(event.emoji, style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w600)),
                if (event.special) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                    decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(6)),
                    child: Text(l.special, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Colors.black87)),
                  ),
                ],
              ]),
              Text(event.localizedName(l), style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
              Text(event.localizedDescription(l), style: const TextStyle(color: Colors.white60, fontSize: 12)),
            ]),
          ),
          Column(children: [
            const Icon(Icons.star_rounded, color: Colors.amberAccent, size: 18),
            Text('${event.rewardStars}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          ]),
        ],
      ),
    );
  }
}
