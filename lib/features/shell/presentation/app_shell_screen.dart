import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:priorise/l10n/app_localizations.dart';
import '../../../core/tokens/app_colors.dart';
import '../../../core/tokens/app_spacing.dart';
import '../../../core/tokens/app_typography.dart';
import '../../../shared/painters/compass_painter.dart';

import '../../today/presentation/today_screen.dart';
import '../../today/presentation/today_cubit.dart';
import '../../roles/presentation/roles_screen.dart';
import '../../roles/presentation/roles_cubit.dart';
import '../../matrix/presentation/matrix_screen.dart';
import '../../matrix/presentation/matrix_cubit.dart';
import '../../review/presentation/review_screen.dart';
import '../../review/presentation/review_cubit.dart';
import '../../settings/presentation/settings_screen.dart';
import '../../../core/di/injection.dart';
import '../../../shared/utils/fade_indexed_stack.dart';
import '../../../shared/widgets/page_header.dart';
import '../../../shared/utils/slide_up_route.dart';
import 'shell_cubit.dart';

class AppShellScreen extends StatelessWidget {
  const AppShellScreen({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ShellCubit(initialIndex: initialIndex)),
        BlocProvider(
          create: (_) => TodayCubit(
            getTodayTasks: getIt(),
            getAllRoles: getIt(),
            getCurrentPlan: getIt(),
            toggleTaskUseCase: getIt(),
            addTaskUseCase: getIt(),
            updateTaskUseCase: getIt(),
            deleteTaskUseCase: getIt(),
            watchTasksUseCase: getIt(),
          )..refresh(),
        ),
        BlocProvider(
          create: (_) => RolesCubit(
            getAllRoles: getIt(),
            addRoleUseCase: getIt(),
            updateRoleUseCase: getIt(),
            deleteRoleUseCase: getIt(),
          )..loadRoles(),
        ),
        BlocProvider(
          create: (_) =>
              MatrixCubit(getPendingTasks: getIt(), watchTasksUseCase: getIt())
                ..loadTasks(),
        ),
        BlocProvider(
          create: (_) => ReviewCubit(
            getReviewByDate: getIt(),
            saveReviewUseCase: getIt(),
            getAllRoles: getIt(),
            getTasks:
                getIt(), // Using GetAllTasksUseCase is better here! Let's just pass getIt() assuming it matches the type
          ),
        ),
      ],
      child: const _AppShellView(),
    );
  }
}

class _AppShellView extends StatefulWidget {
  const _AppShellView();

  @override
  State<_AppShellView> createState() => _AppShellViewState();
}

class _AppShellViewState extends State<_AppShellView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenClass = AppSpacing.screenClass(context);
    final pages = <Widget>[
      const TodayScreen(),
      const RolesPage(),
      const MatrixPage(),
      const ReviewPage(),
    ];

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final overlayStyle = isDark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, dynamic result) {
        if (didPop) return;
        SystemNavigator.pop();
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: BlocConsumer<ShellCubit, int>(
          listener: (context, currentIndex) {
            if (currentIndex == 0) {
              context.read<TodayCubit>().refresh();
            } else if (currentIndex == 1) {
              context.read<RolesCubit>().loadRoles();
            } else if (currentIndex == 2) {
              context.read<MatrixCubit>().loadTasks();
            } else if (currentIndex == 3) {
              context.read<ReviewCubit>().refresh();
            }
          },
          builder: (context, currentIndex) {
            if (screenClass == ScreenClass.expanded) {
              return Scaffold(
                backgroundColor: context.cSurface,
                body: SafeArea(
                  child: Row(
                    children: [
                      _SideRail(
                        selectedIndex: currentIndex,
                        onSelect: (index) =>
                            context.read<ShellCubit>().selectTab(index),
                      ),
                      Container(width: 1, color: context.cBorder),
                      Expanded(
                        child: FadeIndexedStack(
                          index: currentIndex,
                          children: [
                            for (int i = 0; i < pages.length; i++)
                              Column(
                                children: [
                                  _GlobalHeader(currentIndex: i),
                                  Expanded(child: pages[i]),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Scaffold(
              backgroundColor: context.cSurface,
              body: SafeArea(
                bottom: false,
                child: FadeIndexedStack(
                  index: currentIndex,
                  children: [
                    for (int i = 0; i < pages.length; i++)
                      Column(
                        children: [
                          _GlobalHeader(currentIndex: i),
                          Expanded(child: pages[i]),
                        ],
                      ),
                  ],
                ),
              ),
              bottomNavigationBar: _BottomNav(
                selectedIndex: currentIndex,
                onSelect: (index) =>
                    context.read<ShellCubit>().selectTab(index),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.selectedIndex, required this.onSelect});

  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: context.cSurface,
          border: Border(top: BorderSide(color: context.cBorder)),
        ),
        padding: const EdgeInsets.fromLTRB(4, 10, 4, 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavButton(
              label: AppLocalizations.of(context)!.navToday,
              icon: Icons.today_outlined,
              activeIcon: Icons.today,
              active: selectedIndex == 0,
              onTap: () => onSelect(0),
            ),
            _NavButton(
              label: AppLocalizations.of(context)!.navRoles,
              icon: Icons.people_outline,
              activeIcon: Icons.people,
              active: selectedIndex == 1,
              onTap: () => onSelect(1),
            ),
            _NavButton(
              label: AppLocalizations.of(context)!.navPriorise,
              icon: Icons.explore_outlined,
              activeIcon: Icons.explore,
              active: selectedIndex == 2,
              onTap: () => onSelect(2),
            ),
            _NavButton(
              label: AppLocalizations.of(context)!.navReview,
              icon: Icons.schedule_outlined,
              activeIcon: Icons.schedule,
              active: selectedIndex == 3,
              onTap: () => onSelect(3),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlobalHeader extends StatelessWidget {
  const _GlobalHeader({required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final hPad = AppSpacing.screenPaddingH(context);

    final l = AppLocalizations.of(context);
    if (l == null) {
      return PageHeader(
        eyebrow: '',
        title: AppLocalizations.of(context)!.navPriorise,
        horizontalPadding: hPad,
      );
    }
    String eyebrow = '';
    String title = '';

    switch (currentIndex) {
      case 0:
        final now = DateTime.now();
        final jours = [
          l.monday,
          l.tuesday,
          l.wednesday,
          l.thursday,
          l.friday,
          l.saturday,
          l.sunday,
        ];
        final mois = [
          l.january,
          l.february,
          l.march,
          l.april,
          l.may,
          l.june,
          l.july,
          l.august,
          l.september,
          l.october,
          l.november,
          l.december,
        ];
        eyebrow = '${jours[now.weekday - 1]} ${now.day} ${mois[now.month - 1]}';
        title = l.hello;
        break;
      case 1:
        eyebrow = l.eyebrowRoles;
        title = l.titleRoles;
        break;
      case 2:
        eyebrow = l.eyebrowMatrix;
        title = l.titleMatrix;
        break;
      case 3:
        eyebrow = l.eyebrowReview;
        title = l.titleReview;
        break;
    }

    return PageHeader(
      eyebrow: eyebrow,
      title: title,
      horizontalPadding: hPad,
      trailing: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          final result = await Navigator.push<String>(
            context,
            SlideUpRoute<String>(page: const SettingsPage()),
          );
          if (result == 'goto_matrix' && context.mounted) {
            context.read<ShellCubit>().selectTab(2);
          }
        },
        child: Icon(
          Icons.settings_outlined,
          color: context.cTextSecondary,
          size: 24,
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.active,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? context.cBrassBright : context.cTextTertiary;
    return Expanded(
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(active ? activeIcon : icon, size: 20, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.mono(
                size: 9,
                color: color,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SideRail extends StatelessWidget {
  const _SideRail({required this.selectedIndex, required this.onSelect});

  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 34, 22, 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CustomPaint(
                    painter: CompassPainter(
                      isDark: Theme.of(context).brightness == Brightness.dark,
                      showGlow: false,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.navPriorise,
                      style: AppTypography.fraunces(
                        size: 20,
                        weight: 560,
                        color: context.cTextPrimary,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.sideRailSubtitle,
                      style: AppTypography.mono(
                        size: 10,
                        color: context.cTextTertiary,
                        smallCaps: true,
                        letterSpacing: 1.8,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 28),
            Text(
              AppLocalizations.of(context)!.sideRailSection,
              style: AppTypography.mono(
                size: 10.5,
                color: context.cTextTertiary,
                letterSpacing: 1.7,
                smallCaps: true,
              ),
            ),
            const SizedBox(height: 20),
            _RailButton(
              label: AppLocalizations.of(context)!.navToday,
              icon: Icons.today_outlined,
              active: selectedIndex == 0,
              onTap: () => onSelect(0),
            ),
            _RailButton(
              label: AppLocalizations.of(context)!.navRoles,
              icon: Icons.people_outline,
              active: selectedIndex == 1,
              onTap: () => onSelect(1),
            ),
            _RailButton(
              label: AppLocalizations.of(context)!.navPriorise,
              icon: Icons.explore_outlined,
              active: selectedIndex == 2,
              onTap: () => onSelect(2),
            ),
            _RailButton(
              label: AppLocalizations.of(context)!.navReview,
              icon: Icons.schedule_outlined,
              active: selectedIndex == 3,
              onTap: () => onSelect(3),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.cSurface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusM),
                border: Border.all(color: context.cBorder),
              ),
              child: Text(
                AppLocalizations.of(context)!.sideRailQuote,
                style: AppTypography.fraunces(
                  size: 14.5,
                  weight: 300,
                  color: context.cTextSecondary,
                  height: 1.55,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RailButton extends StatelessWidget {
  const _RailButton({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? context.cBrassBright : context.cTextSecondary;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            backgroundColor: active ? context.cBrassGlow : context.cSurface,
            foregroundColor: color,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusS),
              side: BorderSide(
                color: active ? context.cBrass : context.cBorder,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 10),
              Text(label, style: AppTypography.labelMedium(color: color)),
            ],
          ),
        ),
      ),
    );
  }
}
