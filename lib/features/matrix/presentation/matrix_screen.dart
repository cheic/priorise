import 'package:priorise/l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/tokens/app_colors.dart';
import '../../../core/tokens/app_spacing.dart';
import '../../../core/tokens/app_typography.dart';
import '../../../shared/painters/compass_painter.dart';
import '../../roles/presentation/roles_cubit.dart';
import '../../../core/models/task_model.dart';
import 'dart:math';
import 'matrix_cubit.dart';

class MatrixPage extends StatelessWidget {
  const MatrixPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = AppSpacing.screenPaddingH(context);

    return BlocBuilder<RolesCubit, RolesState>(
      builder: (context, rolesState) {
        return BlocBuilder<MatrixCubit, MatrixState>(
          builder: (context, matrixState) {
            return Center(
              child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 840),
                    child: ListView(
                      padding: EdgeInsets.fromLTRB(
                        hPad,
                        AppSpacing.xxl,
                        hPad,
                        AppSpacing.xxxxl,
                      ),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'VOTRE PRIORISE, CETTE SEMAINE',
                              style: AppTypography.mono(
                                size: 11,
                                color: context.cTextTertiary,
                                letterSpacing: 1.3,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    Widget buildItem(Color c, String title, String desc) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 8,
                                                height: 8,
                                                decoration: BoxDecoration(
                                                  color: c,
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: c.withValues(alpha: 0.4),
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                  title,
                                                  style: AppTypography.inter(
                                                    size: 14,
                                                    weight: FontWeight.w600,
                                                    color: context.cTextPrimary,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20),
                                            child: Text(
                                              desc,
                                              style: AppTypography.inter(
                                                size: 13,
                                                color: context.cTextSecondary,
                                              ).copyWith(height: 1.4),
                                            ),
                                          ),
                                        ],
                                      );
                                    }

                                    return Dialog(
                                      backgroundColor: context.cSurfaceRaised,
                                      surfaceTintColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(AppSpacing.radiusL),
                                        side: BorderSide(color: context.cBorder),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(24.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!.matrixInfoTitle,
                                                  style: AppTypography.fraunces(
                                                    size: 20,
                                                    weight: 600,
                                                    color: context.cTextPrimary,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Navigator.pop(context),
                                                  child: Icon(Icons.close, size: 20, color: context.cTextTertiary),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                                AppLocalizations.of(context)!.matrixInfoDesc,
                                                style: AppTypography.inter(
                                                size: 13,
                                                color: context.cTextSecondary,
                                              ).copyWith(height: 1.4),
                                            ),
                                            const SizedBox(height: 32),
                                            buildItem(
                                              context.cBrassBright,
                                              AppLocalizations.of(context)!.matrixInfoQ1Title,
                                              AppLocalizations.of(context)!.matrixInfoQ1Desc,
                                            ),
                                            const SizedBox(height: 20),
                                            buildItem(
                                              context.cBrass,
                                              AppLocalizations.of(context)!.matrixInfoQ2Title,
                                              AppLocalizations.of(context)!.matrixInfoQ2Desc,
                                            ),
                                            const SizedBox(height: 20),
                                            buildItem(
                                              context.cClay,
                                              AppLocalizations.of(context)!.matrixInfoQ3Title,
                                              AppLocalizations.of(context)!.matrixInfoQ3Desc,
                                            ),
                                            const SizedBox(height: 20),
                                            buildItem(
                                              context.cTextTertiary,
                                              AppLocalizations.of(context)!.matrixInfoQ4Title,
                                              AppLocalizations.of(context)!.matrixInfoQ4Desc,
                                            ),
                                            const SizedBox(height: 32),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: TextButton(
                                                onPressed: () => Navigator.pop(context),
                                                style: TextButton.styleFrom(
                                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                  backgroundColor: context.cBrassBright.withValues(alpha: 0.1),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                                                  ),
                                                ),
                                                child: Text(
                                                    AppLocalizations.of(context)!.understood,
                                                    style: AppTypography.inter(
                                                    size: 14,
                                                    weight: FontWeight.w600,
                                                    color: context.cBrassBright,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.info_outline,
                                  size: 18,
                                  color: context.cTextTertiary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Center(
                          child: SizedBox(
                            width: 380,
                            height: 380,
                            child: CustomPaint(
                              painter: CompassPainter(
                                isDark: Theme.of(context).brightness == Brightness.dark,
                                showGlow: true, 
                                strokeScaleFactor: 1.0,
                                tasks: _buildCompassTasks(matrixState, rolesState, context),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: _LegendItem(color: context.cClay, title: AppLocalizations.of(context)!.matrixLegendQ1Title, subtitle: AppLocalizations.of(context)!.matrixLegendQ1Desc)),
                                const SizedBox(width: 10),
                                Expanded(child: _LegendItem(color: context.cBrass, title: AppLocalizations.of(context)!.matrixLegendQ2Title, subtitle: AppLocalizations.of(context)!.matrixLegendQ2Desc)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: _LegendItem(color: context.cTextTertiary, title: AppLocalizations.of(context)!.matrixLegendQ3Title, subtitle: AppLocalizations.of(context)!.matrixLegendQ3Desc)),
                                const SizedBox(width: 10),
                                Expanded(child: _LegendItem(color: context.cSage, title: AppLocalizations.of(context)!.matrixLegendQ4Title, subtitle: AppLocalizations.of(context)!.matrixLegendQ4Desc)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
            );
          },
        );
      },
    );
  }

  List<CompassTask> _buildCompassTasks(MatrixState mState, RolesState rState, BuildContext context) {
    final cTasks = <CompassTask>[];
    
    Color getRoleColor(int roleId) {
      final role = rState.roles.where((r) => r.id == roleId).firstOrNull;
      if (role != null) {
        return role.accent.color(context);
      }
      return context.cTextTertiary;
    }

    void addTasks(List<Task> tasks, double xMin, double xMax, double yMin, double yMax) {
      for (final t in tasks) {
        final rand = Random(t.id);
        final x = xMin + rand.nextDouble() * (xMax - xMin);
        final y = yMin + rand.nextDouble() * (yMax - yMin);
        cTasks.add(CompassTask(x, y, getRoleColor(t.roleId)));
      }
    }

    // Urgent et Important (Agir) -> x: -1..0, y: -1..0
    addTasks(mState.urgentImportantTasks, -0.85, -0.15, -0.85, -0.15);

    // Stratégique / À planifier (Important, Non Urgent) -> x: 0..1, y: -1..0
    addTasks(mState.strategicTasks, 0.15, 0.85, -0.85, -0.15);

    // Distraction / À déléguer (Urgent, Non Important) -> x: -1..0, y: 0..1
    addTasks(mState.distractionTasks, -0.85, -0.15, 0.15, 0.85);

    // Inutile / À éliminer (Non Urgent, Non Important) -> x: 0..1, y: 0..1
    addTasks(mState.uselessTasks, 0.15, 0.85, 0.15, 0.85);

    return cTasks;
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.title, required this.subtitle});

  final Color color;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: context.cSurfaceRaised,
        borderRadius: BorderRadius.circular(AppSpacing.radiusS),
        border: Border.all(color: context.cBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.inter(
                    size: 11.5,
                    weight: FontWeight.w600,
                    color: context.cTextPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: AppTypography.inter(
              size: 10.5,
              color: context.cTextTertiary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
