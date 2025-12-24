import 'package:flutter/material.dart';
import '../game/game_constants.dart';

/// Виджет самолета
class AirplaneWidget extends StatelessWidget {
  final double airplaneY;
  final double airplaneVelocity;

  const AirplaneWidget({
    super.key,
    required this.airplaneY,
    required this.airplaneVelocity,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: GameConstants.airplaneOffsetX * MediaQuery.of(context).size.width,
      top: airplaneY * MediaQuery.of(context).size.height -
          GameConstants.airplaneOffsetY,
      child: Transform.rotate(
        angle: (airplaneVelocity * GameConstants.airplaneRotationMultiplier)
            .clamp(-GameConstants.maxRotationAngle,
                GameConstants.maxRotationAngle),
        child: const Icon(
          Icons.flight,
          size: GameConstants.airplaneSize,
          color: Colors.white,
        ),
      ),
    );
  }
}

