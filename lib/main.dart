import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';
import 'services/notification_service.dart';
import 'services/review_service.dart';
import 'screens/home_screen.dart';
import 'services/ads_service.dart';
import 'services/purchase_service.dart';
import 'game/level_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LevelStore.preload();
  await PurchaseService.instance.initialize();
  await AdsService.instance.initialize();
  ReviewService.instance.registerLaunch();
  NotificationService.instance.scheduleDailyReminder(title: 'Hidden Objects', body: 'Găsește obiectele ascunse! 🔍');
  runApp(const HiddenObjectsApp());
}

class HiddenObjectsApp extends StatelessWidget {
  const HiddenObjectsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hidden Objects',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6F00),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0F0F1A),
      ),
      home: UpgradeAlert(child: const HomeScreen()),
    );
  }
}
