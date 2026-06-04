// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Objetos Ocultos';

  @override
  String get homeTitle => 'OBJETOS\nOCULTOS';

  @override
  String get homeSubtitle => 'Encuentra los objetos en las escenas pintadas';

  @override
  String get scenesHeader => 'Escenas';

  @override
  String get tooltipAchievements => 'Logros';

  @override
  String get tooltipEvents => 'Eventos';

  @override
  String get tooltipShop => 'Tienda';

  @override
  String get watchAdForCoins => 'Ve un anuncio → +50 monedas';

  @override
  String get coinsEarned => '🎬 ¡+50 monedas!';

  @override
  String get adNotAvailable =>
      'El anuncio no está disponible ahora, inténtalo de nuevo.';

  @override
  String objectsToFind(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count objetos por encontrar',
      one: '$count objeto por encontrar',
    );
    return '$_temp0';
  }

  @override
  String get eventToday => 'EVENTO DE HOY';

  @override
  String get tooltipHint => 'Pista';

  @override
  String get tooltipSkipLevel => 'Saltar nivel (anuncio)';

  @override
  String findProgress(int found, int total) {
    return 'ENCUENTRA  $found/$total';
  }

  @override
  String get levelComplete => '🎉 ¡Nivel completado!';

  @override
  String allObjectsFoundIn(int total, String time) {
    return 'Los $total objetos encontrados en $time';
  }

  @override
  String get doubleX2 => 'Duplicar ×2';

  @override
  String get bonusLevels => '+2 niveles 🎁';

  @override
  String get back => 'Atrás';

  @override
  String get skipLevelTitle => 'Saltar nivel';

  @override
  String get skipLevelBody =>
      'Mira un vídeo corto para marcar el nivel como resuelto y volver al inicio.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get watchVideo => 'Ver vídeo';

  @override
  String rewardDoubled(int coins) {
    return '🎬 ¡Recompensa duplicada! +$coins monedas';
  }

  @override
  String get bonusLevelsGranted => '🎁 ¡+2 niveles extra + 400 monedas!';

  @override
  String get achievementUnlocked => '🏆 Logro desbloqueado';

  @override
  String get shopTitle => 'Tienda';

  @override
  String get restore => 'Restaurar';

  @override
  String get purchaseSuccess => '✅ Compra realizada. ¡Gracias!';

  @override
  String get shopUnavailable =>
      'La tienda no está disponible ahora. Inténtalo de nuevo.';

  @override
  String get restoringPurchases => 'Restaurando compras…';

  @override
  String get yourCoins => 'Tus monedas';

  @override
  String get adsRemovedTitle => 'Anuncios eliminados';

  @override
  String get adsRemovedSubtitle => '¡Gracias por tu apoyo!';

  @override
  String get removeAdsTitle => 'Eliminar anuncios';

  @override
  String get removeAdsSubtitle => 'Sin banners ni anuncios intersticiales';

  @override
  String get coinPacks => 'PAQUETES DE MONEDAS';

  @override
  String coinPackBonus(int coins, int bonus) {
    return '$coins + $bonus monedas extra';
  }

  @override
  String coinPackPlain(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins monedas',
      one: '$coins moneda',
    );
    return '$_temp0';
  }

  @override
  String get bestValue => 'La mejor oferta';

  @override
  String get moreHints => 'Más pistas';

  @override
  String get paymentNotice => 'El pago se carga en tu cuenta de App Store.';

  @override
  String get achievementsTitle => 'Logros';

  @override
  String get totalProgress => 'Progreso total';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked de $total logros';
  }

  @override
  String get dailyBonus => 'BONO DIARIO';

  @override
  String dayOfSeven(int day) {
    return 'Día $day / 7';
  }

  @override
  String dayShort(int day) {
    return 'D$day';
  }

  @override
  String doubleX2WithReward(int reward) {
    return 'DUPLICAR ×2  (+$reward)';
  }

  @override
  String get claim => 'RECLAMAR';

  @override
  String bonusDoubled(int reward) {
    return '🎬 ¡Bono duplicado! +$reward monedas';
  }

  @override
  String get eventsTitle => 'Eventos';

  @override
  String get eventOfTheDay => 'EVENTO DEL DÍA';

  @override
  String rewardStars(int stars) {
    String _temp0 = intl.Intl.pluralLogic(
      stars,
      locale: localeName,
      other: '$stars estrellas de recompensa',
      one: '$stars estrella de recompensa',
    );
    return '$_temp0';
  }

  @override
  String get playNow => 'Jugar ahora';

  @override
  String get eventCalendar => 'Calendario de eventos';

  @override
  String get special => 'ESPECIAL';

  @override
  String get today => 'Hoy';

  @override
  String get tomorrow => 'Mañana';

  @override
  String get weekdayMon => 'Lun';

  @override
  String get weekdayTue => 'Mar';

  @override
  String get weekdayWed => 'Mié';

  @override
  String get weekdayThu => 'Jue';

  @override
  String get weekdayFri => 'Vie';

  @override
  String get weekdaySat => 'Sáb';

  @override
  String get weekdaySun => 'Dom';

  @override
  String get escapeAdsTitle => 'Adiós a los anuncios';

  @override
  String get escapeAdsBody =>
      'Juega sin banners ni anuncios que te interrumpan. Una sola vez, para siempre.';

  @override
  String removeAdsForPrice(String price) {
    return 'Eliminar anuncios • $price';
  }

  @override
  String get later => 'Más tarde';

  @override
  String get notificationTitle => 'Objetos Ocultos';

  @override
  String get notificationBody => '¡Encuentra los objetos ocultos! 🔍';

  @override
  String get achFirstFindTitle => 'Primer Hallazgo';

  @override
  String get achFirstFindDesc => 'Encuentra tu primer objeto';

  @override
  String get achGardenMasterTitle => 'Maestro del Jardín';

  @override
  String get achGardenMasterDesc => 'Termina el Jardín Mágico';

  @override
  String get achHalfwayHeroTitle => 'Héroe a Medias';

  @override
  String get achHalfwayHeroDesc => 'Termina 4 escenas';

  @override
  String get achMasterDetectiveTitle => 'Detective Maestro';

  @override
  String get achMasterDetectiveDesc => 'Termina las 8 escenas';

  @override
  String get achHawkEyeTitle => 'Ojo de Halcón';

  @override
  String get achHawkEyeDesc => 'Encuentra 50 objetos en total';

  @override
  String get achEagleEyeTitle => 'Ojo de Águila';

  @override
  String get achEagleEyeDesc => 'Encuentra 200 objetos en total';

  @override
  String get achNoCheatTitle => 'Sin Trampas';

  @override
  String get achNoCheatDesc => 'Termina una escena sin pista';

  @override
  String get achSpeedRunnerTitle => 'Velocista';

  @override
  String get achSpeedRunnerDesc => 'Termina una escena en menos de 30 segundos';

  @override
  String get evtDailyChallengeName => 'Desafío del Día';

  @override
  String get evtDailyChallengeDesc =>
      'Encuentra todos los objetos en una sola escena';

  @override
  String get evtHawkEyeName => 'Ojo de Águila';

  @override
  String get evtHawkEyeDesc => 'Termina una escena sin usar pistas';

  @override
  String get evtQuickHuntName => 'Caza Rápida';

  @override
  String get evtQuickHuntDesc => 'Encuentra 5 objetos en menos de 60 segundos';

  @override
  String get evtMarathonName => 'Detective Maratón';

  @override
  String get evtMarathonDesc => 'Juega 3 escenas diferentes hoy';

  @override
  String get evtCollectorName => 'El Coleccionista';

  @override
  String get evtCollectorDesc => 'Reúne 25 objetos hoy';

  @override
  String get evtTreasureHuntName => 'Caza del Tesoro';

  @override
  String get evtTreasureHuntDesc =>
      'Termina 5 escenas seguidas con todos los objetos';

  @override
  String get evtHintMasterName => 'Maestro de Pistas';

  @override
  String get evtHintMasterDesc =>
      'Encuentra 50 objetos durante el fin de semana';
}
