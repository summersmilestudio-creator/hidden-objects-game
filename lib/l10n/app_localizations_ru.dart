// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Поиск предметов';

  @override
  String get homeTitle => 'ПОИСК\nПРЕДМЕТОВ';

  @override
  String get homeSubtitle => 'Найдите предметы на нарисованных сценах';

  @override
  String get scenesHeader => 'Сцены';

  @override
  String get tooltipAchievements => 'Достижения';

  @override
  String get tooltipEvents => 'События';

  @override
  String get tooltipShop => 'Магазин';

  @override
  String get watchAdForCoins => 'Смотреть рекламу → +50 монет';

  @override
  String get coinsEarned => '🎬 +50 монет!';

  @override
  String get adNotAvailable => 'Реклама сейчас недоступна, попробуйте ещё раз.';

  @override
  String objectsToFind(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count предмета для поиска',
      many: '$count предметов для поиска',
      few: '$count предмета для поиска',
      one: '$count предмет для поиска',
    );
    return '$_temp0';
  }

  @override
  String get eventToday => 'СОБЫТИЕ ДНЯ';

  @override
  String get tooltipHint => 'Подсказка';

  @override
  String get tooltipSkipLevel => 'Пропустить уровень (реклама)';

  @override
  String findProgress(int found, int total) {
    return 'НАЙДИТЕ  $found/$total';
  }

  @override
  String get levelComplete => '🎉 Уровень пройден!';

  @override
  String allObjectsFoundIn(int total, String time) {
    return 'Все $total предметов найдены за $time';
  }

  @override
  String get doubleX2 => 'Удвоить ×2';

  @override
  String get bonusLevels => '+2 уровня 🎁';

  @override
  String get back => 'Назад';

  @override
  String get skipLevelTitle => 'Пропустить уровень';

  @override
  String get skipLevelBody =>
      'Посмотрите короткое видео, чтобы отметить уровень как пройденный и вернуться на главную.';

  @override
  String get cancel => 'Отмена';

  @override
  String get watchVideo => 'Смотреть видео';

  @override
  String rewardDoubled(int coins) {
    return '🎬 Награда удвоена! +$coins монет';
  }

  @override
  String get bonusLevelsGranted => '🎁 +2 бонусных уровня + 400 монет!';

  @override
  String get achievementUnlocked => '🏆 Достижение получено';

  @override
  String get shopTitle => 'Магазин';

  @override
  String get restore => 'Восстановить';

  @override
  String get purchaseSuccess => '✅ Покупка выполнена. Спасибо!';

  @override
  String get shopUnavailable =>
      'Магазин сейчас недоступен. Попробуйте ещё раз.';

  @override
  String get restoringPurchases => 'Восстановление покупок…';

  @override
  String get yourCoins => 'Ваши монеты';

  @override
  String get adsRemovedTitle => 'Реклама убрана';

  @override
  String get adsRemovedSubtitle => 'Спасибо за поддержку!';

  @override
  String get removeAdsTitle => 'Убрать рекламу';

  @override
  String get removeAdsSubtitle => 'Без баннеров и межстраничной рекламы';

  @override
  String get coinPacks => 'НАБОРЫ МОНЕТ';

  @override
  String coinPackBonus(int coins, int bonus) {
    return '$coins + $bonus бонусных монет';
  }

  @override
  String coinPackPlain(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins монет',
      many: '$coins монет',
      few: '$coins монеты',
      one: '$coins монета',
    );
    return '$_temp0';
  }

  @override
  String get bestValue => 'Лучшая цена';

  @override
  String get moreHints => 'Больше подсказок';

  @override
  String get paymentNotice => 'Оплата списывается с вашего аккаунта App Store.';

  @override
  String get achievementsTitle => 'Достижения';

  @override
  String get totalProgress => 'Общий прогресс';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked из $total достижений';
  }

  @override
  String get dailyBonus => 'ЕЖЕДНЕВНЫЙ БОНУС';

  @override
  String dayOfSeven(int day) {
    return 'День $day / 7';
  }

  @override
  String dayShort(int day) {
    return 'Д$day';
  }

  @override
  String doubleX2WithReward(int reward) {
    return 'УДВОИТЬ ×2  (+$reward)';
  }

  @override
  String get claim => 'ЗАБРАТЬ';

  @override
  String bonusDoubled(int reward) {
    return '🎬 Бонус удвоен! +$reward монет';
  }

  @override
  String get eventsTitle => 'События';

  @override
  String get eventOfTheDay => 'СОБЫТИЕ ДНЯ';

  @override
  String rewardStars(int stars) {
    String _temp0 = intl.Intl.pluralLogic(
      stars,
      locale: localeName,
      other: '$stars звёзд награды',
      many: '$stars звёзд награды',
      few: '$stars звезды награды',
      one: '$stars звезда награды',
    );
    return '$_temp0';
  }

  @override
  String get playNow => 'Играть';

  @override
  String get eventCalendar => 'Календарь событий';

  @override
  String get special => 'ОСОБОЕ';

  @override
  String get today => 'Сегодня';

  @override
  String get tomorrow => 'Завтра';

  @override
  String get weekdayMon => 'Пн';

  @override
  String get weekdayTue => 'Вт';

  @override
  String get weekdayWed => 'Ср';

  @override
  String get weekdayThu => 'Чт';

  @override
  String get weekdayFri => 'Пт';

  @override
  String get weekdaySat => 'Сб';

  @override
  String get weekdaySun => 'Вс';

  @override
  String get escapeAdsTitle => 'Избавьтесь от рекламы';

  @override
  String get escapeAdsBody =>
      'Играйте без баннеров и без рекламы, которая прерывает. Один раз и навсегда.';

  @override
  String removeAdsForPrice(String price) {
    return 'Убрать рекламу • $price';
  }

  @override
  String get later => 'Позже';

  @override
  String get notificationTitle => 'Поиск предметов';

  @override
  String get notificationBody => 'Найдите спрятанные предметы! 🔍';

  @override
  String get achFirstFindTitle => 'Первая находка';

  @override
  String get achFirstFindDesc => 'Найдите первый предмет';

  @override
  String get achGardenMasterTitle => 'Мастер сада';

  @override
  String get achGardenMasterDesc => 'Пройдите Волшебный сад';

  @override
  String get achHalfwayHeroTitle => 'Полпути пройдено';

  @override
  String get achHalfwayHeroDesc => 'Пройдите 4 сцены';

  @override
  String get achMasterDetectiveTitle => 'Мастер-детектив';

  @override
  String get achMasterDetectiveDesc => 'Пройдите все 8 сцен';

  @override
  String get achHawkEyeTitle => 'Соколиный глаз';

  @override
  String get achHawkEyeDesc => 'Найдите 50 предметов всего';

  @override
  String get achEagleEyeTitle => 'Орлиный глаз';

  @override
  String get achEagleEyeDesc => 'Найдите 200 предметов всего';

  @override
  String get achNoCheatTitle => 'Без подсказок';

  @override
  String get achNoCheatDesc => 'Пройдите сцену без подсказки';

  @override
  String get achSpeedRunnerTitle => 'Скоростной бег';

  @override
  String get achSpeedRunnerDesc => 'Пройдите сцену быстрее 30 секунд';

  @override
  String get evtDailyChallengeName => 'Испытание дня';

  @override
  String get evtDailyChallengeDesc => 'Найдите все предметы на одной сцене';

  @override
  String get evtHawkEyeName => 'Орлиный глаз';

  @override
  String get evtHawkEyeDesc => 'Пройдите сцену без подсказки';

  @override
  String get evtQuickHuntName => 'Быстрая охота';

  @override
  String get evtQuickHuntDesc => 'Найдите 5 предметов менее чем за 60 секунд';

  @override
  String get evtMarathonName => 'Детектив-марафонец';

  @override
  String get evtMarathonDesc => 'Сыграйте 3 разные сцены сегодня';

  @override
  String get evtCollectorName => 'Коллекционер';

  @override
  String get evtCollectorDesc => 'Соберите 25 предметов сегодня';

  @override
  String get evtTreasureHuntName => 'Охота за сокровищами';

  @override
  String get evtTreasureHuntDesc =>
      'Пройдите 5 сцен подряд со всеми предметами';

  @override
  String get evtHintMasterName => 'Мастер подсказок';

  @override
  String get evtHintMasterDesc => 'Найдите 50 предметов за выходные';
}
