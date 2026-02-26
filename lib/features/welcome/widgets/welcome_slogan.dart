import 'package:flutter/material.dart';

import '../../../core/utils/constants/colors.dart';

class WelcomeSlogan extends StatelessWidget {
  const WelcomeSlogan({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Decorative divider ─────────────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _DividerDot(),
            const SizedBox(width: 8),
            Container(
              width: 40,
              height: 1,
              color:  DColors.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(width: 12),
            const Text(
              'Your money, your story',
              style: TextStyle(
                fontFamily: 'Georgia',
                fontSize: 17,
                fontStyle: FontStyle.italic,
                color: DColors.primary,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 40,
              height: 1,
              color: DColors.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(width: 8),
            _DividerDot(),
          ],
        ),

        const SizedBox(height: 16),

        // ── Sub-line ───────────────────────────────────────────────────────────
        const Text(
          'Track every rupee.\nLive every moment.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            height: 1.6,
            color: DColors.fBlack,
            letterSpacing: 0.1,
          ),
        ),
      ],
    );
  }
}

class _DividerDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5,
      height: 5,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: DColors.primary,
      ),
    );
  }
}