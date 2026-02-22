import 'package:flutter/material.dart';

import '../../../core/utils/constants/colors.dart';

class WelcomeBackground extends StatelessWidget {
  const WelcomeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Top-right warm blob
        Positioned(
          top: -60,
          right: -60,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: DColors.primary.withOpacity(0.35),
            ),
          ),
        ),
        // Bottom-left cool blob
        Positioned(
          bottom: -80,
          left: -80,
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: DColors.primary.withOpacity(0.25),
            ),
          ),
        ),
        // Subtle center warmth
        Positioned(
          top: size.height * 0.4,
          right: -40,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:  DColors.primary.withOpacity(0.15),
            ),
          ),
        ),
      ],
    );
  }
}