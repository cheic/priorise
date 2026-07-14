// onboarding_screen.dart — Écran d'onboarding en 4 étapes.
//
// TOKENS UTILISÉS :
//   surface #1B2A38 (fond)
//   brass #B8935B (indicateur actif, CTA, icônes fg)
//   brassGlow (icône bg circle)
//   brassBright (icône fg)
//   border-strong (points inactifs)
//   text-primary #ECE5D4, text-secondary #AFA792
//   Fraunces 560 (titres), Inter 400 (corps)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:priorise/l10n/app_localizations.dart';
import '../../../core/router/app_router.dart';
import '../../../core/tokens/app_colors.dart';
import '../../../core/tokens/app_spacing.dart';
import '../../../core/tokens/app_typography.dart';
import 'onboarding_cubit.dart';

// ── Slide data (record tuple) ─────────────────────────────────────────────
List<(IconData, String, String)> _getSlides(AppLocalizations l) => [
  (
    Icons.description_outlined,
    l.onb1Title,
    l.onb1Desc,
  ),
  (
    Icons.groups_outlined,
    l.onb2Title,
    l.onb2Desc,
  ),
  (
    Icons.calendar_today_outlined,
    l.onb3Title,
    l.onb3Desc,
  ),
  (
    Icons.explore_outlined,
    l.onb4Title,
    l.onb4Desc,
  ),
];

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatefulWidget {
  const _OnboardingView();

  @override
  State<_OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<_OnboardingView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _syncToPage(int page) {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 380),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == OnboardingStatus.done) {
          Navigator.pushReplacementNamed(context, AppRoutes.today);
        }
      },
      builder: (context, state) {
        // Synchroniser le PageController avec le cubit
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_pageController.hasClients &&
              _pageController.page?.round() != state.currentPage) {
            _syncToPage(state.currentPage);
          }
        });

        final hPad = AppSpacing.screenPaddingH(context);
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
          child: Scaffold(
            backgroundColor: context.cSurface,
            body: SafeArea(
              child: Column(
                children: [
                // ── Top bar: "Passer" right-aligned only ────────────────
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: hPad,
                    vertical: AppSpacing.m,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () =>
                          context.read<OnboardingCubit>().skip(),
                      child: Text(
                        AppLocalizations.of(context)!.skip,
                        style: AppTypography.labelMedium(
                          color: context.cTextSecondary,
                        ),
                      ),
                    ),
                  ),
                ),

                // ── PageView ────────────────────────────────────────────
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (i) =>
                        context.read<OnboardingCubit>().goToPage(i),
                    itemCount: OnboardingState.totalPages,
                    itemBuilder: (context, index) {
                      final slides = _getSlides(AppLocalizations.of(context)!);
                      final (icon, title, description) = slides[index];
                      return _SlidePage(
                        icon: icon,
                        title: title,
                        description: description,
                      );
                    },
                  ),
                ),

                // ── Bottom: dot indicator + CTA ─────────────────────────
                Padding(
                  padding: EdgeInsets.only(
                    left: hPad,
                    right: hPad,
                    top: AppSpacing.l,
                    bottom: AppSpacing.xxl,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _DotIndicator(
                        count: OnboardingState.totalPages,
                        current: state.currentPage,
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () =>
                              context.read<OnboardingCubit>().nextPage(),
                          style: FilledButton.styleFrom(
                            backgroundColor: context.cBrass,
                            foregroundColor: context.cInk,
                            padding:
                                const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppSpacing.radiusS,
                              ),
                            ),
                          ),
                          child: Text(
                            state.isLastPage ? AppLocalizations.of(context)!.start : AppLocalizations.of(context)!.next,
                            style: AppTypography.buttonText(
                              color: context.cInk,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}

// ── Slide page content ──────────────────────────────────────────────────────
class _SlidePage extends StatelessWidget {
  const _SlidePage({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Icon circle: 64px, brassGlow bg, brassBright fg ──────
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.cBrassGlow,
              ),
              child: Icon(
                icon,
                size: 28,
                color: context.cBrassBright,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            // ── Title: Fraunces 560, 20px ────────────────────────────
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTypography.fraunces(
                size: 20,
                weight: 560,
                color: context.cTextPrimary,
                height: 1.25,
              ),
            ),
            const SizedBox(height: AppSpacing.m),
            // ── Description: 13px, text-secondary, max 270px ────────
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 270),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: AppTypography.inter(
                  size: 13,
                  color: context.cTextSecondary,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Dot indicator ───────────────────────────────────────────────────────────
// Active: brass 18px wide pill (6px height).
// Inactive: 6px circles, borderStrong.
class _DotIndicator extends StatelessWidget {
  const _DotIndicator({required this.count, required this.current});

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeInOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 18 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive
                ? context.cBrass
                : context.cBorderStrong,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}
