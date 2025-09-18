import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final double mass; // Масса планеты (M)
  final double radius; // Радиус планеты (R)

  const SecondScreen({
    super.key,
    required this.mass,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    const double G = 6.67430e-11; // Гравитационная постоянная
    double g = G * mass / (radius * radius); // Формула ускорения свободного падения

    return Scaffold(
      appBar: AppBar(
        title: const Text('Результат'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Ускорение свободного падения: $g м/с²',
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Вернуться к вводу данных'),
            ),
          ],
        ),
      ),
    );
  }
}
