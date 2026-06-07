import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ro'),
    Locale('ru'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In ro, this message translates to:
  /// **'Obiecte Ascunse'**
  String get appTitle;

  /// No description provided for @homeTitle.
  ///
  /// In ro, this message translates to:
  /// **'OBIECTE\nASCUNSE'**
  String get homeTitle;

  /// No description provided for @homeSubtitle.
  ///
  /// In ro, this message translates to:
  /// **'Găsește obiectele în scenele pictate'**
  String get homeSubtitle;

  /// No description provided for @scenesHeader.
  ///
  /// In ro, this message translates to:
  /// **'Scene'**
  String get scenesHeader;

  /// No description provided for @tooltipAchievements.
  ///
  /// In ro, this message translates to:
  /// **'Realizări'**
  String get tooltipAchievements;

  /// No description provided for @tooltipEvents.
  ///
  /// In ro, this message translates to:
  /// **'Evenimente'**
  String get tooltipEvents;

  /// No description provided for @tooltipShop.
  ///
  /// In ro, this message translates to:
  /// **'Magazin'**
  String get tooltipShop;

  /// No description provided for @watchAdForCoins.
  ///
  /// In ro, this message translates to:
  /// **'Vezi o reclamă → +50 monede'**
  String get watchAdForCoins;

  /// No description provided for @coinsEarned.
  ///
  /// In ro, this message translates to:
  /// **'🎬 +50 monede!'**
  String get coinsEarned;

  /// No description provided for @adNotAvailable.
  ///
  /// In ro, this message translates to:
  /// **'Reclama nu e disponibilă acum, încearcă din nou.'**
  String get adNotAvailable;

  /// No description provided for @objectsToFind.
  ///
  /// In ro, this message translates to:
  /// **'{count} obiecte de găsit'**
  String objectsToFind(int count);

  /// No description provided for @eventToday.
  ///
  /// In ro, this message translates to:
  /// **'EVENIMENT AZI'**
  String get eventToday;

  /// No description provided for @tooltipHint.
  ///
  /// In ro, this message translates to:
  /// **'Indiciu'**
  String get tooltipHint;

  /// No description provided for @tooltipSkipLevel.
  ///
  /// In ro, this message translates to:
  /// **'Sari peste nivel (reclamă)'**
  String get tooltipSkipLevel;

  /// No description provided for @findProgress.
  ///
  /// In ro, this message translates to:
  /// **'GĂSEȘTE  {found}/{total}'**
  String findProgress(int found, int total);

  /// No description provided for @levelComplete.
  ///
  /// In ro, this message translates to:
  /// **'🎉 Nivel complet!'**
  String get levelComplete;

  /// No description provided for @allObjectsFoundIn.
  ///
  /// In ro, this message translates to:
  /// **'Toate {total} obiectele găsite în {time}'**
  String allObjectsFoundIn(int total, String time);

  /// No description provided for @doubleX2.
  ///
  /// In ro, this message translates to:
  /// **'Dublează ×2'**
  String get doubleX2;

  /// No description provided for @bonusLevels.
  ///
  /// In ro, this message translates to:
  /// **'+2 niveluri 🎁'**
  String get bonusLevels;

  /// No description provided for @back.
  ///
  /// In ro, this message translates to:
  /// **'Înapoi'**
  String get back;

  /// No description provided for @skipLevelTitle.
  ///
  /// In ro, this message translates to:
  /// **'Sari peste nivel'**
  String get skipLevelTitle;

  /// No description provided for @skipLevelBody.
  ///
  /// In ro, this message translates to:
  /// **'Vezi un scurt videoclip pentru a marca nivelul ca rezolvat și a te întoarce acasă.'**
  String get skipLevelBody;

  /// No description provided for @cancel.
  ///
  /// In ro, this message translates to:
  /// **'Renunță'**
  String get cancel;

  /// No description provided for @watchVideo.
  ///
  /// In ro, this message translates to:
  /// **'Vezi video'**
  String get watchVideo;

  /// No description provided for @rewardDoubled.
  ///
  /// In ro, this message translates to:
  /// **'🎬 Recompensă dublată! +{coins} monede'**
  String rewardDoubled(int coins);

  /// No description provided for @bonusLevelsGranted.
  ///
  /// In ro, this message translates to:
  /// **'🎁 +2 niveluri bonus + 400 monede!'**
  String get bonusLevelsGranted;

  /// No description provided for @achievementUnlocked.
  ///
  /// In ro, this message translates to:
  /// **'🏆 Realizare deblocată'**
  String get achievementUnlocked;

  /// No description provided for @shopTitle.
  ///
  /// In ro, this message translates to:
  /// **'Magazin'**
  String get shopTitle;

  /// No description provided for @restore.
  ///
  /// In ro, this message translates to:
  /// **'Restaurează'**
  String get restore;

  /// No description provided for @purchaseSuccess.
  ///
  /// In ro, this message translates to:
  /// **'✅ Cumpărare reușită. Mulțumim!'**
  String get purchaseSuccess;

  /// No description provided for @shopUnavailable.
  ///
  /// In ro, this message translates to:
  /// **'Magazinul nu este disponibil acum. Încearcă din nou.'**
  String get shopUnavailable;

  /// No description provided for @restoringPurchases.
  ///
  /// In ro, this message translates to:
  /// **'Se restaurează cumpărăturile…'**
  String get restoringPurchases;

  /// No description provided for @yourCoins.
  ///
  /// In ro, this message translates to:
  /// **'Monedele tale'**
  String get yourCoins;

  /// No description provided for @adsRemovedTitle.
  ///
  /// In ro, this message translates to:
  /// **'Reclame eliminate'**
  String get adsRemovedTitle;

  /// No description provided for @adsRemovedSubtitle.
  ///
  /// In ro, this message translates to:
  /// **'Mulțumim pentru susținere!'**
  String get adsRemovedSubtitle;

  /// No description provided for @removeAdsTitle.
  ///
  /// In ro, this message translates to:
  /// **'Elimină reclamele'**
  String get removeAdsTitle;

  /// No description provided for @removeAdsSubtitle.
  ///
  /// In ro, this message translates to:
  /// **'Fără bannere și reclame interstițiale'**
  String get removeAdsSubtitle;

  /// No description provided for @coinPacks.
  ///
  /// In ro, this message translates to:
  /// **'PACHETE DE MONEDE'**
  String get coinPacks;

  /// No description provided for @coinPackBonus.
  ///
  /// In ro, this message translates to:
  /// **'{coins} + {bonus} bonus monede'**
  String coinPackBonus(int coins, int bonus);

  /// No description provided for @coinPackPlain.
  ///
  /// In ro, this message translates to:
  /// **'{coins} monede'**
  String coinPackPlain(int coins);

  /// No description provided for @bestValue.
  ///
  /// In ro, this message translates to:
  /// **'Cea mai bună valoare'**
  String get bestValue;

  /// No description provided for @moreHints.
  ///
  /// In ro, this message translates to:
  /// **'Mai multe indicii'**
  String get moreHints;

  /// No description provided for @paymentNotice.
  ///
  /// In ro, this message translates to:
  /// **'Plata se face prin contul tău App Store.'**
  String get paymentNotice;

  /// No description provided for @achievementsTitle.
  ///
  /// In ro, this message translates to:
  /// **'Realizări'**
  String get achievementsTitle;

  /// No description provided for @totalProgress.
  ///
  /// In ro, this message translates to:
  /// **'Progres total'**
  String get totalProgress;

  /// No description provided for @achievementsUnlockedCount.
  ///
  /// In ro, this message translates to:
  /// **'{unlocked} din {total} realizări'**
  String achievementsUnlockedCount(int unlocked, int total);

  /// No description provided for @dailyBonus.
  ///
  /// In ro, this message translates to:
  /// **'BONUS ZILNIC'**
  String get dailyBonus;

  /// No description provided for @dayOfSeven.
  ///
  /// In ro, this message translates to:
  /// **'Ziua {day} / 7'**
  String dayOfSeven(int day);

  /// No description provided for @dayShort.
  ///
  /// In ro, this message translates to:
  /// **'Z{day}'**
  String dayShort(int day);

  /// No description provided for @doubleX2WithReward.
  ///
  /// In ro, this message translates to:
  /// **'DUBLEAZĂ ×2  (+{reward})'**
  String doubleX2WithReward(int reward);

  /// No description provided for @claim.
  ///
  /// In ro, this message translates to:
  /// **'PRIMEȘTE'**
  String get claim;

  /// No description provided for @bonusDoubled.
  ///
  /// In ro, this message translates to:
  /// **'🎬 Bonus dublat! +{reward} monede'**
  String bonusDoubled(int reward);

  /// No description provided for @eventsTitle.
  ///
  /// In ro, this message translates to:
  /// **'Evenimente'**
  String get eventsTitle;

  /// No description provided for @eventOfTheDay.
  ///
  /// In ro, this message translates to:
  /// **'EVENIMENTUL DE AZI'**
  String get eventOfTheDay;

  /// No description provided for @rewardStars.
  ///
  /// In ro, this message translates to:
  /// **'{stars} stele recompensă'**
  String rewardStars(int stars);

  /// No description provided for @playNow.
  ///
  /// In ro, this message translates to:
  /// **'Joacă acum'**
  String get playNow;

  /// No description provided for @eventCalendar.
  ///
  /// In ro, this message translates to:
  /// **'Calendar evenimente'**
  String get eventCalendar;

  /// No description provided for @special.
  ///
  /// In ro, this message translates to:
  /// **'SPECIAL'**
  String get special;

  /// No description provided for @today.
  ///
  /// In ro, this message translates to:
  /// **'Azi'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In ro, this message translates to:
  /// **'Mâine'**
  String get tomorrow;

  /// No description provided for @weekdayMon.
  ///
  /// In ro, this message translates to:
  /// **'Lun'**
  String get weekdayMon;

  /// No description provided for @weekdayTue.
  ///
  /// In ro, this message translates to:
  /// **'Mar'**
  String get weekdayTue;

  /// No description provided for @weekdayWed.
  ///
  /// In ro, this message translates to:
  /// **'Mie'**
  String get weekdayWed;

  /// No description provided for @weekdayThu.
  ///
  /// In ro, this message translates to:
  /// **'Joi'**
  String get weekdayThu;

  /// No description provided for @weekdayFri.
  ///
  /// In ro, this message translates to:
  /// **'Vin'**
  String get weekdayFri;

  /// No description provided for @weekdaySat.
  ///
  /// In ro, this message translates to:
  /// **'Sâm'**
  String get weekdaySat;

  /// No description provided for @weekdaySun.
  ///
  /// In ro, this message translates to:
  /// **'Dum'**
  String get weekdaySun;

  /// No description provided for @escapeAdsTitle.
  ///
  /// In ro, this message translates to:
  /// **'Scapă de reclame'**
  String get escapeAdsTitle;

  /// No description provided for @escapeAdsBody.
  ///
  /// In ro, this message translates to:
  /// **'Joacă fără bannere și fără reclame care te întrerup. O singură dată, pentru totdeauna.'**
  String get escapeAdsBody;

  /// No description provided for @removeAdsForPrice.
  ///
  /// In ro, this message translates to:
  /// **'Elimină reclamele • {price}'**
  String removeAdsForPrice(String price);

  /// No description provided for @later.
  ///
  /// In ro, this message translates to:
  /// **'Mai târziu'**
  String get later;

  /// No description provided for @notificationTitle.
  ///
  /// In ro, this message translates to:
  /// **'Obiecte Ascunse'**
  String get notificationTitle;

  /// No description provided for @notificationBody.
  ///
  /// In ro, this message translates to:
  /// **'Găsește obiectele ascunse! 🔍'**
  String get notificationBody;

  /// No description provided for @achFirstFindTitle.
  ///
  /// In ro, this message translates to:
  /// **'Prima Descoperire'**
  String get achFirstFindTitle;

  /// No description provided for @achFirstFindDesc.
  ///
  /// In ro, this message translates to:
  /// **'Găsește primul obiect'**
  String get achFirstFindDesc;

  /// No description provided for @achGardenMasterTitle.
  ///
  /// In ro, this message translates to:
  /// **'Maestrul Grădinii'**
  String get achGardenMasterTitle;

  /// No description provided for @achGardenMasterDesc.
  ///
  /// In ro, this message translates to:
  /// **'Termină Grădina Magică'**
  String get achGardenMasterDesc;

  /// No description provided for @achHalfwayHeroTitle.
  ///
  /// In ro, this message translates to:
  /// **'Erou la Jumătate'**
  String get achHalfwayHeroTitle;

  /// No description provided for @achHalfwayHeroDesc.
  ///
  /// In ro, this message translates to:
  /// **'Termină 4 scene'**
  String get achHalfwayHeroDesc;

  /// No description provided for @achMasterDetectiveTitle.
  ///
  /// In ro, this message translates to:
  /// **'Detectiv Maestru'**
  String get achMasterDetectiveTitle;

  /// No description provided for @achMasterDetectiveDesc.
  ///
  /// In ro, this message translates to:
  /// **'Termină toate 8 scenele'**
  String get achMasterDetectiveDesc;

  /// No description provided for @achHawkEyeTitle.
  ///
  /// In ro, this message translates to:
  /// **'Ochi de Șoim'**
  String get achHawkEyeTitle;

  /// No description provided for @achHawkEyeDesc.
  ///
  /// In ro, this message translates to:
  /// **'Găsește 50 de obiecte total'**
  String get achHawkEyeDesc;

  /// No description provided for @achEagleEyeTitle.
  ///
  /// In ro, this message translates to:
  /// **'Ochi de Vultur'**
  String get achEagleEyeTitle;

  /// No description provided for @achEagleEyeDesc.
  ///
  /// In ro, this message translates to:
  /// **'Găsește 200 de obiecte total'**
  String get achEagleEyeDesc;

  /// No description provided for @achNoCheatTitle.
  ///
  /// In ro, this message translates to:
  /// **'Fără Trișat'**
  String get achNoCheatTitle;

  /// No description provided for @achNoCheatDesc.
  ///
  /// In ro, this message translates to:
  /// **'Termină o scenă fără indiciu'**
  String get achNoCheatDesc;

  /// No description provided for @achSpeedRunnerTitle.
  ///
  /// In ro, this message translates to:
  /// **'Alergător Rapid'**
  String get achSpeedRunnerTitle;

  /// No description provided for @achSpeedRunnerDesc.
  ///
  /// In ro, this message translates to:
  /// **'Termină o scenă sub 30 secunde'**
  String get achSpeedRunnerDesc;

  /// No description provided for @evtDailyChallengeName.
  ///
  /// In ro, this message translates to:
  /// **'Provocarea Zilei'**
  String get evtDailyChallengeName;

  /// No description provided for @evtDailyChallengeDesc.
  ///
  /// In ro, this message translates to:
  /// **'Găsește toate obiectele într-o singură scenă'**
  String get evtDailyChallengeDesc;

  /// No description provided for @evtHawkEyeName.
  ///
  /// In ro, this message translates to:
  /// **'Ochi de Vultur'**
  String get evtHawkEyeName;

  /// No description provided for @evtHawkEyeDesc.
  ///
  /// In ro, this message translates to:
  /// **'Termină o scenă fără să folosești indiciu'**
  String get evtHawkEyeDesc;

  /// No description provided for @evtQuickHuntName.
  ///
  /// In ro, this message translates to:
  /// **'Vânătoarea Rapidă'**
  String get evtQuickHuntName;

  /// No description provided for @evtQuickHuntDesc.
  ///
  /// In ro, this message translates to:
  /// **'Găsește 5 obiecte sub 60 de secunde'**
  String get evtQuickHuntDesc;

  /// No description provided for @evtMarathonName.
  ///
  /// In ro, this message translates to:
  /// **'Detectiv Maraton'**
  String get evtMarathonName;

  /// No description provided for @evtMarathonDesc.
  ///
  /// In ro, this message translates to:
  /// **'Joacă 3 scene diferite astăzi'**
  String get evtMarathonDesc;

  /// No description provided for @evtCollectorName.
  ///
  /// In ro, this message translates to:
  /// **'Colecționarul'**
  String get evtCollectorName;

  /// No description provided for @evtCollectorDesc.
  ///
  /// In ro, this message translates to:
  /// **'Strânge 25 de obiecte azi'**
  String get evtCollectorDesc;

  /// No description provided for @evtTreasureHuntName.
  ///
  /// In ro, this message translates to:
  /// **'Vânătoarea de Comori'**
  String get evtTreasureHuntName;

  /// No description provided for @evtTreasureHuntDesc.
  ///
  /// In ro, this message translates to:
  /// **'Termină 5 scene la rând cu toate obiectele'**
  String get evtTreasureHuntDesc;

  /// No description provided for @evtHintMasterName.
  ///
  /// In ro, this message translates to:
  /// **'Maestrul Indiciilor'**
  String get evtHintMasterName;

  /// No description provided for @evtHintMasterDesc.
  ///
  /// In ro, this message translates to:
  /// **'Găsește 50 de obiecte în weekend'**
  String get evtHintMasterDesc;

  /// No description provided for @livesFull.
  ///
  /// In ro, this message translates to:
  /// **'Vieți pline'**
  String get livesFull;

  /// No description provided for @nextLifeIn.
  ///
  /// In ro, this message translates to:
  /// **'Următoarea viață în {time}'**
  String nextLifeIn(String time);

  /// No description provided for @outOfLivesTitle.
  ///
  /// In ro, this message translates to:
  /// **'Nu mai ai vieți'**
  String get outOfLivesTitle;

  /// No description provided for @outOfLivesBody.
  ///
  /// In ro, this message translates to:
  /// **'Așteaptă refacerea lor, vezi o reclamă sau folosește monede.'**
  String get outOfLivesBody;

  /// No description provided for @getLifeAd.
  ///
  /// In ro, this message translates to:
  /// **'+1 viață (reclamă)'**
  String get getLifeAd;

  /// No description provided for @getLifeCoins.
  ///
  /// In ro, this message translates to:
  /// **'+1 viață ({coins} 🪙)'**
  String getLifeCoins(int coins);

  /// No description provided for @waitButton.
  ///
  /// In ro, this message translates to:
  /// **'Aștept'**
  String get waitButton;

  /// No description provided for @notEnoughCoins.
  ///
  /// In ro, this message translates to:
  /// **'Nu ai destule monede'**
  String get notEnoughCoins;

  /// No description provided for @watchAd10Coins.
  ///
  /// In ro, this message translates to:
  /// **'Vezi o reclamă → 10 monede'**
  String get watchAd10Coins;

  /// No description provided for @powersTitle.
  ///
  /// In ro, this message translates to:
  /// **'PUTERI'**
  String get powersTitle;

  /// No description provided for @powerHintName.
  ///
  /// In ro, this message translates to:
  /// **'Indiciu'**
  String get powerHintName;

  /// No description provided for @powerHintDesc.
  ///
  /// In ro, this message translates to:
  /// **'Arată un obiect ascuns'**
  String get powerHintDesc;

  /// No description provided for @powerScanName.
  ///
  /// In ro, this message translates to:
  /// **'Scanare'**
  String get powerScanName;

  /// No description provided for @powerScanDesc.
  ///
  /// In ro, this message translates to:
  /// **'Clipește toate obiectele rămase'**
  String get powerScanDesc;

  /// No description provided for @powerFreezeName.
  ///
  /// In ro, this message translates to:
  /// **'Înghețare timp'**
  String get powerFreezeName;

  /// No description provided for @powerFreezeDesc.
  ///
  /// In ro, this message translates to:
  /// **'Oprește cronometrul 20 de secunde'**
  String get powerFreezeDesc;

  /// No description provided for @powerShieldName.
  ///
  /// In ro, this message translates to:
  /// **'Scut'**
  String get powerShieldName;

  /// No description provided for @powerShieldDesc.
  ///
  /// In ro, this message translates to:
  /// **'Anulează penalizarea la următoarea atingere greșită'**
  String get powerShieldDesc;

  /// No description provided for @powerOwnedCount.
  ///
  /// In ro, this message translates to:
  /// **'Ai: {count}'**
  String powerOwnedCount(int count);

  /// No description provided for @powerActivated.
  ///
  /// In ro, this message translates to:
  /// **'{name} activat!'**
  String powerActivated(String name);

  /// No description provided for @powerNoneLeft.
  ///
  /// In ro, this message translates to:
  /// **'Nu mai ai {name}. Cumpără din magazin.'**
  String powerNoneLeft(String name);

  /// No description provided for @freezeActiveBadge.
  ///
  /// In ro, this message translates to:
  /// **'⏸ Timp înghețat'**
  String get freezeActiveBadge;

  /// No description provided for @scanActiveBadge.
  ///
  /// In ro, this message translates to:
  /// **'🔎 Scanare'**
  String get scanActiveBadge;

  /// No description provided for @shieldActiveBadge.
  ///
  /// In ro, this message translates to:
  /// **'🛡 Scut activ'**
  String get shieldActiveBadge;

  /// No description provided for @buyAction.
  ///
  /// In ro, this message translates to:
  /// **'Cumpără'**
  String get buyAction;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'ja',
    'ko',
    'pt',
    'ro',
    'ru',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ro':
      return AppLocalizationsRo();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
