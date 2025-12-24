/// Модель препятствия в игре
class Obstacle {
  double x;
  double topHeight;
  double bottomHeight;
  bool passed = false;

  Obstacle({
    required this.x,
    required this.topHeight,
    required this.bottomHeight,
  });
}

