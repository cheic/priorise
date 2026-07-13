import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:priorise/core/models/enums.dart';
import 'package:priorise/core/models/role_model.dart';
import 'package:priorise/core/models/task_model.dart';
import 'package:priorise/core/tokens/app_colors.dart';
import 'package:priorise/core/tokens/app_spacing.dart';
import 'package:priorise/core/tokens/app_typography.dart';

import '../today_cubit.dart';

class TodayTaskCardContainer extends StatelessWidget {
  const TodayTaskCardContainer({required this.state});

  final TodayLoaded state;

  @override
  Widget build(BuildContext context) {
    // All tasks except the focus task (first undone strategic)
    final allTasks = state.visibleTasks;
    final focusTaskId = state.tasks
        .where((t) => t.important && !t.urgent && !t.done)
        .map((t) => t.id)
        .firstOrNull;

    final remainingTasks =
        allTasks.where((t) => t.id != focusTaskId).toList();

    if (remainingTasks.isEmpty) {
      final hasTasks = state.tasks.isNotEmpty;
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.xxl),
        decoration: BoxDecoration(
          color: context.cSurfaceRaised,
          borderRadius: BorderRadius.circular(AppSpacing.radiusM),
          border: Border.all(color: context.cBorder),
        ),
        child: Center(
          child: Text(
            hasTasks 
              ? 'Toutes les autres tâches sont accomplies !' 
              : 'Aucune autre tâche planifiée pour le moment.',
            style: AppTypography.inter(
                size: 13,
                color: context.cTextTertiary),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    // All tasks inside ONE card container
    return Container(
      decoration: BoxDecoration(
        color: context.cSurfaceRaised,
        borderRadius: BorderRadius.circular(AppSpacing.radiusM),
        border: Border.all(color: context.cBorder),
      ),
      padding: const EdgeInsets.all(AppSpacing.l),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(remainingTasks.length, (i) {
          final task = remainingTasks[i];
          final isLast = i == remainingTasks.length - 1;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TodayTaskRow(task: task, state: state),
              if (!isLast)
                Divider(
                  color: context.cBorder,
                  height: AppSpacing.xxl,
                  thickness: 1,
                ),
            ],
          );
        }),
      ),
    );
  }
}

class TodayTaskRow extends StatelessWidget {
  const TodayTaskRow({required this.task, required this.state});

  final Task task;
  final TodayLoaded state;

  @override
  Widget build(BuildContext context) {
    final role = state.roles.firstWhere(
      (r) => r.id == task.roleId,
      orElse: () => LifeRole()..name = '',
    );

    final dotColor = role.accent.color(context);

    return Dismissible(
      key: ValueKey(task.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        context.read<TodayCubit>().deleteTask(task.id);
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSpacing.l),
        color: context.cError.withAlpha(50),
        child: Icon(Icons.delete_outline, color: context.cError),
      ),
      child: GestureDetector(
        onTap: () => context.read<TodayCubit>().toggleTask(task.id),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Checkbox ROUND: 19px, border-radius 50%, 1.5px
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: TodayRoundCheckbox(isDone: task.done),
            ),
            const SizedBox(width: AppSpacing.m),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Task title: 13.5px
                  Text(
                    task.title,
                    style: AppTypography.inter(
                      size: 13.5,
                      weight: FontWeight.w500,
                      color: task.done
                          ? context.cTextTertiary
                          : context.cTextPrimary,
                      height: 1.4,
                      decoration: task.done
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  const SizedBox(height: 2),
                  // Task role label with colored dot
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: task.done ? dotColor.withAlpha(128) : dotColor,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        role.name.toUpperCase(),
                        style: AppTypography.mono(
                          size: 10,
                          color: context.cTextTertiary,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

class TodayRoundCheckbox extends StatelessWidget {
  const TodayRoundCheckbox({required this.isDone});

  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 19,
      height: 19,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDone ? context.cSage : Colors.transparent,
        border: Border.all(
          color: isDone ? context.cSage : context.cBorderStrong,
          width: 1.5,
        ),
      ),
      child: isDone
          ? Icon(Icons.check, color: context.cInk, size: 12)
          : null,
    );
  }
}