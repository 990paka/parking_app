import 'package:flutter/material.dart';

import '../models.dart';

class BookingScreen extends StatefulWidget {
  final Parking parking;
  final int slot;
  const BookingScreen({super.key, required this.parking, required this.slot});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _hours = 1;

  @override
  Widget build(BuildContext context) {
    final p = widget.parking;
    return Scaffold(
      appBar: AppBar(title: const Text('Бронирование')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(p.name, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Место № ${widget.slot}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Часов:', style: TextStyle(fontSize: 18)),
                  Row(children: [
                    IconButton(
                      onPressed: _hours > 1 ? () => setState(() => _hours--) : null,
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text('$_hours', style: const TextStyle(fontSize: 22)),
                    IconButton(
                      onPressed: _hours < 24 ? () => setState(() => _hours++) : null,
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ]),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text('Итого: ${p.pricePerHour * _hours} ₸',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                bookings.value = [
                  ...bookings.value,
                  Booking(parking: p, slot: widget.slot, hours: _hours),
                ];
                Navigator.pop(context, true);
              },
              child: const Text('Забронировать'),
            ),
          ],
        ),
      ),
    );
  }
}