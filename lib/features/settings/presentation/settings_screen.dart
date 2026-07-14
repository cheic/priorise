import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/tokens/app_colors.dart';
import '../../../core/tokens/app_spacing.dart';
import '../../../core/tokens/app_typography.dart';
import '../../../shared/widgets/page_header.dart';
import '../../shell/presentation/shell_cubit.dart';
import '../../../shared/mock_ai_cubit.dart';
import '../../../core/themes/theme_cubit.dart';
import '../../../core/di/injection.dart';
import '../../../core/services/notification_service.dart';
import 'settings_cubit.dart';
import '../../mission/presentation/mission_screen.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {

  bool _obscureKey = true;
  late final TextEditingController _apiKeyController;

  @override
  void initState() {
    super.initState();
    _apiKeyController = TextEditingController();
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  Future<void> _toggleNotifications(bool value) async {
    if (value) {
      final granted = await getIt<NotificationService>().requestPermissionWithExplanation(context);
      if (mounted) {
        context.read<SettingsCubit>().updateNotifications(granted);
      }
      if (granted) {
        // Schedule daily at 9:00 AM as an example
        await getIt<NotificationService>().scheduleDailyReminder(hour: 9, minute: 0);
      }
    } else {
      if (mounted) {
        context.read<SettingsCubit>().updateNotifications(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hPad = AppSpacing.screenPaddingH(context);

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, settingsState) {
        final settings = settingsState.settings;
        if (settings == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final aiEnabled = settings.aiSuggestionsEnabled;
        final notificationsEnabled = settings.gentleRemindersEnabled;
        final selectedProvider = settings.aiProvider;
        
        if (_apiKeyController.text != settings.aiApiKey && !FocusScope.of(context).hasFocus) {
          _apiKeyController.text = settings.aiApiKey;
        }

        return Scaffold(
          backgroundColor: context.cSurface,
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
              PageHeader(
                eyebrow: 'VOTRE ATELIER',
                title: 'Paramètres',
                horizontalPadding: hPad,
                showBackButton: true,
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
                    // ── Profil ──
                    const SectionTitle('Profil'),
                    const SizedBox(height: AppSpacing.m),
                    SettingClickableRow(
                      label: 'Ma mission',
                      sub: 'Consultée et modifiée occasionnellement, pas chaque semaine',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const MissionScreen()),
                        );
                      },
                    ),
                    SettingClickableRow(
                      label: 'Planification de la semaine',
                      sub: 'Rituel du dimanche — 20 minutes',
                      onTap: () => context.read<ShellCubit>().selectTab(3),
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    // ── Apparence ──
                    const SectionTitle('Apparence'),
                    const SizedBox(height: AppSpacing.m),
                    BlocBuilder<ThemeCubit, ThemeMode>(
                      builder: (context, themeMode) {
                        return ThemeSelector(currentTheme: themeMode);
                      },
                    ),
                    SettingToggleRow(
                      label: 'Rappels doux',
                      sub: 'Une seule notification par jour, jamais plus',
                      initialOn: notificationsEnabled,
                      onChanged: _toggleNotifications,
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    // ── Intelligence artificielle ──
                    const SectionTitle('Intelligence artificielle'),
                    const SizedBox(height: AppSpacing.m),
                    SettingToggleRow(
                      label: 'Activer les suggestions IA',
                      sub: 'Décomposition de tâches, aide au bilan hebdo',
                      initialOn: aiEnabled,
                      onChanged: (val) {
                        context.read<SettingsCubit>().updateAiSuggestions(val);
                        context.read<MockAiCubit>().toggleAi(val);
                      },
                    ),
                    if (aiEnabled) ...[
                      const SizedBox(height: AppSpacing.l),

                      const FieldLabel('Fournisseur'),
                      const SizedBox(height: AppSpacing.s),
                      GridView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: AppSpacing.m,
                          crossAxisSpacing: AppSpacing.m,
                          mainAxisExtent: 110, // Fixed height avoids overflow on narrow screens
                        ),
                        children: [
                          ProviderCard(
                            name: 'Claude',
                            hint: 'Anthropic',
                            icon: Icons.auto_awesome_outlined,
                            isSelected: selectedProvider == 'Claude',
                            onTap: () => context.read<SettingsCubit>().updateAiProvider('Claude'),
                          ),
                          ProviderCard(
                            name: 'Gemini',
                            hint: 'Google',
                            icon: Icons.lens_blur,
                            isSelected: selectedProvider == 'Gemini',
                            onTap: () => context.read<SettingsCubit>().updateAiProvider('Gemini'),
                          ),
                          ProviderCard(
                            name: 'GPT',
                            hint: 'OpenAI',
                            icon: Icons.grid_view,
                            isSelected: selectedProvider == 'GPT',
                            onTap: () => context.read<SettingsCubit>().updateAiProvider('GPT'),
                          ),
                          ProviderCard(
                            name: 'Kimi',
                            hint: 'Moonshot AI',
                            icon: Icons.arrow_outward,
                            isSelected: selectedProvider == 'Kimi',
                            onTap: () => context.read<SettingsCubit>().updateAiProvider('Kimi'),
                          ),
                          ProviderCard(
                            name: 'Qwen',
                            hint: 'Alibaba',
                            icon: Icons.explore_outlined,
                            isSelected: selectedProvider == 'Qwen',
                            onTap: () => context.read<SettingsCubit>().updateAiProvider('Qwen'),
                          ),
                          ProviderCard(
                            name: 'Mistral',
                            hint: 'Mistral AI',
                            icon: Icons.air_outlined,
                            isSelected: selectedProvider == 'Mistral',
                            onTap: () => context.read<SettingsCubit>().updateAiProvider('Mistral'),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      const FieldLabel('Clé API'),
                      const SizedBox(height: AppSpacing.s),
                      TextField(
                        controller: _apiKeyController,
                        obscureText: _obscureKey,
                        style: AppTypography.mono(size: 14, color: context.cTextPrimary),
                        onChanged: (val) => context.read<SettingsCubit>().updateAiApiKey(val),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: context.cSurface,
                          hintText: 'sk-ant-••••••••••••••••••••',
                          hintStyle: AppTypography.mono(size: 14, color: context.cTextTertiary),
                          contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSpacing.radiusM),
                            borderSide: BorderSide(color: context.cBorderStrong),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSpacing.radiusM),
                            borderSide: BorderSide(color: context.cBorderStrong),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSpacing.radiusM),
                            borderSide: BorderSide(color: context.cBrass),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureKey ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                              color: context.cTextSecondary,
                              size: 20,
                            ),
                            onPressed: () => setState(() => _obscureKey = !_obscureKey),
                          ),
                        ),
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
        ),
      );
    },
  );
}
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});
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

class FieldLabel extends StatelessWidget {
  const FieldLabel(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.labelMedium(color: context.cTextSecondary),
    );
  }
}

class SettingToggleRow extends StatefulWidget {
  const SettingToggleRow({
    super.key,
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
  State<SettingToggleRow> createState() => SettingToggleRowState();
}

class SettingToggleRowState extends State<SettingToggleRow> {
  late bool _isOn;

  @override
  void initState() {
    super.initState();
    _isOn = widget.initialOn;
  }

  @override
  void didUpdateWidget(covariant SettingToggleRow oldWidget) {
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

class ProviderCard extends StatelessWidget {
  const ProviderCard({
    super.key,
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

class ThemeSelector extends StatefulWidget {
  final ThemeMode currentTheme;
  const ThemeSelector({super.key, required this.currentTheme});

  @override
  State<ThemeSelector> createState() => ThemeSelectorState();
}

class ThemeSelectorState extends State<ThemeSelector> {
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
              Expanded(child: ThemeOptionCard(
                label: 'Auto',
                icon: Icons.brightness_auto_outlined,
                isSelected: widget.currentTheme == ThemeMode.system,
                onTap: () {
                  context.read<ThemeCubit>().setTheme(ThemeMode.system);
                },
              )),
              const SizedBox(width: AppSpacing.s),
              Expanded(child: ThemeOptionCard(
                label: 'Clair',
                icon: Icons.light_mode_outlined,
                isSelected: widget.currentTheme == ThemeMode.light,
                onTap: () {
                  context.read<ThemeCubit>().setTheme(ThemeMode.light);
                },
              )),
              const SizedBox(width: AppSpacing.s),
              Expanded(child: ThemeOptionCard(
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

class ThemeOptionCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const ThemeOptionCard({
    super.key,
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

class SettingClickableRow extends StatelessWidget {
  const SettingClickableRow({super.key, required this.label, required this.sub, required this.onTap});
  final String label;
  final String sub;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                  Text(label, style: AppTypography.labelLarge(color: context.cTextPrimary)),
                  const SizedBox(height: 2),
                  Text(sub, style: AppTypography.bodySmall(color: context.cTextSecondary)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Icon(Icons.chevron_right, color: context.cTextTertiary),
          ],
        ),
      ),
    );
  }
}
