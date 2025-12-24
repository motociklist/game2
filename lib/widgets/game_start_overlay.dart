import 'package:flutter/material.dart';

/// Оверлей начала игры
class GameStartOverlay extends StatelessWidget {
  const GameStartOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.flight, size: 80, color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              'Нажмите, чтобы начать',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Используйте кнопку внизу или\nнажмите на экран для управления',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

