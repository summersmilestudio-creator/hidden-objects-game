// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Versteckte Objekte';

  @override
  String get homeTitle => 'VERSTECKTE\nOBJEKTE';

  @override
  String get homeSubtitle => 'Finde die Objekte in den gemalten Szenen';

  @override
  String get scenesHeader => 'Szenen';

  @override
  String get tooltipAchievements => 'Erfolge';

  @override
  String get tooltipEvents => 'Ereignisse';

  @override
  String get tooltipShop => 'Shop';

  @override
  String get watchAdForCoins => 'Werbung ansehen → +50 Münzen';

  @override
  String get coinsEarned => '🎬 +50 Münzen!';

  @override
  String get adNotAvailable =>
      'Die Werbung ist gerade nicht verfügbar, versuche es erneut.';

  @override
  String objectsToFind(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Objekte zu finden',
      one: '$count Objekt zu finden',
    );
    return '$_temp0';
  }

  @override
  String get eventToday => 'HEUTIGES EREIGNIS';

  @override
  String get tooltipHint => 'Tipp';

  @override
  String get tooltipSkipLevel => 'Level überspringen (Werbung)';

  @override
  String findProgress(int found, int total) {
    return 'FINDE  $found/$total';
  }

  @override
  String get levelComplete => '🎉 Level geschafft!';

  @override
  String allObjectsFoundIn(int total, String time) {
    return 'Alle $total Objekte in $time gefunden';
  }

  @override
  String get doubleX2 => 'Verdoppeln ×2';

  @override
  String get bonusLevels => '+2 Level 🎁';

  @override
  String get back => 'Zurück';

  @override
  String get skipLevelTitle => 'Level überspringen';

  @override
  String get skipLevelBody =>
      'Sieh dir ein kurzes Video an, um das Level als gelöst zu markieren und nach Hause zurückzukehren.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get watchVideo => 'Video ansehen';

  @override
  String rewardDoubled(int coins) {
    return '🎬 Belohnung verdoppelt! +$coins Münzen';
  }

  @override
  String get bonusLevelsGranted => '🎁 +2 Bonuslevel + 400 Münzen!';

  @override
  String get achievementUnlocked => '🏆 Erfolg freigeschaltet';

  @override
  String get shopTitle => 'Shop';

  @override
  String get restore => 'Wiederherstellen';

  @override
  String get purchaseSuccess => '✅ Kauf erfolgreich. Danke!';

  @override
  String get shopUnavailable =>
      'Der Shop ist gerade nicht verfügbar. Versuche es erneut.';

  @override
  String get restoringPurchases => 'Käufe werden wiederhergestellt…';

  @override
  String get yourCoins => 'Deine Münzen';

  @override
  String get adsRemovedTitle => 'Werbung entfernt';

  @override
  String get adsRemovedSubtitle => 'Danke für deine Unterstützung!';

  @override
  String get removeAdsTitle => 'Werbung entfernen';

  @override
  String get removeAdsSubtitle => 'Keine Banner und keine Interstitial-Werbung';

  @override
  String get coinPacks => 'MÜNZPAKETE';

  @override
  String coinPackBonus(int coins, int bonus) {
    return '$coins + $bonus Bonusmünzen';
  }

  @override
  String coinPackPlain(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins Münzen',
      one: '$coins Münze',
    );
    return '$_temp0';
  }

  @override
  String get bestValue => 'Bestes Angebot';

  @override
  String get moreHints => 'Mehr Tipps';

  @override
  String get paymentNotice => 'Die Zahlung erfolgt über dein App-Store-Konto.';

  @override
  String get achievementsTitle => 'Erfolge';

  @override
  String get totalProgress => 'Gesamtfortschritt';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked von $total Erfolgen';
  }

  @override
  String get dailyBonus => 'TÄGLICHER BONUS';

  @override
  String dayOfSeven(int day) {
    return 'Tag $day / 7';
  }

  @override
  String dayShort(int day) {
    return 'T$day';
  }

  @override
  String doubleX2WithReward(int reward) {
    return 'VERDOPPELN ×2  (+$reward)';
  }

  @override
  String get claim => 'ABHOLEN';

  @override
  String bonusDoubled(int reward) {
    return '🎬 Bonus verdoppelt! +$reward Münzen';
  }

  @override
  String get eventsTitle => 'Ereignisse';

  @override
  String get eventOfTheDay => 'EREIGNIS DES TAGES';

  @override
  String rewardStars(int stars) {
    String _temp0 = intl.Intl.pluralLogic(
      stars,
      locale: localeName,
      other: '$stars Belohnungssterne',
      one: '$stars Belohnungsstern',
    );
    return '$_temp0';
  }

  @override
  String get playNow => 'Jetzt spielen';

  @override
  String get eventCalendar => 'Ereigniskalender';

  @override
  String get special => 'SPEZIAL';

  @override
  String get today => 'Heute';

  @override
  String get tomorrow => 'Morgen';

  @override
  String get weekdayMon => 'Mo';

  @override
  String get weekdayTue => 'Di';

  @override
  String get weekdayWed => 'Mi';

  @override
  String get weekdayThu => 'Do';

  @override
  String get weekdayFri => 'Fr';

  @override
  String get weekdaySat => 'Sa';

  @override
  String get weekdaySun => 'So';

  @override
  String get escapeAdsTitle => 'Schluss mit Werbung';

  @override
  String get escapeAdsBody =>
      'Spiele ohne Banner und ohne störende Werbung. Einmal, für immer.';

  @override
  String removeAdsForPrice(String price) {
    return 'Werbung entfernen • $price';
  }

  @override
  String get later => 'Später';

  @override
  String get notificationTitle => 'Versteckte Objekte';

  @override
  String get notificationBody => 'Finde die versteckten Objekte! 🔍';

  @override
  String get achFirstFindTitle => 'Erster Fund';

  @override
  String get achFirstFindDesc => 'Finde dein erstes Objekt';

  @override
  String get achGardenMasterTitle => 'Gartenmeister';

  @override
  String get achGardenMasterDesc => 'Schließe den Zaubergarten ab';

  @override
  String get achHalfwayHeroTitle => 'Halbzeitheld';

  @override
  String get achHalfwayHeroDesc => 'Schließe 4 Szenen ab';

  @override
  String get achMasterDetectiveTitle => 'Meisterdetektiv';

  @override
  String get achMasterDetectiveDesc => 'Schließe alle 8 Szenen ab';

  @override
  String get achHawkEyeTitle => 'Falkenauge';

  @override
  String get achHawkEyeDesc => 'Finde insgesamt 50 Objekte';

  @override
  String get achEagleEyeTitle => 'Adlerauge';

  @override
  String get achEagleEyeDesc => 'Finde insgesamt 200 Objekte';

  @override
  String get achNoCheatTitle => 'Kein Schummeln';

  @override
  String get achNoCheatDesc => 'Schließe eine Szene ohne Tipp ab';

  @override
  String get achSpeedRunnerTitle => 'Schnellläufer';

  @override
  String get achSpeedRunnerDesc =>
      'Schließe eine Szene in unter 30 Sekunden ab';

  @override
  String get evtDailyChallengeName => 'Tägliche Herausforderung';

  @override
  String get evtDailyChallengeDesc =>
      'Finde alle Objekte in einer einzigen Szene';

  @override
  String get evtHawkEyeName => 'Adlerauge';

  @override
  String get evtHawkEyeDesc => 'Schließe eine Szene ohne Tipp ab';

  @override
  String get evtQuickHuntName => 'Schnelle Jagd';

  @override
  String get evtQuickHuntDesc => 'Finde 5 Objekte in unter 60 Sekunden';

  @override
  String get evtMarathonName => 'Marathon-Detektiv';

  @override
  String get evtMarathonDesc => 'Spiele heute 3 verschiedene Szenen';

  @override
  String get evtCollectorName => 'Der Sammler';

  @override
  String get evtCollectorDesc => 'Sammle heute 25 Objekte';

  @override
  String get evtTreasureHuntName => 'Schatzsuche';

  @override
  String get evtTreasureHuntDesc =>
      'Schließe 5 Szenen in Folge mit allen Objekten ab';

  @override
  String get evtHintMasterName => 'Tipp-Meister';

  @override
  String get evtHintMasterDesc => 'Finde 50 Objekte am Wochenende';

  @override
  String get livesFull => 'Leben voll';

  @override
  String nextLifeIn(String time) {
    return 'Nächstes Leben in $time';
  }

  @override
  String get outOfLivesTitle => 'Keine Leben mehr';

  @override
  String get outOfLivesBody =>
      'Warte auf das Auffüllen, sieh dir eine Anzeige an oder nutze Münzen.';

  @override
  String get getLifeAd => '+1 Leben (Anzeige)';

  @override
  String getLifeCoins(int coins) {
    return '+1 Leben ($coins 🪙)';
  }

  @override
  String get waitButton => 'Warten';

  @override
  String get notEnoughCoins => 'Nicht genug Münzen';

  @override
  String get watchAd10Coins => 'Anzeige ansehen → 10 Münzen';

  @override
  String get powersTitle => 'KRÄFTE';

  @override
  String get powerHintName => 'Hinweis';

  @override
  String get powerHintDesc => 'Zeigt ein verstecktes Objekt';

  @override
  String get powerScanName => 'Scan';

  @override
  String get powerScanDesc => 'Lässt alle verbleibenden Objekte aufblinken';

  @override
  String get powerFreezeName => 'Zeit einfrieren';

  @override
  String get powerFreezeDesc => 'Stoppt den Timer für 20 Sekunden';

  @override
  String get powerShieldName => 'Schild';

  @override
  String get powerShieldDesc => 'Hebt die Strafe beim nächsten Fehltipp auf';

  @override
  String powerOwnedCount(int count) {
    return 'Du hast: $count';
  }

  @override
  String powerActivated(String name) {
    return '$name aktiviert!';
  }

  @override
  String powerNoneLeft(String name) {
    return 'Kein $name mehr. Kaufe mehr im Shop.';
  }

  @override
  String get freezeActiveBadge => '⏸ Zeit eingefroren';

  @override
  String get scanActiveBadge => '🔎 Scan läuft';

  @override
  String get shieldActiveBadge => '🛡 Schild aktiv';

  @override
  String get buyAction => 'Kaufen';

  @override
  String get language => 'Sprache';

  @override
  String get languageSystem => 'Systemstandard';
}
