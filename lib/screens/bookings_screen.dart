import 'package:flutter/material.dart';

import '../models.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Booking>>(
      valueListenable: bookings,
      builder: (context, list, _) {
        if (list.isEmpty) {
          return const Center(child: Text('Броней пока нет'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: list.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, i) {
            final b = list[i];
            return Card(
              child: ListTile(
                leading: CircleAvatar(child: Text('${b.slot}')),
                title: Text(b.parking.name),
                subtitle: Text('${b.hours} ч • ${b.total} ₸'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    bookings.value = List.of(list)..removeAt(i);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}