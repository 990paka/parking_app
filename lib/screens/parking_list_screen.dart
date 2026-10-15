import 'package:flutter/material.dart';

import '../models.dart';

// StatelessWidget
class ParkingListScreen extends StatelessWidget {
  const ParkingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: parkings.length,
      itemBuilder: (context, i) {
        final p = parkings[i];
        return GestureDetector(
          // Именованный маршрут + arguments
          onTap: () => Navigator.pushNamed(context, '/detail', arguments: p),
          child: ParkingCard(parking: p),
        );
      },
    );
  }
}

class ParkingCard extends StatelessWidget {
  final Parking parking;
  const ParkingCard({super.key, required this.parking});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.white, Color(0xFFE3EEFB)],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.blue.shade100),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 90),
                child: Text(parking.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 6),
              Row(children: [
                const Icon(Icons.place, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(parking.address),
              ]),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${parking.pricePerHour} ₸/час',
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  Row(children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    Text(' ${parking.rating}'),
                  ]),
                ],
              ),
            ],
          ),
          // Бейдж со свободными местами
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: parking.freeSlots > 5 ? Colors.green : Colors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text('${parking.freeSlots} мест',
                  style: const TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }
}