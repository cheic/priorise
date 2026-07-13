import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:priorise/core/models/enums.dart';
import 'package:priorise/core/models/role_model.dart';
import 'package:priorise/core/models/weekly_plan_model.dart';
import 'package:priorise/core/tokens/app_colors.dart';
import 'package:priorise/core/tokens/app_spacing.dart';
import 'package:priorise/core/tokens/app_typography.dart';

import '../today_cubit.dart';

class TodayFocusCard extends StatelessWidget {
  const TodayFocusCard({required this.state});

  final TodayLoaded state;

  @override
  Widget build(BuildContext context) {
    // Find the first undone strategic task as the focus task
    final focusTask = state.tasks
        .where((t) => t.important && !t.urgent && !t.done)
        .toList();

    if (focusTask.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: context.cSurfaceRaised,
          borderRadius: BorderRadius.circular(AppSpacing.radiusM),
          border: Border.all(color: context.cBorder),
        ),
        child: Center(
          child: Text(
            "Aucune priorité stratégique (Important & Non Urgent) définie pour aujourd'hui.",
            style: AppTypography.inter(
              size: 13,
              color: context.cTextTertiary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final task = focusTask.first;
    final role = state.roles.firstWhere(
      (r) => r.id == task.roleId,
      orElse: () => LifeRole()..name = '',
    );
    final weeklyBigRock = state.currentPlan?.bigRocks
            .firstWhere((r) => r.roleId == role.id, orElse: () => BigRock())
            .text;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.l),
      decoration: BoxDecoration(
        // Border: 1px solid rgba(184,147,91,0.4) (brass at 40%)
        border: Border.all(
          color: context.cBrass.withAlpha(102), // 0.4 * 255 ≈ 102
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusM),
        // Background: gradient with brassGlow
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.cBrassGlow,
            context.cSurface,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tag: mono 9.5px uppercase, brassBright text on brassGlow bg
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: context.cBrassGlow,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              'Stratégique · ${role.name}'.toUpperCase(),
              style: AppTypography.mono(
                size: 9.5,
                weight: FontWeight.w500,
                color: context.cBrassBright,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.m),
          // h3: Fraunces 500, 16.5px — focus task title
          Text(
            task.title,
            style: AppTypography.fraunces(
              size: 16.5,
              weight: 500,
              color: context.cTextPrimary,
              height: 1.3,
            ),
          ),
          // p: 12.5px, text-secondary — description (use weeklyBigRock if available)
          if (weeklyBigRock != null && weeklyBigRock.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              weeklyBigRock,
              style: AppTypography.inter(
                size: 12.5,
                color: context.cTextSecondary,
                height: 1.45,
              ),
            ),
          ],
        ],
      ),
    );
  }
}