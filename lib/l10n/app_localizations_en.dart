// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Hidden Objects';

  @override
  String get homeTitle => 'HIDDEN\nOBJECTS';

  @override
  String get homeSubtitle => 'Find the objects in the painted scenes';

  @override
  String get scenesHeader => 'Scenes';

  @override
  String get tooltipAchievements => 'Achievements';

  @override
  String get tooltipEvents => 'Events';

  @override
  String get tooltipShop => 'Shop';

  @override
  String get watchAdForCoins => 'Watch an ad → +50 coins';

  @override
  String get coinsEarned => '🎬 +50 coins!';

  @override
  String get adNotAvailable => 'The ad isn\'t available right now, try again.';

  @override
  String objectsToFind(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count objects to find',
      one: '$count object to find',
    );
    return '$_temp0';
  }

  @override
  String get eventToday => 'TODAY\'S EVENT';

  @override
  String get tooltipHint => 'Hint';

  @override
  String get tooltipSkipLevel => 'Skip level (ad)';

  @override
  String findProgress(int found, int total) {
    return 'FIND  $found/$total';
  }

  @override
  String get levelComplete => '🎉 Level complete!';

  @override
  String allObjectsFoundIn(int total, String time) {
    return 'All $total objects found in $time';
  }

  @override
  String get doubleX2 => 'Double ×2';

  @override
  String get bonusLevels => '+2 levels 🎁';

  @override
  String get back => 'Back';

  @override
  String get skipLevelTitle => 'Skip level';

  @override
  String get skipLevelBody =>
      'Watch a short video to mark the level as solved and return home.';

  @override
  String get cancel => 'Cancel';

  @override
  String get watchVideo => 'Watch video';

  @override
  String rewardDoubled(int coins) {
    return '🎬 Reward doubled! +$coins coins';
  }

  @override
  String get bonusLevelsGranted => '🎁 +2 bonus levels + 400 coins!';

  @override
  String get achievementUnlocked => '🏆 Achievement unlocked';

  @override
  String get shopTitle => 'Shop';

  @override
  String get restore => 'Restore';

  @override
  String get purchaseSuccess => '✅ Purchase successful. Thank you!';

  @override
  String get shopUnavailable =>
      'The shop isn\'t available right now. Try again.';

  @override
  String get restoringPurchases => 'Restoring purchases…';

  @override
  String get yourCoins => 'Your coins';

  @override
  String get adsRemovedTitle => 'Ads removed';

  @override
  String get adsRemovedSubtitle => 'Thanks for your support!';

  @override
  String get removeAdsTitle => 'Remove ads';

  @override
  String get removeAdsSubtitle => 'No banners or interstitial ads';

  @override
  String get coinPacks => 'COIN PACKS';

  @override
  String coinPackBonus(int coins, int bonus) {
    return '$coins + $bonus bonus coins';
  }

  @override
  String coinPackPlain(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins coins',
      one: '$coins coin',
    );
    return '$_temp0';
  }

  @override
  String get bestValue => 'Best value';

  @override
  String get moreHints => 'More hints';

  @override
  String get paymentNotice => 'Payment is charged to your App Store account.';

  @override
  String get achievementsTitle => 'Achievements';

  @override
  String get totalProgress => 'Total progress';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked of $total achievements';
  }

  @override
  String get dailyBonus => 'DAILY BONUS';

  @override
  String dayOfSeven(int day) {
    return 'Day $day / 7';
  }

  @override
  String dayShort(int day) {
    return 'D$day';
  }

  @override
  String doubleX2WithReward(int reward) {
    return 'DOUBLE ×2  (+$reward)';
  }

  @override
  String get claim => 'CLAIM';

  @override
  String bonusDoubled(int reward) {
    return '🎬 Bonus doubled! +$reward coins';
  }

  @override
  String get eventsTitle => 'Events';

  @override
  String get eventOfTheDay => 'EVENT OF THE DAY';

  @override
  String rewardStars(int stars) {
    String _temp0 = intl.Intl.pluralLogic(
      stars,
      locale: localeName,
      other: '$stars reward stars',
      one: '$stars reward star',
    );
    return '$_temp0';
  }

  @override
  String get playNow => 'Play now';

  @override
  String get eventCalendar => 'Event calendar';

  @override
  String get special => 'SPECIAL';

  @override
  String get today => 'Today';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get weekdayMon => 'Mon';

  @override
  String get weekdayTue => 'Tue';

  @override
  String get weekdayWed => 'Wed';

  @override
  String get weekdayThu => 'Thu';

  @override
  String get weekdayFri => 'Fri';

  @override
  String get weekdaySat => 'Sat';

  @override
  String get weekdaySun => 'Sun';

  @override
  String get escapeAdsTitle => 'Escape the ads';

  @override
  String get escapeAdsBody =>
      'Play with no banners and no interrupting ads. Once, forever.';

  @override
  String removeAdsForPrice(String price) {
    return 'Remove ads • $price';
  }

  @override
  String get later => 'Later';

  @override
  String get notificationTitle => 'Hidden Objects';

  @override
  String get notificationBody => 'Find the hidden objects! 🔍';

  @override
  String get achFirstFindTitle => 'First Find';

  @override
  String get achFirstFindDesc => 'Find your first object';

  @override
  String get achGardenMasterTitle => 'Garden Master';

  @override
  String get achGardenMasterDesc => 'Finish the Magic Garden';

  @override
  String get achHalfwayHeroTitle => 'Halfway Hero';

  @override
  String get achHalfwayHeroDesc => 'Finish 4 scenes';

  @override
  String get achMasterDetectiveTitle => 'Master Detective';

  @override
  String get achMasterDetectiveDesc => 'Finish all 8 scenes';

  @override
  String get achHawkEyeTitle => 'Hawk Eye';

  @override
  String get achHawkEyeDesc => 'Find 50 objects in total';

  @override
  String get achEagleEyeTitle => 'Eagle Eye';

  @override
  String get achEagleEyeDesc => 'Find 200 objects in total';

  @override
  String get achNoCheatTitle => 'No Cheat';

  @override
  String get achNoCheatDesc => 'Finish a scene without a hint';

  @override
  String get achSpeedRunnerTitle => 'Speed Runner';

  @override
  String get achSpeedRunnerDesc => 'Finish a scene under 30 seconds';

  @override
  String get evtDailyChallengeName => 'Daily Challenge';

  @override
  String get evtDailyChallengeDesc => 'Find all the objects in a single scene';

  @override
  String get evtHawkEyeName => 'Eagle Eye';

  @override
  String get evtHawkEyeDesc => 'Finish a scene without using a hint';

  @override
  String get evtQuickHuntName => 'Quick Hunt';

  @override
  String get evtQuickHuntDesc => 'Find 5 objects in under 60 seconds';

  @override
  String get evtMarathonName => 'Marathon Detective';

  @override
  String get evtMarathonDesc => 'Play 3 different scenes today';

  @override
  String get evtCollectorName => 'The Collector';

  @override
  String get evtCollectorDesc => 'Collect 25 objects today';

  @override
  String get evtTreasureHuntName => 'Treasure Hunt';

  @override
  String get evtTreasureHuntDesc => 'Finish 5 scenes in a row with all objects';

  @override
  String get evtHintMasterName => 'Hint Master';

  @override
  String get evtHintMasterDesc => 'Find 50 objects over the weekend';
}
