// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get appTitle => 'Obiecte Ascunse';

  @override
  String get homeTitle => 'OBIECTE\nASCUNSE';

  @override
  String get homeSubtitle => 'Găsește obiectele în scenele pictate';

  @override
  String get scenesHeader => 'Scene';

  @override
  String get tooltipAchievements => 'Realizări';

  @override
  String get tooltipEvents => 'Evenimente';

  @override
  String get tooltipShop => 'Magazin';

  @override
  String get watchAdForCoins => 'Vezi o reclamă → +50 monede';

  @override
  String get coinsEarned => '🎬 +50 monede!';

  @override
  String get adNotAvailable =>
      'Reclama nu e disponibilă acum, încearcă din nou.';

  @override
  String objectsToFind(int count) {
    return '$count obiecte de găsit';
  }

  @override
  String get eventToday => 'EVENIMENT AZI';

  @override
  String get tooltipHint => 'Indiciu';

  @override
  String get tooltipSkipLevel => 'Sari peste nivel (reclamă)';

  @override
  String findProgress(int found, int total) {
    return 'GĂSEȘTE  $found/$total';
  }

  @override
  String get levelComplete => '🎉 Nivel complet!';

  @override
  String allObjectsFoundIn(int total, String time) {
    return 'Toate $total obiectele găsite în $time';
  }

  @override
  String get doubleX2 => 'Dublează ×2';

  @override
  String get bonusLevels => '+2 niveluri 🎁';

  @override
  String get back => 'Înapoi';

  @override
  String get skipLevelTitle => 'Sari peste nivel';

  @override
  String get skipLevelBody =>
      'Vezi un scurt videoclip pentru a marca nivelul ca rezolvat și a te întoarce acasă.';

  @override
  String get cancel => 'Renunță';

  @override
  String get watchVideo => 'Vezi video';

  @override
  String rewardDoubled(int coins) {
    return '🎬 Recompensă dublată! +$coins monede';
  }

  @override
  String get bonusLevelsGranted => '🎁 +2 niveluri bonus + 400 monede!';

  @override
  String get achievementUnlocked => '🏆 Realizare deblocată';

  @override
  String get shopTitle => 'Magazin';

  @override
  String get restore => 'Restaurează';

  @override
  String get purchaseSuccess => '✅ Cumpărare reușită. Mulțumim!';

  @override
  String get shopUnavailable =>
      'Magazinul nu este disponibil acum. Încearcă din nou.';

  @override
  String get restoringPurchases => 'Se restaurează cumpărăturile…';

  @override
  String get yourCoins => 'Monedele tale';

  @override
  String get adsRemovedTitle => 'Reclame eliminate';

  @override
  String get adsRemovedSubtitle => 'Mulțumim pentru susținere!';

  @override
  String get removeAdsTitle => 'Elimină reclamele';

  @override
  String get removeAdsSubtitle => 'Fără bannere și reclame interstițiale';

  @override
  String get coinPacks => 'PACHETE DE MONEDE';

  @override
  String coinPackBonus(int coins, int bonus) {
    return '$coins + $bonus bonus monede';
  }

  @override
  String coinPackPlain(int coins) {
    return '$coins monede';
  }

  @override
  String get bestValue => 'Cea mai bună valoare';

  @override
  String get moreHints => 'Mai multe indicii';

  @override
  String get paymentNotice => 'Plata se face prin contul tău App Store.';

  @override
  String get achievementsTitle => 'Realizări';

  @override
  String get totalProgress => 'Progres total';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked din $total realizări';
  }

  @override
  String get dailyBonus => 'BONUS ZILNIC';

  @override
  String dayOfSeven(int day) {
    return 'Ziua $day / 7';
  }

  @override
  String dayShort(int day) {
    return 'Z$day';
  }

  @override
  String doubleX2WithReward(int reward) {
    return 'DUBLEAZĂ ×2  (+$reward)';
  }

  @override
  String get claim => 'PRIMEȘTE';

  @override
  String bonusDoubled(int reward) {
    return '🎬 Bonus dublat! +$reward monede';
  }

  @override
  String get eventsTitle => 'Evenimente';

  @override
  String get eventOfTheDay => 'EVENIMENTUL DE AZI';

  @override
  String rewardStars(int stars) {
    return '$stars stele recompensă';
  }

  @override
  String get playNow => 'Joacă acum';

  @override
  String get eventCalendar => 'Calendar evenimente';

  @override
  String get special => 'SPECIAL';

  @override
  String get today => 'Azi';

  @override
  String get tomorrow => 'Mâine';

  @override
  String get weekdayMon => 'Lun';

  @override
  String get weekdayTue => 'Mar';

  @override
  String get weekdayWed => 'Mie';

  @override
  String get weekdayThu => 'Joi';

  @override
  String get weekdayFri => 'Vin';

  @override
  String get weekdaySat => 'Sâm';

  @override
  String get weekdaySun => 'Dum';

  @override
  String get escapeAdsTitle => 'Scapă de reclame';

  @override
  String get escapeAdsBody =>
      'Joacă fără bannere și fără reclame care te întrerup. O singură dată, pentru totdeauna.';

  @override
  String removeAdsForPrice(String price) {
    return 'Elimină reclamele • $price';
  }

  @override
  String get later => 'Mai târziu';

  @override
  String get notificationTitle => 'Obiecte Ascunse';

  @override
  String get notificationBody => 'Găsește obiectele ascunse! 🔍';

  @override
  String get achFirstFindTitle => 'Prima Descoperire';

  @override
  String get achFirstFindDesc => 'Găsește primul obiect';

  @override
  String get achGardenMasterTitle => 'Maestrul Grădinii';

  @override
  String get achGardenMasterDesc => 'Termină Grădina Magică';

  @override
  String get achHalfwayHeroTitle => 'Erou la Jumătate';

  @override
  String get achHalfwayHeroDesc => 'Termină 4 scene';

  @override
  String get achMasterDetectiveTitle => 'Detectiv Maestru';

  @override
  String get achMasterDetectiveDesc => 'Termină toate 8 scenele';

  @override
  String get achHawkEyeTitle => 'Ochi de Șoim';

  @override
  String get achHawkEyeDesc => 'Găsește 50 de obiecte total';

  @override
  String get achEagleEyeTitle => 'Ochi de Vultur';

  @override
  String get achEagleEyeDesc => 'Găsește 200 de obiecte total';

  @override
  String get achNoCheatTitle => 'Fără Trișat';

  @override
  String get achNoCheatDesc => 'Termină o scenă fără indiciu';

  @override
  String get achSpeedRunnerTitle => 'Alergător Rapid';

  @override
  String get achSpeedRunnerDesc => 'Termină o scenă sub 30 secunde';

  @override
  String get evtDailyChallengeName => 'Provocarea Zilei';

  @override
  String get evtDailyChallengeDesc =>
      'Găsește toate obiectele într-o singură scenă';

  @override
  String get evtHawkEyeName => 'Ochi de Vultur';

  @override
  String get evtHawkEyeDesc => 'Termină o scenă fără să folosești indiciu';

  @override
  String get evtQuickHuntName => 'Vânătoarea Rapidă';

  @override
  String get evtQuickHuntDesc => 'Găsește 5 obiecte sub 60 de secunde';

  @override
  String get evtMarathonName => 'Detectiv Maraton';

  @override
  String get evtMarathonDesc => 'Joacă 3 scene diferite astăzi';

  @override
  String get evtCollectorName => 'Colecționarul';

  @override
  String get evtCollectorDesc => 'Strânge 25 de obiecte azi';

  @override
  String get evtTreasureHuntName => 'Vânătoarea de Comori';

  @override
  String get evtTreasureHuntDesc =>
      'Termină 5 scene la rând cu toate obiectele';

  @override
  String get evtHintMasterName => 'Maestrul Indiciilor';

  @override
  String get evtHintMasterDesc => 'Găsește 50 de obiecte în weekend';

  @override
  String get livesFull => 'Vieți pline';

  @override
  String nextLifeIn(String time) {
    return 'Următoarea viață în $time';
  }

  @override
  String get outOfLivesTitle => 'Nu mai ai vieți';

  @override
  String get outOfLivesBody =>
      'Așteaptă refacerea lor, vezi o reclamă sau folosește monede.';

  @override
  String get getLifeAd => '+1 viață (reclamă)';

  @override
  String getLifeCoins(int coins) {
    return '+1 viață ($coins 🪙)';
  }

  @override
  String get waitButton => 'Aștept';

  @override
  String get notEnoughCoins => 'Nu ai destule monede';

  @override
  String get watchAd10Coins => 'Vezi o reclamă → 10 monede';

  @override
  String get powersTitle => 'PUTERI';

  @override
  String get powerHintName => 'Indiciu';

  @override
  String get powerHintDesc => 'Arată un obiect ascuns';

  @override
  String get powerScanName => 'Scanare';

  @override
  String get powerScanDesc => 'Clipește toate obiectele rămase';

  @override
  String get powerFreezeName => 'Înghețare timp';

  @override
  String get powerFreezeDesc => 'Oprește cronometrul 20 de secunde';

  @override
  String get powerShieldName => 'Scut';

  @override
  String get powerShieldDesc =>
      'Anulează penalizarea la următoarea atingere greșită';

  @override
  String powerOwnedCount(int count) {
    return 'Ai: $count';
  }

  @override
  String powerActivated(String name) {
    return '$name activat!';
  }

  @override
  String powerNoneLeft(String name) {
    return 'Nu mai ai $name. Cumpără din magazin.';
  }

  @override
  String get freezeActiveBadge => '⏸ Timp înghețat';

  @override
  String get scanActiveBadge => '🔎 Scanare';

  @override
  String get shieldActiveBadge => '🛡 Scut activ';

  @override
  String get buyAction => 'Cumpără';

  @override
  String get language => 'Limbă';

  @override
  String get languageSystem => 'Implicit (sistem)';
}
