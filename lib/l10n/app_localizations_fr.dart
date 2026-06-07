// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Objets Cachés';

  @override
  String get homeTitle => 'OBJETS\nCACHÉS';

  @override
  String get homeSubtitle => 'Trouvez les objets dans les scènes peintes';

  @override
  String get scenesHeader => 'Scènes';

  @override
  String get tooltipAchievements => 'Succès';

  @override
  String get tooltipEvents => 'Événements';

  @override
  String get tooltipShop => 'Boutique';

  @override
  String get watchAdForCoins => 'Regardez une pub → +50 pièces';

  @override
  String get coinsEarned => '🎬 +50 pièces !';

  @override
  String get adNotAvailable =>
      'La pub n\'est pas disponible pour l\'instant, réessayez.';

  @override
  String objectsToFind(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count objets à trouver',
      one: '$count objet à trouver',
    );
    return '$_temp0';
  }

  @override
  String get eventToday => 'ÉVÉNEMENT DU JOUR';

  @override
  String get tooltipHint => 'Indice';

  @override
  String get tooltipSkipLevel => 'Passer le niveau (pub)';

  @override
  String findProgress(int found, int total) {
    return 'TROUVEZ  $found/$total';
  }

  @override
  String get levelComplete => '🎉 Niveau terminé !';

  @override
  String allObjectsFoundIn(int total, String time) {
    return 'Les $total objets trouvés en $time';
  }

  @override
  String get doubleX2 => 'Doubler ×2';

  @override
  String get bonusLevels => '+2 niveaux 🎁';

  @override
  String get back => 'Retour';

  @override
  String get skipLevelTitle => 'Passer le niveau';

  @override
  String get skipLevelBody =>
      'Regardez une courte vidéo pour marquer le niveau comme résolu et revenir à l\'accueil.';

  @override
  String get cancel => 'Annuler';

  @override
  String get watchVideo => 'Voir la vidéo';

  @override
  String rewardDoubled(int coins) {
    return '🎬 Récompense doublée ! +$coins pièces';
  }

  @override
  String get bonusLevelsGranted => '🎁 +2 niveaux bonus + 400 pièces !';

  @override
  String get achievementUnlocked => '🏆 Succès débloqué';

  @override
  String get shopTitle => 'Boutique';

  @override
  String get restore => 'Restaurer';

  @override
  String get purchaseSuccess => '✅ Achat réussi. Merci !';

  @override
  String get shopUnavailable =>
      'La boutique n\'est pas disponible pour l\'instant. Réessayez.';

  @override
  String get restoringPurchases => 'Restauration des achats…';

  @override
  String get yourCoins => 'Vos pièces';

  @override
  String get adsRemovedTitle => 'Pubs supprimées';

  @override
  String get adsRemovedSubtitle => 'Merci de votre soutien !';

  @override
  String get removeAdsTitle => 'Supprimer les pubs';

  @override
  String get removeAdsSubtitle => 'Sans bannières ni pubs interstitielles';

  @override
  String get coinPacks => 'PACKS DE PIÈCES';

  @override
  String coinPackBonus(int coins, int bonus) {
    return '$coins + $bonus pièces bonus';
  }

  @override
  String coinPackPlain(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins pièces',
      one: '$coins pièce',
    );
    return '$_temp0';
  }

  @override
  String get bestValue => 'Meilleure offre';

  @override
  String get moreHints => 'Plus d\'indices';

  @override
  String get paymentNotice =>
      'Le paiement est débité sur votre compte App Store.';

  @override
  String get achievementsTitle => 'Succès';

  @override
  String get totalProgress => 'Progression totale';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked sur $total succès';
  }

  @override
  String get dailyBonus => 'BONUS QUOTIDIEN';

  @override
  String dayOfSeven(int day) {
    return 'Jour $day / 7';
  }

  @override
  String dayShort(int day) {
    return 'J$day';
  }

  @override
  String doubleX2WithReward(int reward) {
    return 'DOUBLER ×2  (+$reward)';
  }

  @override
  String get claim => 'RÉCUPÉRER';

  @override
  String bonusDoubled(int reward) {
    return '🎬 Bonus doublé ! +$reward pièces';
  }

  @override
  String get eventsTitle => 'Événements';

  @override
  String get eventOfTheDay => 'ÉVÉNEMENT DU JOUR';

  @override
  String rewardStars(int stars) {
    String _temp0 = intl.Intl.pluralLogic(
      stars,
      locale: localeName,
      other: '$stars étoiles de récompense',
      one: '$stars étoile de récompense',
    );
    return '$_temp0';
  }

  @override
  String get playNow => 'Jouer maintenant';

  @override
  String get eventCalendar => 'Calendrier des événements';

  @override
  String get special => 'SPÉCIAL';

  @override
  String get today => 'Auj.';

  @override
  String get tomorrow => 'Demain';

  @override
  String get weekdayMon => 'Lun';

  @override
  String get weekdayTue => 'Mar';

  @override
  String get weekdayWed => 'Mer';

  @override
  String get weekdayThu => 'Jeu';

  @override
  String get weekdayFri => 'Ven';

  @override
  String get weekdaySat => 'Sam';

  @override
  String get weekdaySun => 'Dim';

  @override
  String get escapeAdsTitle => 'Fini les pubs';

  @override
  String get escapeAdsBody =>
      'Jouez sans bannières ni pubs qui vous interrompent. Une seule fois, pour toujours.';

  @override
  String removeAdsForPrice(String price) {
    return 'Supprimer les pubs • $price';
  }

  @override
  String get later => 'Plus tard';

  @override
  String get notificationTitle => 'Objets Cachés';

  @override
  String get notificationBody => 'Trouvez les objets cachés ! 🔍';

  @override
  String get achFirstFindTitle => 'Première Trouvaille';

  @override
  String get achFirstFindDesc => 'Trouvez votre premier objet';

  @override
  String get achGardenMasterTitle => 'Maître du Jardin';

  @override
  String get achGardenMasterDesc => 'Terminez le Jardin Magique';

  @override
  String get achHalfwayHeroTitle => 'Héros à Mi-chemin';

  @override
  String get achHalfwayHeroDesc => 'Terminez 4 scènes';

  @override
  String get achMasterDetectiveTitle => 'Détective Émérite';

  @override
  String get achMasterDetectiveDesc => 'Terminez les 8 scènes';

  @override
  String get achHawkEyeTitle => 'Œil de Faucon';

  @override
  String get achHawkEyeDesc => 'Trouvez 50 objets au total';

  @override
  String get achEagleEyeTitle => 'Œil d\'Aigle';

  @override
  String get achEagleEyeDesc => 'Trouvez 200 objets au total';

  @override
  String get achNoCheatTitle => 'Sans Triche';

  @override
  String get achNoCheatDesc => 'Terminez une scène sans indice';

  @override
  String get achSpeedRunnerTitle => 'Sprinteur';

  @override
  String get achSpeedRunnerDesc => 'Terminez une scène en moins de 30 secondes';

  @override
  String get evtDailyChallengeName => 'Défi du Jour';

  @override
  String get evtDailyChallengeDesc =>
      'Trouvez tous les objets dans une seule scène';

  @override
  String get evtHawkEyeName => 'Œil d\'Aigle';

  @override
  String get evtHawkEyeDesc => 'Terminez une scène sans utiliser d\'indice';

  @override
  String get evtQuickHuntName => 'Chasse Rapide';

  @override
  String get evtQuickHuntDesc => 'Trouvez 5 objets en moins de 60 secondes';

  @override
  String get evtMarathonName => 'Détective Marathon';

  @override
  String get evtMarathonDesc => 'Jouez 3 scènes différentes aujourd\'hui';

  @override
  String get evtCollectorName => 'Le Collectionneur';

  @override
  String get evtCollectorDesc => 'Rassemblez 25 objets aujourd\'hui';

  @override
  String get evtTreasureHuntName => 'Chasse au Trésor';

  @override
  String get evtTreasureHuntDesc =>
      'Terminez 5 scènes d\'affilée avec tous les objets';

  @override
  String get evtHintMasterName => 'Maître des Indices';

  @override
  String get evtHintMasterDesc => 'Trouvez 50 objets pendant le week-end';

  @override
  String get livesFull => 'Vies au max';

  @override
  String nextLifeIn(String time) {
    return 'Prochaine vie dans $time';
  }

  @override
  String get outOfLivesTitle => 'Plus de vies';

  @override
  String get outOfLivesBody =>
      'Attends qu\'elles se rechargent, regarde une pub ou utilise des pièces.';

  @override
  String get getLifeAd => '+1 vie (pub)';

  @override
  String getLifeCoins(int coins) {
    return '+1 vie ($coins 🪙)';
  }

  @override
  String get waitButton => 'Attendre';

  @override
  String get notEnoughCoins => 'Pas assez de pièces';

  @override
  String get watchAd10Coins => 'Regarde une pub → 10 pièces';

  @override
  String get powersTitle => 'POUVOIRS';

  @override
  String get powerHintName => 'Indice';

  @override
  String get powerHintDesc => 'Révèle un objet caché';

  @override
  String get powerScanName => 'Scan';

  @override
  String get powerScanDesc => 'Fait clignoter tous les objets restants';

  @override
  String get powerFreezeName => 'Gel du temps';

  @override
  String get powerFreezeDesc => 'Arrête le chrono pendant 20 secondes';

  @override
  String get powerShieldName => 'Bouclier';

  @override
  String get powerShieldDesc =>
      'Annule la pénalité au prochain mauvais toucher';

  @override
  String powerOwnedCount(int count) {
    return 'Tu as : $count';
  }

  @override
  String powerActivated(String name) {
    return '$name activé !';
  }

  @override
  String powerNoneLeft(String name) {
    return 'Plus de $name. Achètes-en dans la boutique.';
  }

  @override
  String get freezeActiveBadge => '⏸ Temps gelé';

  @override
  String get scanActiveBadge => '🔎 Scan';

  @override
  String get shieldActiveBadge => '🛡 Bouclier actif';

  @override
  String get buyAction => 'Acheter';
}
