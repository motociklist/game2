import 'package:flutter/material.dart';

/// Кнопка паузы
class PauseButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isPaused;

  const PauseButton({
    super.key,
    required this.onTap,
    required this.isPaused,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              isPaused ? Icons.play_arrow : Icons.pause,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}

