import 'package:flutter/material.dart';
import '../../core/tokens/app_colors.dart';
import '../../core/tokens/app_spacing.dart';
import '../../core/tokens/app_typography.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.horizontalPadding,
  });

  final String eyebrow;
  final String title;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final screenClass = AppSpacing.screenClass(context);
    final defaultPad =
        screenClass == ScreenClass.expanded ? AppSpacing.xxxxl : AppSpacing.xxl;
    final hPad = horizontalPadding ?? defaultPad;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(hPad, AppSpacing.xxl, hPad, AppSpacing.m),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: context.cBorder)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            eyebrow.toUpperCase(),
            style: AppTypography.mono(
              size: 10,
              color: context.cBrass,
              letterSpacing: 10 * 0.14,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            title,
            style: AppTypography.fraunces(
              size: 23,
              weight: 560,
              color: context.cTextPrimary,
              height: 1.15,
            ),
          ),
        ],
      ),
    );
  }
}
