import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/obstacle.dart';
import 'game_constants.dart';

/// Контроллер игровой логики
class GameController {
  // Состояние самолета
  double airplaneY = GameConstants.initialAirplaneY;
  double airplaneVelocity = 0.0;

  // Препятствия
  final List<Obstacle> obstacles = [];
  double obstacleSpawnTimer = 0.0;

  // Игровое состояние
  int score = 0;
  bool gameStarted = false;
  bool gameOver = false;
  bool gameWon = false;
  bool isPaused = false;

  Timer? gameTimer;
  final VoidCallback? onStateChanged;

  GameController({this.onStateChanged});

  /// Запуск игры
  void startGame() {
    gameStarted = true;
    gameOver = false;
    gameWon = false;
    score = 0;
    airplaneY = GameConstants.initialAirplaneY;
    airplaneVelocity = 0.0;
    obstacles.clear();
    obstacleSpawnTimer = 0.0;
    isPaused = false;

    gameTimer = Timer.periodic(
      const Duration(milliseconds: GameConstants.gameUpdateIntervalMs),
      (timer) {
        if (!gameOver && !gameWon && !isPaused) {
          updateGame();
        }
      },
    );

    onStateChanged?.call();
  }

  /// Обновление игрового состояния
  void updateGame() {
    // Физика самолета
    airplaneVelocity += GameConstants.gravity;
    airplaneY += airplaneVelocity;

    // Ограничения экрана
    if (airplaneY < GameConstants.minAirplaneY) {
      airplaneY = GameConstants.minAirplaneY;
      airplaneVelocity = 0;
    }
    if (airplaneY > GameConstants.maxAirplaneY) {
      airplaneY = GameConstants.maxAirplaneY;
      airplaneVelocity = 0;
    }

    // Спавн препятствий
    obstacleSpawnTimer += GameConstants.frameTime;
    if (obstacleSpawnTimer >= GameConstants.obstacleSpawnInterval) {
      spawnObstacle();
      obstacleSpawnTimer = 0.0;
    }

    // Движение препятствий
    for (var obstacle in obstacles) {
      obstacle.x -= GameConstants.obstacleSpeed;
    }

    // Удаление препятствий за экраном
    obstacles.removeWhere(
      (obstacle) => obstacle.x < GameConstants.obstacleRemoveX,
    );

    // Проверка столкновений
    checkCollisions();

    // Увеличение счета
    for (var obstacle in obstacles) {
      if (!obstacle.passed && obstacle.x < GameConstants.obstaclePassedX) {
        obstacle.passed = true;
        score++;

        // Проверка победы
        if (score >= GameConstants.winScore) {
          gameWon = true;
          gameTimer?.cancel();
        }
      }
    }

    onStateChanged?.call();
  }

  /// Создание нового препятствия
  void spawnObstacle() {
    final random = Random();
    final gapPosition = random.nextDouble() *
        (1.0 - GameConstants.obstacleGapSize);

    obstacles.add(
      Obstacle(
        x: GameConstants.obstacleSpawnX,
        topHeight: gapPosition,
        bottomHeight: 1.0 - gapPosition - GameConstants.obstacleGapSize,
      ),
    );
  }

  /// Проверка столкновений
  void checkCollisions() {
    final airplaneRect = Rect.fromLTWH(
      GameConstants.airplaneOffsetX,
      airplaneY - GameConstants.airplaneHitboxOffsetY,
      GameConstants.airplaneHitboxWidth,
      GameConstants.airplaneHitboxHeight,
    );

    for (var obstacle in obstacles) {
      // Верхнее препятствие
      final topRect = Rect.fromLTWH(
        obstacle.x,
        0,
        GameConstants.obstacleWidth,
        obstacle.topHeight,
      );

      // Нижнее препятствие
      final bottomRect = Rect.fromLTWH(
        obstacle.x,
        1.0 - obstacle.bottomHeight,
        GameConstants.obstacleWidth,
        obstacle.bottomHeight,
      );

      if (airplaneRect.overlaps(topRect) || airplaneRect.overlaps(bottomRect)) {
        gameOver = true;
        gameTimer?.cancel();
        onStateChanged?.call();
        return;
      }
    }

    // Столкновение с границами экрана
    if (airplaneY <= GameConstants.minAirplaneY ||
        airplaneY >= GameConstants.maxAirplaneY) {
      gameOver = true;
      gameTimer?.cancel();
      onStateChanged?.call();
    }
  }

  /// Прыжок самолета
  void jump() {
    if (!gameStarted) {
      startGame();
    } else if (!gameOver && !gameWon && !isPaused) {
      airplaneVelocity = GameConstants.jumpStrength;
      onStateChanged?.call();
    }
  }

  /// Переключение паузы
  void togglePause() {
    if (gameStarted && !gameOver && !gameWon) {
      isPaused = !isPaused;
      onStateChanged?.call();
    }
  }

  /// Сброс игры
  void resetGame() {
    gameTimer?.cancel();
    gameStarted = false;
    gameOver = false;
    gameWon = false;
    isPaused = false;
    score = 0;
    airplaneY = GameConstants.initialAirplaneY;
    airplaneVelocity = 0.0;
    obstacles.clear();
    obstacleSpawnTimer = 0.0;
    onStateChanged?.call();
  }

  /// Освобождение ресурсов
  void dispose() {
    gameTimer?.cancel();
  }
}

