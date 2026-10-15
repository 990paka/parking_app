import 'package:flutter/material.dart';

import '../models.dart';
import 'booking_screen.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем параметры из arguments
    final parking = ModalRoute.of(context)!.settings.arguments as Parking;

    return Scaffold(
      appBar: AppBar(title: const Text('О парковке')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset('assets/images/parking.png',
                    width: double.infinity, height: 200, fit: BoxFit.cover),
                Positioned(
                  left: 16,
                  bottom: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(parking.name,
                        style: const TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    const Icon(Icons.place, color: Colors.blue),
                    const SizedBox(width: 8),
                    Text(parking.address),
                  ]),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _Info(Icons.payments, '${parking.pricePerHour} ₸', 'в час'),
                      _Info(Icons.directions_car, '${parking.freeSlots}/${parking.totalSlots}', 'свободно'),
                      _Info(Icons.star, '${parking.rating}', 'рейтинг'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      // Маршрут + ожидание результата из pop
                      final slot = await Navigator.pushNamed(
                          context, '/slots', arguments: parking);
                      if (slot is int && context.mounted) {
                        // Анонимный маршрут + параметры через конструктор
                        final ok = await Navigator.push<bool>(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BookingScreen(parking: parking, slot: slot),
                          ),
                        );
                        if (ok == true && context.mounted) {
                          Navigator.popUntil(context, ModalRoute.withName('/home'));
                        }
                      }
                    },
                    child: const Text('Выбрать место'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _Info(this.icon, this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Icon(icon, color: Colors.blue.shade700, size: 30),
      const SizedBox(height: 4),
      Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Text(label, style: const TextStyle(color: Colors.grey)),
    ]);
  }
}