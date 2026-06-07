// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Objetos Ocultos';

  @override
  String get homeTitle => 'OBJETOS\nOCULTOS';

  @override
  String get homeSubtitle => 'Encontre os objetos nas cenas pintadas';

  @override
  String get scenesHeader => 'Cenas';

  @override
  String get tooltipAchievements => 'Conquistas';

  @override
  String get tooltipEvents => 'Eventos';

  @override
  String get tooltipShop => 'Loja';

  @override
  String get watchAdForCoins => 'Assista a um anúncio → +50 moedas';

  @override
  String get coinsEarned => '🎬 +50 moedas!';

  @override
  String get adNotAvailable =>
      'O anúncio não está disponível agora, tente novamente.';

  @override
  String objectsToFind(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count objetos para encontrar',
      one: '$count objeto para encontrar',
    );
    return '$_temp0';
  }

  @override
  String get eventToday => 'EVENTO DE HOJE';

  @override
  String get tooltipHint => 'Dica';

  @override
  String get tooltipSkipLevel => 'Pular nível (anúncio)';

  @override
  String findProgress(int found, int total) {
    return 'ENCONTRE  $found/$total';
  }

  @override
  String get levelComplete => '🎉 Nível completo!';

  @override
  String allObjectsFoundIn(int total, String time) {
    return 'Todos os $total objetos encontrados em $time';
  }

  @override
  String get doubleX2 => 'Dobrar ×2';

  @override
  String get bonusLevels => '+2 níveis 🎁';

  @override
  String get back => 'Voltar';

  @override
  String get skipLevelTitle => 'Pular nível';

  @override
  String get skipLevelBody =>
      'Assista a um vídeo curto para marcar o nível como resolvido e voltar ao início.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get watchVideo => 'Ver vídeo';

  @override
  String rewardDoubled(int coins) {
    return '🎬 Recompensa dobrada! +$coins moedas';
  }

  @override
  String get bonusLevelsGranted => '🎁 +2 níveis bônus + 400 moedas!';

  @override
  String get achievementUnlocked => '🏆 Conquista desbloqueada';

  @override
  String get shopTitle => 'Loja';

  @override
  String get restore => 'Restaurar';

  @override
  String get purchaseSuccess => '✅ Compra concluída. Obrigado!';

  @override
  String get shopUnavailable =>
      'A loja não está disponível agora. Tente novamente.';

  @override
  String get restoringPurchases => 'Restaurando compras…';

  @override
  String get yourCoins => 'Suas moedas';

  @override
  String get adsRemovedTitle => 'Anúncios removidos';

  @override
  String get adsRemovedSubtitle => 'Obrigado pelo apoio!';

  @override
  String get removeAdsTitle => 'Remover anúncios';

  @override
  String get removeAdsSubtitle => 'Sem banners nem anúncios intersticiais';

  @override
  String get coinPacks => 'PACOTES DE MOEDAS';

  @override
  String coinPackBonus(int coins, int bonus) {
    return '$coins + $bonus moedas bônus';
  }

  @override
  String coinPackPlain(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins moedas',
      one: '$coins moeda',
    );
    return '$_temp0';
  }

  @override
  String get bestValue => 'Melhor oferta';

  @override
  String get moreHints => 'Mais dicas';

  @override
  String get paymentNotice =>
      'O pagamento é cobrado na sua conta da App Store.';

  @override
  String get achievementsTitle => 'Conquistas';

  @override
  String get totalProgress => 'Progresso total';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked de $total conquistas';
  }

  @override
  String get dailyBonus => 'BÔNUS DIÁRIO';

  @override
  String dayOfSeven(int day) {
    return 'Dia $day / 7';
  }

  @override
  String dayShort(int day) {
    return 'D$day';
  }

  @override
  String doubleX2WithReward(int reward) {
    return 'DOBRAR ×2  (+$reward)';
  }

  @override
  String get claim => 'RECEBER';

  @override
  String bonusDoubled(int reward) {
    return '🎬 Bônus dobrado! +$reward moedas';
  }

  @override
  String get eventsTitle => 'Eventos';

  @override
  String get eventOfTheDay => 'EVENTO DO DIA';

  @override
  String rewardStars(int stars) {
    String _temp0 = intl.Intl.pluralLogic(
      stars,
      locale: localeName,
      other: '$stars estrelas de recompensa',
      one: '$stars estrela de recompensa',
    );
    return '$_temp0';
  }

  @override
  String get playNow => 'Jogar agora';

  @override
  String get eventCalendar => 'Calendário de eventos';

  @override
  String get special => 'ESPECIAL';

  @override
  String get today => 'Hoje';

  @override
  String get tomorrow => 'Amanhã';

  @override
  String get weekdayMon => 'Seg';

  @override
  String get weekdayTue => 'Ter';

  @override
  String get weekdayWed => 'Qua';

  @override
  String get weekdayThu => 'Qui';

  @override
  String get weekdayFri => 'Sex';

  @override
  String get weekdaySat => 'Sáb';

  @override
  String get weekdaySun => 'Dom';

  @override
  String get escapeAdsTitle => 'Livre-se dos anúncios';

  @override
  String get escapeAdsBody =>
      'Jogue sem banners e sem anúncios que interrompem. Uma única vez, para sempre.';

  @override
  String removeAdsForPrice(String price) {
    return 'Remover anúncios • $price';
  }

  @override
  String get later => 'Mais tarde';

  @override
  String get notificationTitle => 'Objetos Ocultos';

  @override
  String get notificationBody => 'Encontre os objetos ocultos! 🔍';

  @override
  String get achFirstFindTitle => 'Primeira Descoberta';

  @override
  String get achFirstFindDesc => 'Encontre seu primeiro objeto';

  @override
  String get achGardenMasterTitle => 'Mestre do Jardim';

  @override
  String get achGardenMasterDesc => 'Termine o Jardim Mágico';

  @override
  String get achHalfwayHeroTitle => 'Herói pela Metade';

  @override
  String get achHalfwayHeroDesc => 'Termine 4 cenas';

  @override
  String get achMasterDetectiveTitle => 'Detetive Mestre';

  @override
  String get achMasterDetectiveDesc => 'Termine todas as 8 cenas';

  @override
  String get achHawkEyeTitle => 'Olho de Falcão';

  @override
  String get achHawkEyeDesc => 'Encontre 50 objetos no total';

  @override
  String get achEagleEyeTitle => 'Olho de Águia';

  @override
  String get achEagleEyeDesc => 'Encontre 200 objetos no total';

  @override
  String get achNoCheatTitle => 'Sem Trapaça';

  @override
  String get achNoCheatDesc => 'Termine uma cena sem dica';

  @override
  String get achSpeedRunnerTitle => 'Corredor Veloz';

  @override
  String get achSpeedRunnerDesc => 'Termine uma cena em menos de 30 segundos';

  @override
  String get evtDailyChallengeName => 'Desafio do Dia';

  @override
  String get evtDailyChallengeDesc =>
      'Encontre todos os objetos em uma única cena';

  @override
  String get evtHawkEyeName => 'Olho de Águia';

  @override
  String get evtHawkEyeDesc => 'Termine uma cena sem usar dica';

  @override
  String get evtQuickHuntName => 'Caça Rápida';

  @override
  String get evtQuickHuntDesc => 'Encontre 5 objetos em menos de 60 segundos';

  @override
  String get evtMarathonName => 'Detetive Maratona';

  @override
  String get evtMarathonDesc => 'Jogue 3 cenas diferentes hoje';

  @override
  String get evtCollectorName => 'O Colecionador';

  @override
  String get evtCollectorDesc => 'Junte 25 objetos hoje';

  @override
  String get evtTreasureHuntName => 'Caça ao Tesouro';

  @override
  String get evtTreasureHuntDesc =>
      'Termine 5 cenas seguidas com todos os objetos';

  @override
  String get evtHintMasterName => 'Mestre das Dicas';

  @override
  String get evtHintMasterDesc => 'Encontre 50 objetos no fim de semana';

  @override
  String get livesFull => 'Vidas no máximo';

  @override
  String nextLifeIn(String time) {
    return 'Próxima vida em $time';
  }

  @override
  String get outOfLivesTitle => 'Sem vidas';

  @override
  String get outOfLivesBody =>
      'Espera recarregarem, vê um anúncio ou usa moedas.';

  @override
  String get getLifeAd => '+1 vida (anúncio)';

  @override
  String getLifeCoins(int coins) {
    return '+1 vida ($coins 🪙)';
  }

  @override
  String get waitButton => 'Esperar';

  @override
  String get notEnoughCoins => 'Moedas insuficientes';

  @override
  String get watchAd10Coins => 'Vê um anúncio → 10 moedas';

  @override
  String get powersTitle => 'PODERES';

  @override
  String get powerHintName => 'Dica';

  @override
  String get powerHintDesc => 'Revela um objeto escondido';

  @override
  String get powerScanName => 'Verificação';

  @override
  String get powerScanDesc => 'Pisca todos os objetos restantes';

  @override
  String get powerFreezeName => 'Congelar tempo';

  @override
  String get powerFreezeDesc => 'Para o cronómetro por 20 segundos';

  @override
  String get powerShieldName => 'Escudo';

  @override
  String get powerShieldDesc => 'Anula a penalização no próximo toque errado';

  @override
  String powerOwnedCount(int count) {
    return 'Tens: $count';
  }

  @override
  String powerActivated(String name) {
    return '$name ativado!';
  }

  @override
  String powerNoneLeft(String name) {
    return 'Sem $name. Compra mais na loja.';
  }

  @override
  String get freezeActiveBadge => '⏸ Tempo congelado';

  @override
  String get scanActiveBadge => '🔎 A verificar';

  @override
  String get shieldActiveBadge => '🛡 Escudo ativo';

  @override
  String get buyAction => 'Comprar';

  @override
  String get language => 'Idioma';

  @override
  String get languageSystem => 'Predefinição do sistema';
}
