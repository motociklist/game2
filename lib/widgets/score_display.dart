import 'package:flutter/material.dart';

/// Виджет отображения счета
class ScoreDisplay extends StatelessWidget {
  final int score;
  final int winScore;

  const ScoreDisplay({
    super.key,
    required this.score,
    required this.winScore,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 0,
      right: 0,
      child: Center(
        child: Text(
          'Очки: $score / $winScore',
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [Shadow(blurRadius: 10, color: Colors.black)],
          ),
        ),
      ),
    );
  }
}

