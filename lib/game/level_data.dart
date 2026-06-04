import 'dart:convert';
import 'dart:ui' show PlatformDispatcher;
import 'package:flutter/services.dart' show rootBundle;

/// The 10 non-ro locales that ship translated object labels in
/// `assets/i18n/labels_<lang>.json`. RO uses the labels embedded in
/// hotspots.json directly (no labels file needed).
const Set<String> kSupportedLabelLangs = {
  'en', 'es', 'pt', 'fr', 'de', 'it', 'ru', 'ja', 'ko', 'zh',
};

/// 50 hidden-object scenes. Each scene ships a premium AI-illustrated PNG in
/// `assets/scenes/<name>.png` plus a list of *real* findable objects defined in
/// `assets/hotspots.json`. Objects are no longer flat Material icons scattered
/// at random — they are actual things drawn into the scene art. The bottom
/// "find these" bar shows real cropped thumbnails (`assets/thumbs/...`).
enum SceneType {
  // Original 32
  garden, beach, city, forest, kitchen, library, attic, beachSunset,
  bedroom, bathroom, livingRoom, office, workshop, cellar, ballroom, greenhouse,
  cave, castle, dungeon, ship, underwater, spaceStation, observatory, magicShop,
  desert, snow, circus, carnival, bakery, cafe, flowerShop, toyStore,
  // 18 new
  toolShed, musicRoom, artStudio, gym, laundry, pharmacy, fishMarket, candyShop,
  jewelryStore, barberShop, gasStation, barn, vineyard, lighthouse, aquarium,
  museum, classroom, playground,
}

/// A real findable object inside a scene. (cx, cy) is the normalized center
/// (0..1 of the displayed image) and [r] the normalized tap radius. [thumb] is
/// the asset path of the cropped illustration shown in the "find these" bar.
class FindTarget {
  final String id;
  final String label;
  final double cx;
  final double cy;
  final double r;
  final String thumb;
  bool found;
  FindTarget({
    required this.id,
    required this.label,
    required this.cx,
    required this.cy,
    required this.r,
    required this.thumb,
    this.found = false,
  });
}

class Level {
  final String name;
  final SceneType scene;
  final List<FindTarget> targets;
  Level({required this.name, required this.scene, required this.targets});
  int get foundCount => targets.where((t) => t.found).length;
  int get totalTargets => targets.length;
  bool get isComplete => totalTargets > 0 && foundCount == totalTargets;
}

/// Loads the hotspot definitions once at startup. Call [preload] in main()
/// before runApp so the synchronous [LevelGenerator.generateAll] has data.
class LevelStore {
  static Map<String, dynamic> _hotspots = {};
  static Map<String, String> _labels = {}; // id -> localized label (current locale)
  static bool _loaded = false;

  static Future<void> preload() async {
    if (_loaded) return;
    try {
      final raw = await rootBundle.loadString('assets/hotspots.json');
      _hotspots = json.decode(raw) as Map<String, dynamic>;
    } catch (_) {
      _hotspots = {};
    }
    await _loadLabelsForLocale();
    _loaded = true;
  }

  /// Loads the object-label translations for the current device locale, when it
  /// is one of the 10 supported languages. RO (and anything else) keeps the
  /// labels embedded in hotspots.json. Never throws — falls back to RO.
  static Future<void> _loadLabelsForLocale() async {
    _labels = {};
    try {
      final lang = PlatformDispatcher.instance.locale.languageCode.toLowerCase();
      if (!kSupportedLabelLangs.contains(lang)) return;
      final raw = await rootBundle.loadString('assets/i18n/labels_$lang.json');
      final map = json.decode(raw) as Map<String, dynamic>;
      _labels = map.map((k, v) => MapEntry(k, v.toString()));
    } catch (_) {
      _labels = {}; // fall back to RO labels from hotspots.json
    }
  }

  static List<FindTarget> _targetsFor(SceneType scene) {
    final data = _hotspots[scene.name];
    if (data is! Map) return [];
    final objs = data['objects'];
    if (objs is! List) return [];
    return objs.map<FindTarget>((o) {
      final m = o as Map;
      final id = m['id'] as String;
      final roLabel = (m['label'] ?? id) as String;
      return FindTarget(
        id: id,
        label: _labels[id] ?? roLabel,
        cx: (m['cx'] as num).toDouble(),
        cy: (m['cy'] as num).toDouble(),
        r: (m['r'] as num?)?.toDouble() ?? 0.08,
        thumb: 'assets/thumbs/${scene.name}__$id.png',
      );
    }).toList();
  }
}

class LevelGenerator {
  /// Ordered master list of all 50 scenes with their display names. A scene
  /// only appears in the menu once it has hotspots authored in hotspots.json,
  /// so the rollout degrades gracefully (no broken / empty levels shown).
  static const List<(SceneType, String)> _master = [
    (SceneType.garden, 'Grădină Magică'),
    (SceneType.beachSunset, 'Plajă la Apus'),
    (SceneType.forest, 'Pădure Misterioasă'),
    (SceneType.library, 'Bibliotecă Veche'),
    (SceneType.kitchen, 'Bucătăria Bunicii'),
    (SceneType.attic, 'Pod cu Comori'),
    (SceneType.city, 'Oraș de Noapte'),
    (SceneType.beach, 'Plajă Tropicală'),
    (SceneType.bedroom, 'Dormitor Copilărie'),
    (SceneType.bathroom, 'Baie Vintage'),
    (SceneType.livingRoom, 'Sufragerie Caldă'),
    (SceneType.office, 'Biroul Detectivului'),
    (SceneType.workshop, 'Atelierul Inventatorului'),
    (SceneType.cellar, 'Pivnița cu Vinuri'),
    (SceneType.ballroom, 'Bal Mascat'),
    (SceneType.greenhouse, 'Seră Botanică'),
    (SceneType.cave, 'Peștera Cristalelor'),
    (SceneType.castle, 'Castelul Pierdut'),
    (SceneType.dungeon, 'Temnița Dragonului'),
    (SceneType.ship, 'Corabia Piraților'),
    (SceneType.underwater, 'Adâncuri Marine'),
    (SceneType.spaceStation, 'Stația Spațială'),
    (SceneType.observatory, 'Observatorul Stelar'),
    (SceneType.magicShop, 'Prăvălia Magică'),
    (SceneType.desert, 'Oaza din Deșert'),
    (SceneType.snow, 'Cabana Înzăpezită'),
    (SceneType.circus, 'Cortul Circului'),
    (SceneType.carnival, 'Bâlciul Vesel'),
    (SceneType.bakery, 'Brutăria Bunicii'),
    (SceneType.cafe, 'Cafenea Pariziană'),
    (SceneType.flowerShop, 'Florăria din Colț'),
    (SceneType.toyStore, 'Magazinul de Jucării'),
    (SceneType.toolShed, 'Magazia de Unelte'),
    (SceneType.musicRoom, 'Camera de Muzică'),
    (SceneType.artStudio, 'Atelierul de Artă'),
    (SceneType.gym, 'Sala de Sport'),
    (SceneType.laundry, 'Spălătoria'),
    (SceneType.pharmacy, 'Farmacia Veche'),
    (SceneType.fishMarket, 'Piața de Pește'),
    (SceneType.candyShop, 'Magazinul de Dulciuri'),
    (SceneType.jewelryStore, 'Bijuteria'),
    (SceneType.barberShop, 'Frizeria Retro'),
    (SceneType.gasStation, 'Benzinăria'),
    (SceneType.barn, 'Hambarul Fermei'),
    (SceneType.vineyard, 'Crama de la Vie'),
    (SceneType.lighthouse, 'Farul de la Mare'),
    (SceneType.aquarium, 'Acvariul Public'),
    (SceneType.museum, 'Muzeul de Istorie'),
    (SceneType.classroom, 'Sala de Clasă'),
    (SceneType.playground, 'Parcul de Joacă'),
  ];

  /// Build a fresh list of playable levels (only scenes with authored hotspots).
  static List<Level> generateAll() {
    final out = <Level>[];
    for (final (scene, name) in _master) {
      final targets = LevelStore._targetsFor(scene);
      if (targets.isEmpty) continue;
      out.add(Level(name: name, scene: scene, targets: targets));
    }
    return out;
  }
}
