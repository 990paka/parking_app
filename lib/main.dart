import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'models.dart';
import 'screens/detail_screen.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/slots_screen.dart';
import 'firebase_options.dart';
import 'services/notification_service.dart';
import 'theme.dart';

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
  await NotificationService.instance.init();
  runApp(const ParkingApp());
}

class ParkingApp extends StatelessWidget {
  const ParkingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Парковка',
      debugShowCheckedModeBanner: false,
      theme: appTheme, // собственная тема
      initialRoute: '/',
      // Именованные маршруты
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/home': (context) => const HomeScreen(),
        '/detail': (context) => const DetailScreen(), // параметры через arguments
      },
      // Передача параметров "в маршруте"
      onGenerateRoute: (settings) {
        if (settings.name == '/slots') {
          final parking = settings.arguments as Parking;
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => SlotsScreen(parking: parking),
          );
        }
        return null;
      },
    );
  }
}