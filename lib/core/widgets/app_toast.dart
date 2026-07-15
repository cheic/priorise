import 'package:flutter/material.dart';
import '../tokens/app_colors.dart';
import '../tokens/app_typography.dart';

class AppToast {
  static void show(BuildContext context, String message, {IconData? icon, Color? iconColor}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: iconColor ?? context.cTextPrimary, size: 16),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                message,
                style: AppTypography.inter(
                  size: 13,
                  weight: FontWeight.w500,
                  color: context.cTextPrimary,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: context.cSurfaceRaised,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
          side: BorderSide(color: context.cBorderStrong),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
        elevation: 10,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  static void showSuccess(BuildContext context, String message) {
    show(context, message, icon: Icons.check, iconColor: context.cSage);
  }

  static void showError(BuildContext context, String message) {
    show(context, message, icon: Icons.error_outline, iconColor: context.cError);
  }

  static void showInfo(BuildContext context, String message) {
    show(context, message, icon: Icons.info_outline, iconColor: context.cTextTertiary);
  }
}
