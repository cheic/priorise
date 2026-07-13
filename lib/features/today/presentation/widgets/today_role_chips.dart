import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:priorise/core/tokens/app_colors.dart';
import 'package:priorise/core/tokens/app_spacing.dart';
import 'package:priorise/core/tokens/app_typography.dart';
import 'package:priorise/shared/widgets/role_icons.dart';
import 'package:priorise/core/models/role_model.dart';

import '../today_cubit.dart';

class TodayRoleChipsRow extends StatelessWidget {
  const TodayRoleChipsRow({required this.state, required this.hPad});

  final TodayLoaded state;
  final double hPad;

  @override
  Widget build(BuildContext context) {
    if (state.roles.isEmpty) {
      return Container(
        height: 100,
        alignment: Alignment.center,
        child: Text(
          "Aucun rôle n'a encore été créé.",
          style: AppTypography.inter(
            size: 13,
            color: context.cTextTertiary,
          ),
        ),
      );
    }
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: hPad),
        itemCount: state.roles.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.s),
        itemBuilder: (context, i) =>
            TodayRoleChipCard(role: state.roles[i], state: state),
      ),
    );
  }
}
class TodayRoleChipCard extends StatelessWidget {
  const TodayRoleChipCard({super.key, required this.role, required this.state});

  final LifeRole role;
  final TodayLoaded state;

  @override
  Widget build(BuildContext context) {
    // Determine how many tasks are done for this role today
    final roleTasks = state.tasks.where((t) => t.roleId == role.id).toList();
    final doneCount = roleTasks.where((t) => t.done).length;
    final totalCount = roleTasks.length;
    // Show up to 5 dots
    final dotsCount = totalCount > 5 ? 5 : totalCount;

    return Container(
      width: 120,
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: context.cSurfaceRaised,
        borderRadius: BorderRadius.circular(AppSpacing.radiusS),
        border: Border.all(color: context.cBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(RoleIcons.getIcon(role.iconKey), size: 18, color: role.accent.color(context)),
          const Spacer(),
          Text(
            role.name,
            style: AppTypography.inter(
              size: 12.5,
              weight: FontWeight.w600,
              color: context.cTextPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (dotsCount > 0) ...[
            const SizedBox(height: AppSpacing.s),
            Row(
              children: List.generate(dotsCount, (index) {
                final isDone = index < doneCount;
              return Container(
                width: 5,
                height: 5,
                margin: const EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDone ? context.cSage : context.cBorderStrong,
                ),
              );
            }),
            ),
          ],
        ],
      ),
    );
  }
}
