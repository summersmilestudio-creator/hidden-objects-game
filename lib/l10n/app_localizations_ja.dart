// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => '隠しオブジェクト';

  @override
  String get homeTitle => '隠し\nオブジェクト';

  @override
  String get homeSubtitle => '描かれたシーンの中の物を見つけよう';

  @override
  String get scenesHeader => 'シーン';

  @override
  String get tooltipAchievements => '実績';

  @override
  String get tooltipEvents => 'イベント';

  @override
  String get tooltipShop => 'ショップ';

  @override
  String get watchAdForCoins => '広告を見る → +50コイン';

  @override
  String get coinsEarned => '🎬 +50コイン！';

  @override
  String get adNotAvailable => '広告は現在利用できません。もう一度お試しください。';

  @override
  String objectsToFind(int count) {
    return '見つける物：$count個';
  }

  @override
  String get eventToday => '今日のイベント';

  @override
  String get tooltipHint => 'ヒント';

  @override
  String get tooltipSkipLevel => 'レベルをスキップ（広告）';

  @override
  String findProgress(int found, int total) {
    return 'さがそう  $found/$total';
  }

  @override
  String get levelComplete => '🎉 レベルクリア！';

  @override
  String allObjectsFoundIn(int total, String time) {
    return '$total個すべてを$timeで発見';
  }

  @override
  String get doubleX2 => '2倍にする';

  @override
  String get bonusLevels => '+2レベル 🎁';

  @override
  String get back => '戻る';

  @override
  String get skipLevelTitle => 'レベルをスキップ';

  @override
  String get skipLevelBody => '短い動画を見ると、このレベルをクリア済みにしてホームに戻れます。';

  @override
  String get cancel => 'やめる';

  @override
  String get watchVideo => '動画を見る';

  @override
  String rewardDoubled(int coins) {
    return '🎬 報酬が2倍！ +$coinsコイン';
  }

  @override
  String get bonusLevelsGranted => '🎁 +2ボーナスレベル + 400コイン！';

  @override
  String get achievementUnlocked => '🏆 実績を解除';

  @override
  String get shopTitle => 'ショップ';

  @override
  String get restore => '復元';

  @override
  String get purchaseSuccess => '✅ 購入が完了しました。ありがとうございます！';

  @override
  String get shopUnavailable => 'ショップは現在利用できません。もう一度お試しください。';

  @override
  String get restoringPurchases => '購入を復元しています…';

  @override
  String get yourCoins => '所持コイン';

  @override
  String get adsRemovedTitle => '広告を削除しました';

  @override
  String get adsRemovedSubtitle => 'ご支援ありがとうございます！';

  @override
  String get removeAdsTitle => '広告を削除';

  @override
  String get removeAdsSubtitle => 'バナーもインタースティシャル広告もなし';

  @override
  String get coinPacks => 'コインパック';

  @override
  String coinPackBonus(int coins, int bonus) {
    return '$coins + ボーナス$bonusコイン';
  }

  @override
  String coinPackPlain(int coins) {
    return '$coinsコイン';
  }

  @override
  String get bestValue => 'いちばんお得';

  @override
  String get moreHints => 'ヒントを増やす';

  @override
  String get paymentNotice => 'お支払いはApp Storeアカウントに請求されます。';

  @override
  String get achievementsTitle => '実績';

  @override
  String get totalProgress => '全体の進捗';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$total件中$unlocked件の実績';
  }

  @override
  String get dailyBonus => 'デイリーボーナス';

  @override
  String dayOfSeven(int day) {
    return '$day日目 / 7';
  }

  @override
  String dayShort(int day) {
    return '$day日';
  }

  @override
  String doubleX2WithReward(int reward) {
    return '2倍にする  (+$reward)';
  }

  @override
  String get claim => '受け取る';

  @override
  String bonusDoubled(int reward) {
    return '🎬 ボーナスが2倍！ +$rewardコイン';
  }

  @override
  String get eventsTitle => 'イベント';

  @override
  String get eventOfTheDay => '本日のイベント';

  @override
  String rewardStars(int stars) {
    return '報酬の星$stars個';
  }

  @override
  String get playNow => '今すぐプレイ';

  @override
  String get eventCalendar => 'イベントカレンダー';

  @override
  String get special => 'スペシャル';

  @override
  String get today => '今日';

  @override
  String get tomorrow => '明日';

  @override
  String get weekdayMon => '月';

  @override
  String get weekdayTue => '火';

  @override
  String get weekdayWed => '水';

  @override
  String get weekdayThu => '木';

  @override
  String get weekdayFri => '金';

  @override
  String get weekdaySat => '土';

  @override
  String get weekdaySun => '日';

  @override
  String get escapeAdsTitle => '広告とおさらば';

  @override
  String get escapeAdsBody => 'バナーも邪魔な広告もなしでプレイ。一度きり、ずっと。';

  @override
  String removeAdsForPrice(String price) {
    return '広告を削除 • $price';
  }

  @override
  String get later => 'あとで';

  @override
  String get notificationTitle => '隠しオブジェクト';

  @override
  String get notificationBody => '隠れた物を見つけよう！🔍';

  @override
  String get achFirstFindTitle => '初めての発見';

  @override
  String get achFirstFindDesc => '最初の物を見つける';

  @override
  String get achGardenMasterTitle => '庭園の達人';

  @override
  String get achGardenMasterDesc => '魔法の庭をクリアする';

  @override
  String get achHalfwayHeroTitle => '折り返しの英雄';

  @override
  String get achHalfwayHeroDesc => '4つのシーンをクリアする';

  @override
  String get achMasterDetectiveTitle => '名探偵';

  @override
  String get achMasterDetectiveDesc => '8つのシーンすべてをクリアする';

  @override
  String get achHawkEyeTitle => '鷹の目';

  @override
  String get achHawkEyeDesc => '合計50個の物を見つける';

  @override
  String get achEagleEyeTitle => '鷲の目';

  @override
  String get achEagleEyeDesc => '合計200個の物を見つける';

  @override
  String get achNoCheatTitle => 'ノーヒント';

  @override
  String get achNoCheatDesc => 'ヒントなしでシーンをクリアする';

  @override
  String get achSpeedRunnerTitle => 'スピードランナー';

  @override
  String get achSpeedRunnerDesc => '30秒未満でシーンをクリアする';

  @override
  String get evtDailyChallengeName => '今日のチャレンジ';

  @override
  String get evtDailyChallengeDesc => '1つのシーンですべての物を見つける';

  @override
  String get evtHawkEyeName => '鷲の目';

  @override
  String get evtHawkEyeDesc => 'ヒントを使わずにシーンをクリアする';

  @override
  String get evtQuickHuntName => 'クイックハント';

  @override
  String get evtQuickHuntDesc => '60秒未満で5個の物を見つける';

  @override
  String get evtMarathonName => 'マラソン探偵';

  @override
  String get evtMarathonDesc => '今日3つの異なるシーンをプレイする';

  @override
  String get evtCollectorName => 'コレクター';

  @override
  String get evtCollectorDesc => '今日25個の物を集める';

  @override
  String get evtTreasureHuntName => '宝探し';

  @override
  String get evtTreasureHuntDesc => '5つのシーンを連続ですべての物をクリアする';

  @override
  String get evtHintMasterName => 'ヒントの達人';

  @override
  String get evtHintMasterDesc => '週末に50個の物を見つける';

  @override
  String get livesFull => 'ライフ満タン';

  @override
  String nextLifeIn(String time) {
    return '次のライフまで $time';
  }

  @override
  String get outOfLivesTitle => 'ライフがありません';

  @override
  String get outOfLivesBody => '回復を待つか、広告を見るか、コインを使ってください。';

  @override
  String get getLifeAd => '+1 ライフ（広告）';

  @override
  String getLifeCoins(int coins) {
    return '+1 ライフ（$coins 🪙）';
  }

  @override
  String get waitButton => '待つ';

  @override
  String get notEnoughCoins => 'コインが足りません';

  @override
  String get watchAd10Coins => '広告を見る → 10 コイン';

  @override
  String get powersTitle => 'パワー';

  @override
  String get powerHintName => 'ヒント';

  @override
  String get powerHintDesc => '隠れたアイテムを1つ表示';

  @override
  String get powerScanName => 'スキャン';

  @override
  String get powerScanDesc => '残りのアイテムをすべて点滅表示';

  @override
  String get powerFreezeName => '時間停止';

  @override
  String get powerFreezeDesc => '20秒間タイマーを止める';

  @override
  String get powerShieldName => 'シールド';

  @override
  String get powerShieldDesc => '次のミスタップのペナルティを無効化';

  @override
  String powerOwnedCount(int count) {
    return '所持数：$count';
  }

  @override
  String powerActivated(String name) {
    return '$name 発動！';
  }

  @override
  String powerNoneLeft(String name) {
    return '$name がありません。ショップで購入してください。';
  }

  @override
  String get freezeActiveBadge => '⏸ 時間停止中';

  @override
  String get scanActiveBadge => '🔎 スキャン中';

  @override
  String get shieldActiveBadge => '🛡 シールド有効';

  @override
  String get buyAction => '購入';
}
