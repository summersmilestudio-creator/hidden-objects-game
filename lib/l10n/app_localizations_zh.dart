// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '隐藏物品';

  @override
  String get homeTitle => '隐藏\n物品';

  @override
  String get homeSubtitle => '在绘制的场景中找出物品';

  @override
  String get scenesHeader => '场景';

  @override
  String get tooltipAchievements => '成就';

  @override
  String get tooltipEvents => '活动';

  @override
  String get tooltipShop => '商店';

  @override
  String get watchAdForCoins => '观看广告 → +50 金币';

  @override
  String get coinsEarned => '🎬 +50 金币！';

  @override
  String get adNotAvailable => '广告暂时无法播放，请重试。';

  @override
  String objectsToFind(int count) {
    return '待找物品 $count 个';
  }

  @override
  String get eventToday => '今日活动';

  @override
  String get tooltipHint => '提示';

  @override
  String get tooltipSkipLevel => '跳过关卡（广告）';

  @override
  String findProgress(int found, int total) {
    return '寻找  $found/$total';
  }

  @override
  String get levelComplete => '🎉 关卡完成！';

  @override
  String allObjectsFoundIn(int total, String time) {
    return '全部 $total 个物品已在 $time 内找到';
  }

  @override
  String get doubleX2 => '翻倍 ×2';

  @override
  String get bonusLevels => '+2 关卡 🎁';

  @override
  String get back => '返回';

  @override
  String get skipLevelTitle => '跳过关卡';

  @override
  String get skipLevelBody => '观看一段短视频即可将本关标记为已完成并返回主页。';

  @override
  String get cancel => '取消';

  @override
  String get watchVideo => '观看视频';

  @override
  String rewardDoubled(int coins) {
    return '🎬 奖励翻倍！+$coins 金币';
  }

  @override
  String get bonusLevelsGranted => '🎁 +2 额外关卡 + 400 金币！';

  @override
  String get achievementUnlocked => '🏆 成就解锁';

  @override
  String get shopTitle => '商店';

  @override
  String get restore => '恢复';

  @override
  String get purchaseSuccess => '✅ 购买成功，谢谢！';

  @override
  String get shopUnavailable => '商店暂时无法使用，请重试。';

  @override
  String get restoringPurchases => '正在恢复购买…';

  @override
  String get yourCoins => '你的金币';

  @override
  String get adsRemovedTitle => '广告已移除';

  @override
  String get adsRemovedSubtitle => '感谢支持！';

  @override
  String get removeAdsTitle => '移除广告';

  @override
  String get removeAdsSubtitle => '没有横幅广告和插页广告';

  @override
  String get coinPacks => '金币礼包';

  @override
  String coinPackBonus(int coins, int bonus) {
    return '$coins + $bonus 额外金币';
  }

  @override
  String coinPackPlain(int coins) {
    return '$coins 金币';
  }

  @override
  String get bestValue => '超值之选';

  @override
  String get moreHints => '更多提示';

  @override
  String get paymentNotice => '费用将从你的 App Store 账户扣除。';

  @override
  String get achievementsTitle => '成就';

  @override
  String get totalProgress => '总进度';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$total 个成就中已获得 $unlocked 个';
  }

  @override
  String get dailyBonus => '每日奖励';

  @override
  String dayOfSeven(int day) {
    return '第 $day 天 / 7';
  }

  @override
  String dayShort(int day) {
    return '第$day天';
  }

  @override
  String doubleX2WithReward(int reward) {
    return '翻倍 ×2  (+$reward)';
  }

  @override
  String get claim => '领取';

  @override
  String bonusDoubled(int reward) {
    return '🎬 奖励翻倍！+$reward 金币';
  }

  @override
  String get eventsTitle => '活动';

  @override
  String get eventOfTheDay => '今日活动';

  @override
  String rewardStars(int stars) {
    return '奖励 $stars 颗星';
  }

  @override
  String get playNow => '立即游玩';

  @override
  String get eventCalendar => '活动日历';

  @override
  String get special => '特别';

  @override
  String get today => '今天';

  @override
  String get tomorrow => '明天';

  @override
  String get weekdayMon => '周一';

  @override
  String get weekdayTue => '周二';

  @override
  String get weekdayWed => '周三';

  @override
  String get weekdayThu => '周四';

  @override
  String get weekdayFri => '周五';

  @override
  String get weekdaySat => '周六';

  @override
  String get weekdaySun => '周日';

  @override
  String get escapeAdsTitle => '告别广告';

  @override
  String get escapeAdsBody => '畅玩，没有横幅，也没有打断你的广告。一次购买，永久有效。';

  @override
  String removeAdsForPrice(String price) {
    return '移除广告 • $price';
  }

  @override
  String get later => '以后再说';

  @override
  String get notificationTitle => '隐藏物品';

  @override
  String get notificationBody => '快来找出隐藏的物品吧！🔍';

  @override
  String get achFirstFindTitle => '初次发现';

  @override
  String get achFirstFindDesc => '找到你的第一个物品';

  @override
  String get achGardenMasterTitle => '花园大师';

  @override
  String get achGardenMasterDesc => '完成魔法花园';

  @override
  String get achHalfwayHeroTitle => '半程英雄';

  @override
  String get achHalfwayHeroDesc => '完成 4 个场景';

  @override
  String get achMasterDetectiveTitle => '侦探大师';

  @override
  String get achMasterDetectiveDesc => '完成全部 8 个场景';

  @override
  String get achHawkEyeTitle => '鹰眼';

  @override
  String get achHawkEyeDesc => '累计找到 50 个物品';

  @override
  String get achEagleEyeTitle => '雕眼';

  @override
  String get achEagleEyeDesc => '累计找到 200 个物品';

  @override
  String get achNoCheatTitle => '绝不作弊';

  @override
  String get achNoCheatDesc => '不用提示完成一个场景';

  @override
  String get achSpeedRunnerTitle => '极速达人';

  @override
  String get achSpeedRunnerDesc => '在 30 秒内完成一个场景';

  @override
  String get evtDailyChallengeName => '每日挑战';

  @override
  String get evtDailyChallengeDesc => '在一个场景中找出所有物品';

  @override
  String get evtHawkEyeName => '雕眼';

  @override
  String get evtHawkEyeDesc => '不使用提示完成一个场景';

  @override
  String get evtQuickHuntName => '快速寻物';

  @override
  String get evtQuickHuntDesc => '在 60 秒内找到 5 个物品';

  @override
  String get evtMarathonName => '马拉松侦探';

  @override
  String get evtMarathonDesc => '今天玩 3 个不同的场景';

  @override
  String get evtCollectorName => '收藏家';

  @override
  String get evtCollectorDesc => '今天收集 25 个物品';

  @override
  String get evtTreasureHuntName => '寻宝';

  @override
  String get evtTreasureHuntDesc => '连续完成 5 个场景并找齐所有物品';

  @override
  String get evtHintMasterName => '提示大师';

  @override
  String get evtHintMasterDesc => '在周末找到 50 个物品';

  @override
  String get livesFull => '生命已满';

  @override
  String nextLifeIn(String time) {
    return '下一个生命还需 $time';
  }

  @override
  String get outOfLivesTitle => '没有生命了';

  @override
  String get outOfLivesBody => '等待恢复、观看广告或使用金币。';

  @override
  String get getLifeAd => '+1 生命（广告）';

  @override
  String getLifeCoins(int coins) {
    return '+1 生命（$coins 🪙）';
  }

  @override
  String get waitButton => '等待';

  @override
  String get notEnoughCoins => '金币不足';

  @override
  String get watchAd10Coins => '观看广告 → 10 金币';

  @override
  String get powersTitle => '道具';

  @override
  String get powerHintName => '提示';

  @override
  String get powerHintDesc => '显示一个隐藏物品';

  @override
  String get powerScanName => '扫描';

  @override
  String get powerScanDesc => '闪烁显示所有剩余物品';

  @override
  String get powerFreezeName => '时间冻结';

  @override
  String get powerFreezeDesc => '暂停计时器20秒';

  @override
  String get powerShieldName => '护盾';

  @override
  String get powerShieldDesc => '抵消下一次点错的惩罚';

  @override
  String powerOwnedCount(int count) {
    return '拥有：$count';
  }

  @override
  String powerActivated(String name) {
    return '$name 已启动！';
  }

  @override
  String powerNoneLeft(String name) {
    return '没有$name了，去商店购买。';
  }

  @override
  String get freezeActiveBadge => '⏸ 时间冻结';

  @override
  String get scanActiveBadge => '🔎 扫描中';

  @override
  String get shieldActiveBadge => '🛡 护盾生效';

  @override
  String get buyAction => '购买';
}
