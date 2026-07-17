// today_screen.dart — Écran Aujourd'hui.
//
// Rewritten to match the HTML mockup exactly:
//   - Fixed header (not scrollable) with bottom border
//   - Scrollable content: role chips, focus card, task list card
//   - FAB overlay with brass background
//
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/tokens/app_colors.dart';
import '../../../core/tokens/app_spacing.dart';
import '../../../core/tokens/app_typography.dart';
import 'package:priorise/l10n/app_localizations.dart';

import 'today_cubit.dart';
import 'widgets/today_role_chips.dart';
import 'widgets/today_header.dart';
import 'widgets/today_focus_card.dart';
import 'widgets/today_task_list.dart';
import 'widgets/today_fab.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _TodayView();
  }
}

class _TodayView extends StatelessWidget {
  const _TodayView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.cSurface,
      floatingActionButton: BlocBuilder<TodayCubit, TodayState>(
        builder: (context, state) {
          if (state is TodayLoaded) {
            return const TodayFab();
          }
          return const SizedBox.shrink();
        },
      ),
      body: BlocBuilder<TodayCubit, TodayState>(
        builder: (context, state) {
          return switch (state) {
            TodayLoading() => const _LoadingView(),
            TodayError(:final message) => _ErrorView(message: message),
            TodayLoaded() => _TodayBody(state: state),
          };
        },
      ),
    );
  }
}

// ── Main body with fixed header + scrollable content + FAB ─────────────────

class _TodayBody extends StatelessWidget {
  const _TodayBody({required this.state});

  final TodayLoaded state;

  @override
  Widget build(BuildContext context) {
    final hPad = AppSpacing.screenPaddingH(context);

    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: AppSpacing.xxl,
                bottom: AppSpacing.xxxxl + 64, // space for FAB
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mission link
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    child: const TodayMissionLink(),
                  ),
                  
                  // Ritual Banner (only if week is NOT planned)
                  if (!state.tasks.any((t) => t.important && !t.urgent))
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: hPad),
                      child: const TodayRitualBanner(),
                    ),

                  // Section title: "Vos objectifs de la semaine"
                  Padding(
                    padding: EdgeInsets.fromLTRB(hPad, AppSpacing.xxl, hPad, AppSpacing.m),
                    child: TodaySectionTitle(text: l10n.weeklyStones.toUpperCase()),
                  ),

                  // Role scroll
                  TodayRoleChipsRow(state: state, hPad: hPad),

                  // Section title: "Votre priorité, aujourd'hui"
                  Padding(
                    padding: EdgeInsets.fromLTRB(hPad, AppSpacing.xxl, hPad, AppSpacing.m),
                    child: TodaySectionTitle(text: l10n.todayPriority.toUpperCase()),
                  ),

                  // Focus card
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    child: TodayFocusCard(state: state),
                  ),

                  // Section title: "Le reste de la semaine"
                  Padding(
                    padding: EdgeInsets.fromLTRB(hPad, AppSpacing.xxl, hPad, AppSpacing.m),
                    child: TodaySectionTitle(text: l10n.restOfWeek.toUpperCase()),
                  ),

                  // Task list
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    child: TodayTaskCardContainer(state: state),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── États de chargement / erreur ───────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: context.cBrass,
        strokeWidth: 2,
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPaddingH(context)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.somethingWentWrong,
              style: AppTypography.displaySmall(
                  color: context.cTextPrimary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.m),
            Text(
              message,
              style: AppTypography.bodyMedium(
                  color: context.cTextSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

