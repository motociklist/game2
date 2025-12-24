import 'package:flutter/material.dart';
import '../game/game_controller.dart';
import '../game/game_constants.dart';
import '../widgets/background_clouds.dart';
import '../widgets/airplane_widget.dart';
import '../widgets/obstacle_widget.dart';
import '../widgets/score_display.dart';
import '../widgets/control_button.dart';
import '../widgets/pause_button.dart';
import '../widgets/game_start_overlay.dart';
import '../widgets/pause_overlay.dart';
import '../widgets/game_over_overlay.dart';
import '../widgets/game_won_overlay.dart';

/// Игровой экран
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final GameController gameController;

  @override
  void initState() {
    super.initState();
    gameController = GameController(
      onStateChanged: () {
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    gameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameController.jump,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.lightBlue.shade200, Colors.blue.shade100],
            ),
          ),
          child: Stack(
            children: [
              // Облака на фоне
              const BackgroundClouds(),

              // Препятствия
              ...gameController.obstacles.map(
                (obstacle) => ObstacleWidget(obstacle: obstacle),
              ),

              // Самолет
              AirplaneWidget(
                airplaneY: gameController.airplaneY,
                airplaneVelocity: gameController.airplaneVelocity,
              ),

              // Счет
              ScoreDisplay(
                score: gameController.score,
                winScore: GameConstants.winScore,
              ),

              // Кнопка управления
              if (gameController.gameStarted &&
                  !gameController.gameOver &&
                  !gameController.gameWon)
                ControlButton(
                  onTap: gameController.jump,
                  isPaused: gameController.isPaused,
                ),

              // Экран начала игры
              if (!gameController.gameStarted)
                const GameStartOverlay(),

              // Экран паузы
              if (gameController.isPaused &&
                  gameController.gameStarted &&
                  !gameController.gameOver &&
                  !gameController.gameWon)
                PauseOverlay(onTap: gameController.togglePause),

              // Кнопка паузы
              if (gameController.gameStarted &&
                  !gameController.gameOver &&
                  !gameController.gameWon)
                PauseButton(
                  onTap: gameController.togglePause,
                  isPaused: gameController.isPaused,
                ),

              // Экран проигрыша
              if (gameController.gameOver)
                GameOverOverlay(
                  score: gameController.score,
                  onPlayAgain: gameController.resetGame,
                  onMainMenu: () => Navigator.pop(context),
                ),

              // Экран победы
              if (gameController.gameWon)
                GameWonOverlay(
                  score: gameController.score,
                  onPlayAgain: gameController.resetGame,
                  onMainMenu: () => Navigator.pop(context),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

