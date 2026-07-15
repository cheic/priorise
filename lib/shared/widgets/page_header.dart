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
    this.trailing,
    this.showBackButton = false,
  });

  final String eyebrow;
  final String title;
  final double? horizontalPadding;
  final Widget? trailing;
  final bool showBackButton;

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
          Row(
            children: [
              if (showBackButton && Navigator.canPop(context))
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, bottom: 2.0),
                    child: Icon(Icons.arrow_back, color: context.cTextSecondary, size: 16),
                  ),
                ),
              Text(
                eyebrow.toUpperCase(),
                style: AppTypography.mono(
                  size: 10,
                  color: context.cBrass,
                  letterSpacing: 10 * 0.14,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: AppTypography.fraunces(
                  size: 23,
                  weight: 560,
                  color: context.cTextPrimary,
                  height: 1.15,
                ),
              ),
              ?trailing,
            ],
          ),
        ],
      ),
    );
  }
}
