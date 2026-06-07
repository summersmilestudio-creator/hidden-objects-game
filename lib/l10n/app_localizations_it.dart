// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Oggetti Nascosti';

  @override
  String get homeTitle => 'OGGETTI\nNASCOSTI';

  @override
  String get homeSubtitle => 'Trova gli oggetti nelle scene dipinte';

  @override
  String get scenesHeader => 'Scene';

  @override
  String get tooltipAchievements => 'Obiettivi';

  @override
  String get tooltipEvents => 'Eventi';

  @override
  String get tooltipShop => 'Negozio';

  @override
  String get watchAdForCoins => 'Guarda una pubblicità → +50 monete';

  @override
  String get coinsEarned => '🎬 +50 monete!';

  @override
  String get adNotAvailable => 'La pubblicità non è disponibile ora, riprova.';

  @override
  String objectsToFind(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count oggetti da trovare',
      one: '$count oggetto da trovare',
    );
    return '$_temp0';
  }

  @override
  String get eventToday => 'EVENTO DI OGGI';

  @override
  String get tooltipHint => 'Indizio';

  @override
  String get tooltipSkipLevel => 'Salta livello (pubblicità)';

  @override
  String findProgress(int found, int total) {
    return 'TROVA  $found/$total';
  }

  @override
  String get levelComplete => '🎉 Livello completato!';

  @override
  String allObjectsFoundIn(int total, String time) {
    return 'Tutti i $total oggetti trovati in $time';
  }

  @override
  String get doubleX2 => 'Raddoppia ×2';

  @override
  String get bonusLevels => '+2 livelli 🎁';

  @override
  String get back => 'Indietro';

  @override
  String get skipLevelTitle => 'Salta livello';

  @override
  String get skipLevelBody =>
      'Guarda un breve video per segnare il livello come risolto e tornare alla schermata iniziale.';

  @override
  String get cancel => 'Annulla';

  @override
  String get watchVideo => 'Guarda il video';

  @override
  String rewardDoubled(int coins) {
    return '🎬 Ricompensa raddoppiata! +$coins monete';
  }

  @override
  String get bonusLevelsGranted => '🎁 +2 livelli bonus + 400 monete!';

  @override
  String get achievementUnlocked => '🏆 Obiettivo sbloccato';

  @override
  String get shopTitle => 'Negozio';

  @override
  String get restore => 'Ripristina';

  @override
  String get purchaseSuccess => '✅ Acquisto riuscito. Grazie!';

  @override
  String get shopUnavailable => 'Il negozio non è disponibile ora. Riprova.';

  @override
  String get restoringPurchases => 'Ripristino degli acquisti…';

  @override
  String get yourCoins => 'Le tue monete';

  @override
  String get adsRemovedTitle => 'Pubblicità rimossa';

  @override
  String get adsRemovedSubtitle => 'Grazie per il supporto!';

  @override
  String get removeAdsTitle => 'Rimuovi pubblicità';

  @override
  String get removeAdsSubtitle => 'Niente banner né pubblicità interstiziali';

  @override
  String get coinPacks => 'PACCHETTI DI MONETE';

  @override
  String coinPackBonus(int coins, int bonus) {
    return '$coins + $bonus monete bonus';
  }

  @override
  String coinPackPlain(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins monete',
      one: '$coins moneta',
    );
    return '$_temp0';
  }

  @override
  String get bestValue => 'Miglior offerta';

  @override
  String get moreHints => 'Più indizi';

  @override
  String get paymentNotice =>
      'Il pagamento viene addebitato sul tuo account App Store.';

  @override
  String get achievementsTitle => 'Obiettivi';

  @override
  String get totalProgress => 'Progresso totale';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked di $total obiettivi';
  }

  @override
  String get dailyBonus => 'BONUS GIORNALIERO';

  @override
  String dayOfSeven(int day) {
    return 'Giorno $day / 7';
  }

  @override
  String dayShort(int day) {
    return 'G$day';
  }

  @override
  String doubleX2WithReward(int reward) {
    return 'RADDOPPIA ×2  (+$reward)';
  }

  @override
  String get claim => 'RISCUOTI';

  @override
  String bonusDoubled(int reward) {
    return '🎬 Bonus raddoppiato! +$reward monete';
  }

  @override
  String get eventsTitle => 'Eventi';

  @override
  String get eventOfTheDay => 'EVENTO DEL GIORNO';

  @override
  String rewardStars(int stars) {
    String _temp0 = intl.Intl.pluralLogic(
      stars,
      locale: localeName,
      other: '$stars stelle di ricompensa',
      one: '$stars stella di ricompensa',
    );
    return '$_temp0';
  }

  @override
  String get playNow => 'Gioca ora';

  @override
  String get eventCalendar => 'Calendario eventi';

  @override
  String get special => 'SPECIALE';

  @override
  String get today => 'Oggi';

  @override
  String get tomorrow => 'Domani';

  @override
  String get weekdayMon => 'Lun';

  @override
  String get weekdayTue => 'Mar';

  @override
  String get weekdayWed => 'Mer';

  @override
  String get weekdayThu => 'Gio';

  @override
  String get weekdayFri => 'Ven';

  @override
  String get weekdaySat => 'Sab';

  @override
  String get weekdaySun => 'Dom';

  @override
  String get escapeAdsTitle => 'Addio pubblicità';

  @override
  String get escapeAdsBody =>
      'Gioca senza banner e senza pubblicità che ti interrompono. Una volta sola, per sempre.';

  @override
  String removeAdsForPrice(String price) {
    return 'Rimuovi pubblicità • $price';
  }

  @override
  String get later => 'Più tardi';

  @override
  String get notificationTitle => 'Oggetti Nascosti';

  @override
  String get notificationBody => 'Trova gli oggetti nascosti! 🔍';

  @override
  String get achFirstFindTitle => 'Prima Scoperta';

  @override
  String get achFirstFindDesc => 'Trova il tuo primo oggetto';

  @override
  String get achGardenMasterTitle => 'Maestro del Giardino';

  @override
  String get achGardenMasterDesc => 'Completa il Giardino Magico';

  @override
  String get achHalfwayHeroTitle => 'Eroe a Metà';

  @override
  String get achHalfwayHeroDesc => 'Completa 4 scene';

  @override
  String get achMasterDetectiveTitle => 'Detective Maestro';

  @override
  String get achMasterDetectiveDesc => 'Completa tutte le 8 scene';

  @override
  String get achHawkEyeTitle => 'Occhio di Falco';

  @override
  String get achHawkEyeDesc => 'Trova 50 oggetti in totale';

  @override
  String get achEagleEyeTitle => 'Occhio d\'Aquila';

  @override
  String get achEagleEyeDesc => 'Trova 200 oggetti in totale';

  @override
  String get achNoCheatTitle => 'Niente Trucchi';

  @override
  String get achNoCheatDesc => 'Completa una scena senza indizio';

  @override
  String get achSpeedRunnerTitle => 'Velocista';

  @override
  String get achSpeedRunnerDesc => 'Completa una scena in meno di 30 secondi';

  @override
  String get evtDailyChallengeName => 'Sfida del Giorno';

  @override
  String get evtDailyChallengeDesc =>
      'Trova tutti gli oggetti in una singola scena';

  @override
  String get evtHawkEyeName => 'Occhio d\'Aquila';

  @override
  String get evtHawkEyeDesc => 'Completa una scena senza usare indizi';

  @override
  String get evtQuickHuntName => 'Caccia Veloce';

  @override
  String get evtQuickHuntDesc => 'Trova 5 oggetti in meno di 60 secondi';

  @override
  String get evtMarathonName => 'Detective Maratona';

  @override
  String get evtMarathonDesc => 'Gioca 3 scene diverse oggi';

  @override
  String get evtCollectorName => 'Il Collezionista';

  @override
  String get evtCollectorDesc => 'Raccogli 25 oggetti oggi';

  @override
  String get evtTreasureHuntName => 'Caccia al Tesoro';

  @override
  String get evtTreasureHuntDesc =>
      'Completa 5 scene di fila con tutti gli oggetti';

  @override
  String get evtHintMasterName => 'Maestro degli Indizi';

  @override
  String get evtHintMasterDesc => 'Trova 50 oggetti nel fine settimana';

  @override
  String get livesFull => 'Vite al massimo';

  @override
  String nextLifeIn(String time) {
    return 'Prossima vita tra $time';
  }

  @override
  String get outOfLivesTitle => 'Vite esaurite';

  @override
  String get outOfLivesBody =>
      'Aspetta che si ricarichino, guarda un annuncio o usa le monete.';

  @override
  String get getLifeAd => '+1 vita (annuncio)';

  @override
  String getLifeCoins(int coins) {
    return '+1 vita ($coins 🪙)';
  }

  @override
  String get waitButton => 'Aspetta';

  @override
  String get notEnoughCoins => 'Monete insufficienti';

  @override
  String get watchAd10Coins => 'Guarda un annuncio → 10 monete';

  @override
  String get powersTitle => 'POTERI';

  @override
  String get powerHintName => 'Indizio';

  @override
  String get powerHintDesc => 'Rivela un oggetto nascosto';

  @override
  String get powerScanName => 'Scansione';

  @override
  String get powerScanDesc => 'Fa lampeggiare tutti gli oggetti rimasti';

  @override
  String get powerFreezeName => 'Congela tempo';

  @override
  String get powerFreezeDesc => 'Ferma il cronometro per 20 secondi';

  @override
  String get powerShieldName => 'Scudo';

  @override
  String get powerShieldDesc =>
      'Annulla la penalità al prossimo tocco sbagliato';

  @override
  String powerOwnedCount(int count) {
    return 'Ne hai: $count';
  }

  @override
  String powerActivated(String name) {
    return '$name attivato!';
  }

  @override
  String powerNoneLeft(String name) {
    return '$name esaurito. Comprane altri nel negozio.';
  }

  @override
  String get freezeActiveBadge => '⏸ Tempo congelato';

  @override
  String get scanActiveBadge => '🔎 Scansione';

  @override
  String get shieldActiveBadge => '🛡 Scudo attivo';

  @override
  String get buyAction => 'Acquista';

  @override
  String get language => 'Lingua';

  @override
  String get languageSystem => 'Predefinito di sistema';
}
