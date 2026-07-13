import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/injection.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/tokens/app_colors.dart';
import '../../../core/tokens/app_spacing.dart';
import '../../../core/tokens/app_typography.dart';
import '../../../core/themes/theme_cubit.dart';
import '../../../shared/painters/compass_painter.dart';
import '../../../shared/widgets/page_header.dart';
import '../../today/presentation/today_screen.dart';
import 'shell_cubit.dart';

class AppShellScreen extends StatelessWidget {
  const AppShellScreen({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ShellCubit(initialIndex: initialIndex),
      child: const _AppShellView(),
    );
  }
}

class _AppShellView extends StatelessWidget {
  const _AppShellView();

  @override
  Widget build(BuildContext context) {
    final screenClass = AppSpacing.screenClass(context);
    final pages = <Widget>[
      const TodayScreen(),
      const _RolesPage(),
      const _MatrixPage(),
      const _ReviewPage(),
      const _SettingsPage(),
    ];

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final overlayStyle = isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: BlocBuilder<ShellCubit, int>(
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
                    Expanded(child: pages[currentIndex]),
                  ],
                ),
              ),
            );
          }

          return Scaffold(
            backgroundColor: context.cSurface,
            body: IndexedStack(index: currentIndex, children: pages),
            bottomNavigationBar: _BottomNav(
              selectedIndex: currentIndex,
              onSelect: (index) => context.read<ShellCubit>().selectTab(index),
            ),
          );
        },
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
        padding: const EdgeInsets.fromLTRB(8, 10, 8, 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavButton(
              label: 'Aujourd\'hui',
              icon: Icons.today_outlined,
              activeIcon: Icons.today,
              active: selectedIndex == 0,
              onTap: () => onSelect(0),
            ),
            _NavButton(
              label: 'Rôles',
              icon: Icons.people_outline,
              activeIcon: Icons.people,
              active: selectedIndex == 1,
              onTap: () => onSelect(1),
            ),
            _NavButton(
              label: 'Priorise',
              icon: Icons.explore_outlined,
              activeIcon: Icons.explore,
              active: selectedIndex == 2,
              onTap: () => onSelect(2),
            ),
            _NavButton(
              label: 'Revue',
              icon: Icons.schedule_outlined,
              activeIcon: Icons.schedule,
              active: selectedIndex == 3,
              onTap: () => onSelect(3),
            ),
            _NavButton(
              label: 'Réglages',
              icon: Icons.settings_outlined,
              activeIcon: Icons.settings,
              active: selectedIndex == 4,
              onTap: () => onSelect(4),
            ),
          ],
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
          padding: const EdgeInsets.symmetric(vertical: 8),
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
                      'Priorise',
                      style: AppTypography.fraunces(
                        size: 20,
                        weight: 560,
                        color: context.cTextPrimary,
                      ),
                    ),
                    Text(
                      'Priorité aux priorités',
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
              'L\'application',
              style: AppTypography.mono(size: 10.5, color: context.cTextTertiary, letterSpacing: 1.7, smallCaps: true),
            ),
            const SizedBox(height: 20),
            _RailButton(
              label: 'Aujourd\'hui',
              icon: Icons.today_outlined,
              active: selectedIndex == 0,
              onTap: () => onSelect(0),
            ),
            _RailButton(
              label: 'Rôles',
              icon: Icons.people_outline,
              active: selectedIndex == 1,
              onTap: () => onSelect(1),
            ),
            _RailButton(
              label: 'Priorise',
              icon: Icons.explore_outlined,
              active: selectedIndex == 2,
              onTap: () => onSelect(2),
            ),
            _RailButton(
              label: 'Revue',
              icon: Icons.schedule_outlined,
              active: selectedIndex == 3,
              onTap: () => onSelect(3),
            ),
            _RailButton(
              label: 'Réglages',
              icon: Icons.settings_outlined,
              active: selectedIndex == 4,
              onTap: () => onSelect(4),
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
                '« Ce n\'est pas votre agenda qui doit dicter vos priorités — ce sont vos priorités qui doivent dicter votre agenda. »',
                style: AppTypography.fraunces(size: 14.5, weight: 300, color: context.cTextSecondary, height: 1.55),
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
              side: BorderSide(color: active ? context.cBrass : context.cBorder),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 10),
              Text(
                label,
                style: AppTypography.labelMedium(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RolesPage extends StatelessWidget {
  const _RolesPage();

  @override
  Widget build(BuildContext context) {
    final roles = [
      ('Professionnel', 'Terminer le rapport Q3', context.cBrass, Icons.work_outline),
      ('Famille', 'Planifier le weekend', context.cClay, Icons.home_outlined),
      ('Santé', '3 séances de sport', context.cSage, Icons.fitness_center_outlined),
      ('Apprentissage', 'Lire 20 pages', context.cBrassBright, Icons.menu_book_outlined),
    ];

    final hPad = AppSpacing.screenPaddingH(context);

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          PageHeader(
            eyebrow: 'DOMAINES',
            title: 'Rôles de vie',
            horizontalPadding: hPad,
          ),
          
          // ── Scrollable Content ─────────────────────────────────────────────
          Expanded(
            child: Center(
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
              const SizedBox(height: AppSpacing.s),
              Text(
                'Vos tâches vivent dans un rôle, pas dans un silo de projet.',
                style: AppTypography.bodyMedium(color: context.cTextSecondary),
              ),
              const SizedBox(height: AppSpacing.xl),
              Wrap(
                spacing: AppSpacing.m,
                runSpacing: AppSpacing.m,
                children: roles
                    .map(
                      (role) => Container(
                        width: 250,
                        padding: EdgeInsets.all(AppSpacing.l),
                        decoration: BoxDecoration(
                          color: context.cSurfaceRaised,
                          borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                          border: Border.all(color: context.cBorder),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(role.$4, color: role.$3),
                            const SizedBox(height: AppSpacing.s),
                            Text(
                              role.$1,
                              style: AppTypography.displaySmall(color: context.cTextPrimary),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              role.$2,
                              style: AppTypography.bodySmall(color: context.cTextSecondary),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    ),
  ],
      ),
    );
  }
}

class _MatrixPage extends StatelessWidget {
  const _MatrixPage();

  @override
  Widget build(BuildContext context) {
    final hPad = AppSpacing.screenPaddingH(context);

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          PageHeader(
            eyebrow: 'VUE D\'ENSEMBLE',
            title: 'Matrice',
            horizontalPadding: hPad,
          ),

          // ── Scrollable Content ─────────────────────────────────────────────
          Expanded(
            child: Center(
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
              const SizedBox(height: AppSpacing.s),
              Text(
                'Où va votre attention cette semaine',
                style: AppTypography.bodyMedium(color: context.cTextSecondary),
              ),
              const SizedBox(height: AppSpacing.xl),
              Center(
                child: SizedBox(
                  width: 260,
                  height: 260,
                  child: CustomPaint(
                    painter: CompassPainter(
                      isDark: Theme.of(context).brightness == Brightness.dark,
                      showGlow: true, 
                      strokeScaleFactor: 1.15,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              _LegendItem(color: context.cBrassGlow, title: 'Q1', subtitle: 'Important + urgent'),
              _LegendItem(color: context.cSageDim, title: 'Q2', subtitle: 'Important, non urgent'),
              _LegendItem(color: context.cClayDim, title: 'Q3', subtitle: 'Urgent, non important'),
              _LegendItem(color: context.cBorderStrong, title: 'Q4', subtitle: 'Ni urgent ni important'),
            ],
          ),
        ),
      ),
    ),
  ],
      ),
    );
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
      margin: const EdgeInsets.only(bottom: AppSpacing.s),
      padding: const EdgeInsets.all(AppSpacing.l),
      decoration: BoxDecoration(
        color: context.cSurfaceRaised,
        borderRadius: BorderRadius.circular(AppSpacing.radiusS),
        border: Border.all(color: context.cBorder),
      ),
      child: Row(
        children: [
          Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: AppSpacing.s),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.labelLarge(color: context.cTextPrimary)),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTypography.bodySmall(color: context.cTextSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewPage extends StatelessWidget {
  const _ReviewPage();

  @override
  Widget build(BuildContext context) {
    final hPad = AppSpacing.screenPaddingH(context);

    return SafeArea(
      child: Column(
        children: [
          PageHeader(
            eyebrow: 'VOTRE SEMAINE',
            title: 'Revue hebdomadaire',
            horizontalPadding: hPad,
          ),
          
          // ── Scrollable Content ─────────────────────────────────────────────
          Expanded(
            child: Center(
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
                    const SizedBox(height: AppSpacing.s),
                    Text(
                      'Regarder en arrière, sans score ni jugement.',
                      style: AppTypography.bodyMedium(color: context.cTextSecondary),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _ReviewCard(question: 'Qu\'est-ce qui a vraiment fait avancer votre semaine ?', answer: 'La séance de travail profond du mercredi.'),
                    _ReviewCard(question: 'Qu\'est-ce qui a été repoussé sans valeur ?', answer: 'Deux réponses d\'emails qui pouvaient attendre.'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.question, required this.answer});

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.m),
      padding: const EdgeInsets.all(AppSpacing.l),
      decoration: BoxDecoration(
        color: context.cSurfaceRaised,
        borderRadius: BorderRadius.circular(AppSpacing.radiusM),
        border: Border.all(color: context.cBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question, style: AppTypography.fraunces(size: 16, weight: 560, color: context.cTextPrimary)),
          const SizedBox(height: AppSpacing.s),
          Text(answer, style: AppTypography.bodyMedium(color: context.cTextSecondary)),
        ],
      ),
    );
  }
}

class _SettingsPage extends StatefulWidget {
  const _SettingsPage();

  @override
  State<_SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<_SettingsPage> {
  String _selectedProvider = 'Claude';
  bool _obscureKey = true;
  bool _aiEnabled = false;
  bool _notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkNotificationStatus();
  }

  Future<void> _checkNotificationStatus() async {
    final granted = await getIt<NotificationService>().checkPermission();
    if (mounted) {
      setState(() => _notificationsEnabled = granted);
    }
  }

  Future<void> _toggleNotifications(bool value) async {
    if (value) {
      final granted = await getIt<NotificationService>().requestPermissionWithExplanation(context);
      setState(() => _notificationsEnabled = granted);
      if (granted) {
        // Schedule daily at 9:00 AM as an example
        await getIt<NotificationService>().scheduleDailyReminder(hour: 9, minute: 0);
      }
    } else {
      // If disabled, just update state (real app might cancel notifications)
      setState(() => _notificationsEnabled = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hPad = AppSpacing.screenPaddingH(context);

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          PageHeader(
            eyebrow: 'VOTRE ATELIER',
            title: 'Paramètres',
            horizontalPadding: hPad,
          ),

        // ── Scrollable Content ─────────────────────────────────────────────
        Expanded(
          child: ListView(
            padding: EdgeInsets.only(
              top: AppSpacing.xxl,
              bottom: AppSpacing.xxxxl,
              left: hPad,
              right: hPad,
            ),
            children: [
              // ── Apparence ──
              _SectionTitle('Apparence'),
              const SizedBox(height: AppSpacing.m),
              BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, themeMode) {
                  return _ThemeSelector(currentTheme: themeMode);
                },
              ),
              _SettingToggleRow(
                label: 'Rappels doux',
                sub: 'Une seule notification par jour, jamais plus',
                initialOn: _notificationsEnabled,
                onChanged: _toggleNotifications,
              ),
              const SizedBox(height: AppSpacing.xxl),

              // ── Intelligence artificielle ──
              _SectionTitle('Intelligence artificielle'),
              const SizedBox(height: AppSpacing.m),
              _SettingToggleRow(
                label: 'Activer les suggestions IA',
                sub: 'Décomposition de tâches, aide à la revue hebdomadaire',
                initialOn: _aiEnabled,
                onChanged: (val) => setState(() => _aiEnabled = val),
              ),
              if (_aiEnabled) ...[
                const SizedBox(height: AppSpacing.l),

                _FieldLabel('Fournisseur'),
              const SizedBox(height: AppSpacing.s),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: AppSpacing.m,
                crossAxisSpacing: AppSpacing.m,
                childAspectRatio: 2.2,
                children: [
                  _ProviderCard(
                    name: 'Claude',
                    hint: 'Anthropic',
                    icon: Icons.auto_awesome_outlined,
                    isSelected: _selectedProvider == 'Claude',
                    onTap: () => setState(() => _selectedProvider = 'Claude'),
                  ),
                  _ProviderCard(
                    name: 'Gemini',
                    hint: 'Google',
                    icon: Icons.lens_blur,
                    isSelected: _selectedProvider == 'Gemini',
                    onTap: () => setState(() => _selectedProvider = 'Gemini'),
                  ),
                  _ProviderCard(
                    name: 'GPT',
                    hint: 'OpenAI',
                    icon: Icons.grid_view,
                    isSelected: _selectedProvider == 'GPT',
                    onTap: () => setState(() => _selectedProvider = 'GPT'),
                  ),
                  _ProviderCard(
                    name: 'Kimi',
                    hint: 'Moonshot AI',
                    icon: Icons.arrow_outward,
                    isSelected: _selectedProvider == 'Kimi',
                    onTap: () => setState(() => _selectedProvider = 'Kimi'),
                  ),
                  _ProviderCard(
                    name: 'Qwen',
                    hint: 'Alibaba',
                    icon: Icons.explore_outlined,
                    isSelected: _selectedProvider == 'Qwen',
                    onTap: () => setState(() => _selectedProvider = 'Qwen'),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              _FieldLabel('Clé API'),
              const SizedBox(height: AppSpacing.s),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      obscureText: _obscureKey,
                      style: AppTypography.mono(size: 14, color: context.cTextPrimary),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'sk-ant-••••••••••••••••••••',
                        hintStyle: AppTypography.mono(size: 14, color: context.cTextTertiary),
                        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: 14),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _obscureKey ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: context.cTextSecondary,
                      size: 20,
                    ),
                    onPressed: () => setState(() => _obscureKey = !_obscureKey),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              Center(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: context.cTextPrimary,
                    side: BorderSide(color: context.cBorderStrong),
                    backgroundColor: context.cSurfaceRaised,
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.m),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusM),
                    ),
                  ),
                  icon: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: context.cSage,
                      shape: BoxShape.circle,
                    ),
                  ),
                  label: Text('Tester la connexion', style: AppTypography.labelMedium()),
                ),
              ),
              const SizedBox(height: AppSpacing.xxxxl),

              // ── Privacy note ──
              Container(
                padding: const EdgeInsets.all(AppSpacing.l),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusM),
                  border: Border.all(color: context.cBorder),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      color: context.cTextSecondary,
                      size: 20,
                    ),
                    const SizedBox(width: AppSpacing.m),
                    Expanded(
                      child: Text(
                        'Votre clé reste stockée uniquement sur cet appareil. Rien n\'est envoyé à un serveur Priorise — vos requêtes vont directement du téléphone vers le fournisseur choisi.',
                        style: AppTypography.bodySmall(color: context.cTextSecondary),
                      ),
                    ),
                  ],
                ),
              ),
              ],
            ],
          ),
        ),
      ],
    ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.fraunces(
        size: 16.5,
        weight: 500,
        color: context.cTextPrimary,
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.labelMedium(color: context.cTextSecondary),
    );
  }
}

class _SettingToggleRow extends StatefulWidget {
  const _SettingToggleRow({
    required this.label,
    required this.sub,
    required this.initialOn,
    this.onChanged,
  });

  final String label;
  final String sub;
  final bool initialOn;
  final ValueChanged<bool>? onChanged;

  @override
  State<_SettingToggleRow> createState() => _SettingToggleRowState();
}

class _SettingToggleRowState extends State<_SettingToggleRow> {
  late bool _isOn;

  @override
  void initState() {
    super.initState();
    _isOn = widget.initialOn;
  }

  @override
  void didUpdateWidget(covariant _SettingToggleRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialOn != oldWidget.initialOn) {
      _isOn = widget.initialOn;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => _isOn = !_isOn);
        widget.onChanged?.call(_isOn);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.s),
        padding: const EdgeInsets.all(AppSpacing.l),
        decoration: BoxDecoration(
          color: context.cSurfaceRaised,
          borderRadius: BorderRadius.circular(AppSpacing.radiusM),
          border: Border.all(color: context.cBorder),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.label, style: AppTypography.labelLarge(color: context.cTextPrimary)),
                  const SizedBox(height: 2),
                  Text(widget.sub, style: AppTypography.bodySmall(color: context.cTextSecondary)),
                ],
              ),
            ),
            Container(
              width: 40,
              height: 24,
              decoration: BoxDecoration(
                color: _isOn ? context.cSage : context.cBorderStrong,
                borderRadius: BorderRadius.circular(999),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                alignment: _isOn ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 18,
                  height: 18,
                  margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: context.cInk,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProviderCard extends StatelessWidget {
  const _ProviderCard({
    required this.name,
    required this.hint,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String name;
  final String hint;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSpacing.m),
        decoration: BoxDecoration(
          color: isSelected ? context.cBrassGlow.withAlpha(20) : context.cSurfaceRaised,
          borderRadius: BorderRadius.circular(AppSpacing.radiusM),
          border: Border.all(
            color: isSelected ? context.cBrass.withAlpha(128) : context.cBorder,
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? context.cBrassBright : context.cTextSecondary,
              ),
              const Spacer(),
              Text(
                name,
                textAlign: TextAlign.center,
                style: AppTypography.labelLarge(
                  color: context.cTextPrimary,
                ).copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                hint,
                textAlign: TextAlign.center,
                style: AppTypography.bodySmall(
                  color: context.cTextTertiary,
                ).copyWith(fontSize: 11.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeSelector extends StatefulWidget {
  final ThemeMode currentTheme;
  const _ThemeSelector({required this.currentTheme});

  @override
  State<_ThemeSelector> createState() => _ThemeSelectorState();
}

class _ThemeSelectorState extends State<_ThemeSelector> {
  bool _isExpanded = false;

  String get _title {
    switch (widget.currentTheme) {
      case ThemeMode.system:
        return 'Thème Automatique';
      case ThemeMode.light:
        return 'Thème Clair';
      case ThemeMode.dark:
        return 'Thème Sombre';
    }
  }

  IconData get _icon {
    switch (widget.currentTheme) {
      case ThemeMode.system:
        return Icons.brightness_auto_outlined;
      case ThemeMode.light:
        return Icons.light_mode_outlined;
      case ThemeMode.dark:
        return Icons.dark_mode_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          behavior: HitTestBehavior.opaque,
          child: Container(
            margin: EdgeInsets.only(bottom: _isExpanded ? AppSpacing.m : AppSpacing.s),
            padding: const EdgeInsets.all(AppSpacing.l),
            decoration: BoxDecoration(
              color: context.cSurfaceRaised,
              borderRadius: BorderRadius.circular(AppSpacing.radiusM),
              border: Border.all(color: context.cBorder),
            ),
            child: Row(
              children: [
                Icon(_icon, color: context.cTextPrimary, size: 20),
                const SizedBox(width: AppSpacing.m),
                Expanded(
                  child: Text(
                    _title,
                    style: AppTypography.labelLarge(color: context.cTextPrimary),
                  ),
                ),
                Icon(
                  _isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: context.cTextSecondary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded) ...[
          Row(
            children: [
              Expanded(child: _ThemeOptionCard(
                label: 'Auto',
                icon: Icons.brightness_auto_outlined,
                isSelected: widget.currentTheme == ThemeMode.system,
                onTap: () {
                  context.read<ThemeCubit>().setTheme(ThemeMode.system);
                },
              )),
              const SizedBox(width: AppSpacing.s),
              Expanded(child: _ThemeOptionCard(
                label: 'Clair',
                icon: Icons.light_mode_outlined,
                isSelected: widget.currentTheme == ThemeMode.light,
                onTap: () {
                  context.read<ThemeCubit>().setTheme(ThemeMode.light);
                },
              )),
              const SizedBox(width: AppSpacing.s),
              Expanded(child: _ThemeOptionCard(
                label: 'Sombre',
                icon: Icons.dark_mode_outlined,
                isSelected: widget.currentTheme == ThemeMode.dark,
                onTap: () {
                  context.read<ThemeCubit>().setTheme(ThemeMode.dark);
                },
              )),
            ],
          ),
          const SizedBox(height: AppSpacing.m),
        ],
      ],
    );
  }
}

class _ThemeOptionCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOptionCard({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.m),
        decoration: BoxDecoration(
          color: isSelected ? context.cBrassGlow.withAlpha(20) : context.cSurfaceRaised,
          borderRadius: BorderRadius.circular(AppSpacing.radiusM),
          border: Border.all(
            color: isSelected ? context.cBrass.withAlpha(128) : context.cBorder,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? context.cBrassBright : context.cTextSecondary,
              size: 24,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: AppTypography.inter(
                size: 13,
                weight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? context.cBrassBright : context.cTextPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
