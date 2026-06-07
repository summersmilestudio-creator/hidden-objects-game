// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '숨은 그림 찾기';

  @override
  String get homeTitle => '숨은\n그림 찾기';

  @override
  String get homeSubtitle => '그려진 장면에서 물건을 찾으세요';

  @override
  String get scenesHeader => '장면';

  @override
  String get tooltipAchievements => '업적';

  @override
  String get tooltipEvents => '이벤트';

  @override
  String get tooltipShop => '상점';

  @override
  String get watchAdForCoins => '광고 보기 → +50 코인';

  @override
  String get coinsEarned => '🎬 +50 코인!';

  @override
  String get adNotAvailable => '지금은 광고를 볼 수 없습니다. 다시 시도하세요.';

  @override
  String objectsToFind(int count) {
    return '찾을 물건 $count개';
  }

  @override
  String get eventToday => '오늘의 이벤트';

  @override
  String get tooltipHint => '힌트';

  @override
  String get tooltipSkipLevel => '레벨 건너뛰기 (광고)';

  @override
  String findProgress(int found, int total) {
    return '찾기  $found/$total';
  }

  @override
  String get levelComplete => '🎉 레벨 완료!';

  @override
  String allObjectsFoundIn(int total, String time) {
    return '$total개의 물건을 모두 $time에 찾음';
  }

  @override
  String get doubleX2 => '2배 받기';

  @override
  String get bonusLevels => '+2 레벨 🎁';

  @override
  String get back => '뒤로';

  @override
  String get skipLevelTitle => '레벨 건너뛰기';

  @override
  String get skipLevelBody => '짧은 동영상을 보면 이 레벨을 완료로 표시하고 홈으로 돌아갑니다.';

  @override
  String get cancel => '취소';

  @override
  String get watchVideo => '동영상 보기';

  @override
  String rewardDoubled(int coins) {
    return '🎬 보상 2배! +$coins 코인';
  }

  @override
  String get bonusLevelsGranted => '🎁 +2 보너스 레벨 + 400 코인!';

  @override
  String get achievementUnlocked => '🏆 업적 달성';

  @override
  String get shopTitle => '상점';

  @override
  String get restore => '복원';

  @override
  String get purchaseSuccess => '✅ 구매 완료. 감사합니다!';

  @override
  String get shopUnavailable => '지금은 상점을 이용할 수 없습니다. 다시 시도하세요.';

  @override
  String get restoringPurchases => '구매 내역을 복원하는 중…';

  @override
  String get yourCoins => '내 코인';

  @override
  String get adsRemovedTitle => '광고 제거됨';

  @override
  String get adsRemovedSubtitle => '응원해 주셔서 감사합니다!';

  @override
  String get removeAdsTitle => '광고 제거';

  @override
  String get removeAdsSubtitle => '배너와 전면 광고 없음';

  @override
  String get coinPacks => '코인 패키지';

  @override
  String coinPackBonus(int coins, int bonus) {
    return '$coins + 보너스 $bonus 코인';
  }

  @override
  String coinPackPlain(int coins) {
    return '$coins 코인';
  }

  @override
  String get bestValue => '가장 알찬 구성';

  @override
  String get moreHints => '힌트 더 받기';

  @override
  String get paymentNotice => '결제는 App Store 계정으로 청구됩니다.';

  @override
  String get achievementsTitle => '업적';

  @override
  String get totalProgress => '전체 진행도';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '업적 $total개 중 $unlocked개';
  }

  @override
  String get dailyBonus => '일일 보너스';

  @override
  String dayOfSeven(int day) {
    return '$day일째 / 7';
  }

  @override
  String dayShort(int day) {
    return '$day일';
  }

  @override
  String doubleX2WithReward(int reward) {
    return '2배 받기  (+$reward)';
  }

  @override
  String get claim => '받기';

  @override
  String bonusDoubled(int reward) {
    return '🎬 보너스 2배! +$reward 코인';
  }

  @override
  String get eventsTitle => '이벤트';

  @override
  String get eventOfTheDay => '오늘의 이벤트';

  @override
  String rewardStars(int stars) {
    return '보상 별 $stars개';
  }

  @override
  String get playNow => '지금 플레이';

  @override
  String get eventCalendar => '이벤트 달력';

  @override
  String get special => '스페셜';

  @override
  String get today => '오늘';

  @override
  String get tomorrow => '내일';

  @override
  String get weekdayMon => '월';

  @override
  String get weekdayTue => '화';

  @override
  String get weekdayWed => '수';

  @override
  String get weekdayThu => '목';

  @override
  String get weekdayFri => '금';

  @override
  String get weekdaySat => '토';

  @override
  String get weekdaySun => '일';

  @override
  String get escapeAdsTitle => '광고에서 벗어나기';

  @override
  String get escapeAdsBody => '배너도 방해되는 광고도 없이 플레이하세요. 단 한 번, 영원히.';

  @override
  String removeAdsForPrice(String price) {
    return '광고 제거 • $price';
  }

  @override
  String get later => '나중에';

  @override
  String get notificationTitle => '숨은 그림 찾기';

  @override
  String get notificationBody => '숨은 물건을 찾아보세요! 🔍';

  @override
  String get achFirstFindTitle => '첫 발견';

  @override
  String get achFirstFindDesc => '첫 번째 물건을 찾으세요';

  @override
  String get achGardenMasterTitle => '정원의 달인';

  @override
  String get achGardenMasterDesc => '마법의 정원을 완료하세요';

  @override
  String get achHalfwayHeroTitle => '절반의 영웅';

  @override
  String get achHalfwayHeroDesc => '4개 장면을 완료하세요';

  @override
  String get achMasterDetectiveTitle => '명탐정';

  @override
  String get achMasterDetectiveDesc => '8개 장면을 모두 완료하세요';

  @override
  String get achHawkEyeTitle => '매의 눈';

  @override
  String get achHawkEyeDesc => '총 50개의 물건을 찾으세요';

  @override
  String get achEagleEyeTitle => '독수리의 눈';

  @override
  String get achEagleEyeDesc => '총 200개의 물건을 찾으세요';

  @override
  String get achNoCheatTitle => '노 힌트';

  @override
  String get achNoCheatDesc => '힌트 없이 장면을 완료하세요';

  @override
  String get achSpeedRunnerTitle => '스피드러너';

  @override
  String get achSpeedRunnerDesc => '30초 안에 장면을 완료하세요';

  @override
  String get evtDailyChallengeName => '오늘의 도전';

  @override
  String get evtDailyChallengeDesc => '한 장면에서 모든 물건을 찾으세요';

  @override
  String get evtHawkEyeName => '독수리의 눈';

  @override
  String get evtHawkEyeDesc => '힌트를 쓰지 않고 장면을 완료하세요';

  @override
  String get evtQuickHuntName => '퀵 헌트';

  @override
  String get evtQuickHuntDesc => '60초 안에 5개의 물건을 찾으세요';

  @override
  String get evtMarathonName => '마라톤 탐정';

  @override
  String get evtMarathonDesc => '오늘 서로 다른 3개 장면을 플레이하세요';

  @override
  String get evtCollectorName => '수집가';

  @override
  String get evtCollectorDesc => '오늘 25개의 물건을 모으세요';

  @override
  String get evtTreasureHuntName => '보물 찾기';

  @override
  String get evtTreasureHuntDesc => '5개 장면을 연속으로 모든 물건과 함께 완료하세요';

  @override
  String get evtHintMasterName => '힌트의 달인';

  @override
  String get evtHintMasterDesc => '주말 동안 50개의 물건을 찾으세요';

  @override
  String get livesFull => '생명 가득';

  @override
  String nextLifeIn(String time) {
    return '다음 생명까지 $time';
  }

  @override
  String get outOfLivesTitle => '생명이 없습니다';

  @override
  String get outOfLivesBody => '회복을 기다리거나, 광고를 보거나, 코인을 사용하세요.';

  @override
  String get getLifeAd => '+1 생명 (광고)';

  @override
  String getLifeCoins(int coins) {
    return '+1 생명 ($coins 🪙)';
  }

  @override
  String get waitButton => '기다리기';

  @override
  String get notEnoughCoins => '코인이 부족합니다';

  @override
  String get watchAd10Coins => '광고 보기 → 10 코인';

  @override
  String get powersTitle => '파워';

  @override
  String get powerHintName => '힌트';

  @override
  String get powerHintDesc => '숨겨진 물건 하나를 보여줍니다';

  @override
  String get powerScanName => '스캔';

  @override
  String get powerScanDesc => '남은 물건을 모두 깜빡여 표시합니다';

  @override
  String get powerFreezeName => '시간 정지';

  @override
  String get powerFreezeDesc => '20초 동안 타이머를 멈춥니다';

  @override
  String get powerShieldName => '방패';

  @override
  String get powerShieldDesc => '다음 잘못된 터치의 페널티를 막습니다';

  @override
  String powerOwnedCount(int count) {
    return '보유: $count';
  }

  @override
  String powerActivated(String name) {
    return '$name 발동!';
  }

  @override
  String powerNoneLeft(String name) {
    return '$name이(가) 없습니다. 상점에서 구매하세요.';
  }

  @override
  String get freezeActiveBadge => '⏸ 시간 정지';

  @override
  String get scanActiveBadge => '🔎 스캔 중';

  @override
  String get shieldActiveBadge => '🛡 방패 활성';

  @override
  String get buyAction => '구매';
}
