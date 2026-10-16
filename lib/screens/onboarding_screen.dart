import 'package:flutter/material.dart';

// StatefulWidget: хранит текущую страницу
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  final List<Map<String, String>> _pages = const [
    {'title': 'Найдите парковку', 'text': 'Список парковок рядом с вами с ценами и свободными местами'},
    {'title': 'Выберите место', 'text': 'Схема парковки: выберите свободное место одним касанием'},
    {'title': 'Забронируйте', 'text': 'Укажите время и оплатите — место будет вас ждать'},
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _page == _pages.length - 1;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/images/parking.png'),
                      ),
                      const SizedBox(height: 32),
                      Text(_pages[i]['title']!,
                          style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 12),
                      Text(_pages[i]['text']!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.all(4),
                  width: i == _page ? 24 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: i == _page ? Colors.blue.shade800 : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: ElevatedButton(
                onPressed: () {
                  if (isLast) {
                    // Переход на регистрацию без возможности вернуться назад
                    Navigator.pushReplacementNamed(context, '/register');
                  } else {
                    _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  }
                },
                child: Text(isLast ? 'Начать' : 'Далее'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}