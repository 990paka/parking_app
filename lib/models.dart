import 'package:flutter/foundation.dart';

class Parking {
  final String name;
  final String address;
  final int pricePerHour;
  final int totalSlots;
  final int freeSlots;
  final double rating;

  const Parking({
    required this.name,
    required this.address,
    required this.pricePerHour,
    required this.totalSlots,
    required this.freeSlots,
    required this.rating,
  });
}

class Booking {
  final Parking parking;
  final int slot;
  final int hours;

  Booking({required this.parking, required this.slot, required this.hours});

  int get total => parking.pricePerHour * hours;
}

const List<Parking> parkings = [
  Parking(name: 'Центральная парковка', address: 'ул. Абая, 10', pricePerHour: 300, totalSlots: 32, freeSlots: 12, rating: 4.7),
  Parking(name: 'ТРЦ Mega', address: 'пр. Розыбакиева, 247', pricePerHour: 200, totalSlots: 40, freeSlots: 25, rating: 4.5),
  Parking(name: 'Бизнес-центр Нурлы Тау', address: 'пр. Аль-Фараби, 77', pricePerHour: 400, totalSlots: 24, freeSlots: 3, rating: 4.8),
  Parking(name: 'Аэропорт', address: 'ул. Майлина, 2', pricePerHour: 500, totalSlots: 48, freeSlots: 30, rating: 4.3),
  Parking(name: 'Вокзал Алматы-2', address: 'ул. Саина, 1', pricePerHour: 150, totalSlots: 28, freeSlots: 9, rating: 4.1),
];

/// Список бронирований (общий для всех экранов)
final ValueNotifier<List<Booking>> bookings = ValueNotifier<List<Booking>>([]);