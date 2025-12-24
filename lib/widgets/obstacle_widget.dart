import 'package:flutter/material.dart';
import '../models/obstacle.dart';
import '../game/game_constants.dart';

/// Виджет препятствия
class ObstacleWidget extends StatelessWidget {
  final Obstacle obstacle;

  const ObstacleWidget({
    super.key,
    required this.obstacle,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // Верхнее препятствие
        Positioned(
          left: obstacle.x * screenWidth,
          top: 0,
          width: GameConstants.obstacleWidth * screenWidth,
          height: obstacle.topHeight * screenHeight,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(GameConstants.obstacleColorPrimary),
              border: Border.all(
                color: const Color(GameConstants.obstacleColorBorder),
                width: GameConstants.obstacleBorderWidth,
              ),
            ),
          ),
        ),
        // Нижнее препятствие
        Positioned(
          left: obstacle.x * screenWidth,
          top: (1.0 - obstacle.bottomHeight) * screenHeight,
          width: GameConstants.obstacleWidth * screenWidth,
          height: obstacle.bottomHeight * screenHeight,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(GameConstants.obstacleColorPrimary),
              border: Border.all(
                color: const Color(GameConstants.obstacleColorBorder),
                width: GameConstants.obstacleBorderWidth,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

