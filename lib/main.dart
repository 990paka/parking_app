import 'package:flutter/material.dart';

import 'models.dart';
import 'screens/detail_screen.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/slots_screen.dart';
import 'theme.dart';

void main() => runApp(const ParkingApp());

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