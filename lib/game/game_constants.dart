/// Константы игры
class GameConstants {
  // Физика самолета
  static const double initialAirplaneY = 0.5;
  static const double gravity = 0.0005;
  static const double jumpStrength = -0.0075;
  static const double minAirplaneY = 0.1;
  static const double maxAirplaneY = 0.9;
  static const double airplaneRotationMultiplier = 2.0;
  static const double maxRotationAngle = 0.5;
  static const double airplaneBaseRotation =
      1.5708; // 90 градусов (π/2) - самолет направлен вниз

  // Препятствия
  static const double obstacleSpeed = 0.005;
  static const double obstacleSpawnInterval = 2.0;
  static const double obstacleWidth = 0.1;
  static const double obstacleGapSize = 0.3;
  static const double obstacleSpawnX = 1.1;
  static const double obstacleRemoveX = -0.1;
  static const double obstaclePassedX = 0.1;

  // Размеры самолета
  static const double airplaneSize = 60.0;
  static const double airplaneOffsetX = 0.1;
  static const double airplaneOffsetY = 30.0;
  static const double airplaneHitboxWidth = 0.1;
  static const double airplaneHitboxHeight = 0.1;
  static const double airplaneHitboxOffsetY = 0.05;

  // Игровые параметры
  static const int winScore = 5;
  static const int gameUpdateIntervalMs = 16;
  static const double frameTime = 0.016;

  // Цвета препятствий
  static const int obstacleColorPrimary = 0xFF388E3C; // Colors.green.shade700
  static const int obstacleColorBorder = 0xFF1B5E20; // Colors.green.shade900
  static const double obstacleBorderWidth = 3.0;
}
