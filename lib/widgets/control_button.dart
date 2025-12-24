import 'package:flutter/material.dart';

/// Кнопка управления самолетом
class ControlButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isPaused;

  const ControlButton({
    super.key,
    required this.onTap,
    required this.isPaused,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 0,
      right: 0,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isPaused ? null : onTap,
            borderRadius: BorderRadius.circular(50),
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: isPaused ? Colors.grey.shade600 : Colors.orange.shade400,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_upward,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

