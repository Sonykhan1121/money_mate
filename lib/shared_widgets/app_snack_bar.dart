import 'package:flutter/material.dart';

enum AppSnackbarType { success, error, info }

class AppSnackbar extends StatelessWidget {
  final String message;
  final AppSnackbarType type;

  const AppSnackbar({
    super.key,
    required this.message,
    required this.type,
  });

  // ─── Config per type ────────────────────────────────────────────────────────

  _SnackbarStyle get _style {
    switch (type) {
      case AppSnackbarType.success:
        return _SnackbarStyle(
          icon: Icons.check_circle_rounded,
          iconColor: const Color(0xFF22C55E),
          accentColor: const Color(0xFF22C55E),
          label: 'Success',
        );
      case AppSnackbarType.error:
        return _SnackbarStyle(
          icon: Icons.cancel_rounded,
          iconColor: const Color(0xFFEF4444),
          accentColor: const Color(0xFFEF4444),
          label: 'Error',
        );
      case AppSnackbarType.info:
        return _SnackbarStyle(
          icon: Icons.info_rounded,
          iconColor: const Color(0xFF3B82F6),
          accentColor: const Color(0xFF3B82F6),
          label: 'Info',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = _style;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF1E1E2E) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1A1A2E);
    final subTextColor = isDark ? Colors.white60 : Colors.black45;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: s.accentColor.withOpacity(0.35), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: s.accentColor.withOpacity(0.15),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // ── Left accent bar ──
          Container(
            width: 3.5,
            height: 36,
            decoration: BoxDecoration(
              color: s.accentColor,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          const SizedBox(width: 12),

          // ── Icon ──
          Icon(s.icon, color: s.iconColor, size: 26),
          const SizedBox(width: 10),

          // ── Label + message ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  s.label,
                  style: TextStyle(
                    color: s.accentColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  message,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Internal style model ─────────────────────────────────────────────────────

class _SnackbarStyle {
  final IconData icon;
  final Color iconColor;
  final Color accentColor;
  final String label;

  const _SnackbarStyle({
    required this.icon,
    required this.iconColor,
    required this.accentColor,
    required this.label,
  });
}