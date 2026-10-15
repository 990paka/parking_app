import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 140,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                ),
              ),
            ),
            Positioned(
              bottom: -45,
              left: 0,
              right: 0,
              child: Center(
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 44,
                    backgroundColor: Colors.amber,
                    child: Icon(Icons.person, size: 50, color: Colors.blue.shade900),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 56),
        Text('Водитель', style: GoogleFonts.pacifico(fontSize: 28)),
        const SizedBox(height: 4),
        const Text('driver@example.com'),
        const SizedBox(height: 24),
        const ListTile(leading: Icon(Icons.directions_car), title: Text('Моё авто'), subtitle: Text('Toyota Camry • 777 AAA 02')),
        const ListTile(leading: Icon(Icons.credit_card), title: Text('Способ оплаты'), subtitle: Text('Visa •••• 4242')),
        const ListTile(leading: Icon(Icons.info_outline), title: Text('О приложении'), subtitle: Text('Версия 1.0.0')),
      ],
    );
  }
}