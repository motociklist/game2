import 'package:flutter/material.dart';

/// Виджет облаков на фоне
class BackgroundClouds extends StatelessWidget {
  const BackgroundClouds({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(5, (index) {
        return Positioned(
          left: (index * 200.0) % MediaQuery.of(context).size.width,
          top: (index * 100.0) % MediaQuery.of(context).size.height,
          child: Opacity(
            opacity: 0.3,
            child: Icon(
              Icons.cloud,
              size: 80 + (index * 20),
              color: Colors.white,
            ),
          ),
        );
      }),
    );
  }
}

