import 'package:flutter/material.dart';

import 'bookings_screen.dart';
import 'parking_list_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  final _titles = const ['Парковки', 'Мои брони', 'Профиль'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_index])),
      // IndexedStack сохраняет состояние вкладок
      body: IndexedStack(
        index: _index,
        children: const [
          ParkingListScreen(),
          BookingsScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.local_parking), label: 'Парковки'),
          NavigationDestination(icon: Icon(Icons.bookmark), label: 'Брони'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }
}