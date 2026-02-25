import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_mate/core/utils/extensions/provider_extension.dart';
import 'package:money_mate/features/profile/data/models/profile_model.dart';
import '../../../core/local/localData.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/utils/constants/colors.dart';

class WelcomeContinueButton extends StatelessWidget {
  final bool enabled;
  final String name;

  const WelcomeContinueButton({
    super.key,
    required this.enabled,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Main CTA ────────────────────────────────────────────────────────────
        AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: enabled ? 1.0 : 0.45,
          child: SizedBox(
            width: double.infinity,
            height: 54,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: enabled
                    ? const LinearGradient(
                  colors: [DColors.primary, DColors.primary],
                )
                    : const LinearGradient(
                  colors: [DColors.primary, DColors.primary],
                ),
                boxShadow: enabled
                    ? [
                  BoxShadow(
                    color: DColors.secondary.withOpacity(0.40),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ]
                    : [],
              ),
              child: ElevatedButton(
                onPressed: enabled ? () => _onContinue(context) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      enabled ? 'Continue as $name' : 'Enter your name',
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                    if (enabled) ...[
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // ── Footer note ─────────────────────────────────────────────────────────
        Text(
          'No account needed · 100% private',
          style: TextStyle(
            fontSize: 12,
            color: const Color(0xFF2D2417).withOpacity(0.35),
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  void _onContinue(BuildContext context) {
    LocalData.name = name;
    LocalData.firstTime = false;
    context.go(RouteNames.mainNavigation);
    ProfileModel profile = ProfileModel(
      name: LocalData.name,
    );
    context.profileProvider.saveProfile(profile);
  }
}