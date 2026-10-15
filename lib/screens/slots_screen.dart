import 'dart:math';

import 'package:flutter/material.dart';

import '../models.dart';

class SlotsScreen extends StatefulWidget {
  final Parking parking; // параметр через конструктор
  const SlotsScreen({super.key, required this.parking});

  @override
  State<SlotsScreen> createState() => _SlotsScreenState();
}

class _SlotsScreenState extends State<SlotsScreen> {
  late final Set<int> _occupied;
  int? _selected;

  @override
  void initState() {
    super.initState();
    final p = widget.parking;
    final order = List.generate(p.totalSlots, (i) => i)..shuffle(Random(p.totalSlots));
    _occupied = order.take(p.totalSlots - p.freeSlots).toSet();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.parking;
    return Scaffold(
      appBar: AppBar(title: Text(p.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _Legend(Colors.green, 'Свободно'),
                _Legend(Colors.red, 'Занято'),
                _Legend(Colors.blue, 'Выбрано'),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: p.totalSlots,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, i) {
                  final busy = _occupied.contains(i);
                  final chosen = _selected == i;
                  return GestureDetector(
                    onTap: busy ? null : () => setState(() => _selected = i),
                    child: Container(
                      decoration: BoxDecoration(
                        color: busy ? Colors.red : (chosen ? Colors.blue : Colors.green),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: busy
                          ? const Icon(Icons.directions_car, color: Colors.white)
                          : Text('${i + 1}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _selected == null
                  ? null
                  // pop возвращает результат на предыдущий экран
                  : () => Navigator.pop(context, _selected! + 1),
              child: Text(_selected == null
                  ? 'Выберите место'
                  : 'Подтвердить место ${_selected! + 1}'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String text;
  const _Legend(this.color, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(width: 16, height: 16, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))),
      const SizedBox(width: 6),
      Text(text),
    ]);
  }
}