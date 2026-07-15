import 'package:priorise/l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:priorise/core/tokens/app_colors.dart';
import 'package:priorise/core/tokens/app_spacing.dart';
import 'package:priorise/core/tokens/app_typography.dart';
import 'package:priorise/features/shell/presentation/shell_cubit.dart';
import 'package:priorise/shared/widgets/page_header.dart';

import '../today_cubit.dart';
import '../../../settings/presentation/settings_screen.dart';
import '../../../mission/presentation/mission_screen.dart';
import '../../../../shared/utils/slide_up_route.dart';

import '../../../plan/presentation/plan_screen.dart';
import '../../../plan/presentation/plan_cubit.dart';
import '../../../../core/di/injection.dart';

class TodayHeader extends StatelessWidget {
  const TodayHeader({super.key, required this.state, required this.hPad});

  final TodayLoaded state;
  final double hPad;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dayLabel = _formatDate(now);

    return PageHeader(
      eyebrow: dayLabel,
      title: AppLocalizations.of(context)!.hello,
      horizontalPadding: hPad,
      trailing: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.push(
            context,
            SlideUpRoute<String>(page: const SettingsPage()),
          );
        },
        child: Icon(Icons.settings_outlined, color: context.cTextSecondary, size: 24),
      ),
    );
  }

  String _formatDate(DateTime d) {
    const jours = [
      'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'
    ];
    const mois = [
      'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
      'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'
    ];
    return '${jours[d.weekday - 1]} ${d.day} ${mois[d.month - 1]}';
  }
}

class TodayMissionLink extends StatelessWidget {
  const TodayMissionLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            SlideUpRoute(page: const MissionScreen()),
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.flag_rounded, // Assuming similar to the flag icon
              size: 16,
              color: context.cTextTertiary,
            ),
            const SizedBox(width: 8),
            Text(
              'Voir ma mission',
              style: AppTypography.inter(
                size: 13.5,
                color: context.cTextTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TodayRitualBanner extends StatelessWidget {
  const TodayRitualBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.push<String>(
            context,
            SlideUpRoute<String>(
              page: BlocProvider(
                create: (_) => PlanCubit(
                  getAllRoles: getIt(),
                  getTasks: getIt(),
                  addTask: getIt(),
                  updateTask: getIt(),
                  deleteTask: getIt(),
                )..loadPlan(),
                child: const PlanScreen(),
              ),
            ),
          ).then((result) {
            if (result == 'goto_matrix' && context.mounted) {
              context.read<ShellCubit>().selectTab(2);
            }
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            color: context.cSageDim,
            borderRadius: BorderRadius.circular(AppSpacing.radiusM),
            border: Border.all(
              color: context.cSage.withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: context.cSurface,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.calendar_month_rounded,
                  size: 16,
                  color: context.cSage,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.weekNotPlanned,
                      style: AppTypography.inter(
                        size: 12.5,
                        weight: FontWeight.w600,
                        color: context.cTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      AppLocalizations.of(context)!.weekPlanningSub,
                      style: AppTypography.inter(
                        size: 10.5,
                        color: context.cTextTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.chevron_right_rounded,
                size: 15,
                color: context.cTextTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TodaySectionTitle extends StatelessWidget {
  const TodaySectionTitle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: AppTypography.mono(
        size: 11,
        weight: FontWeight.w500,
        color: context.cTextTertiary,
        letterSpacing: 11 * 0.12, // 0.12em
      ),
    );
  }
}