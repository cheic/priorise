import 'package:priorise/l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/tokens/app_colors.dart';
import '../../../core/tokens/app_spacing.dart';
import '../../../core/tokens/app_typography.dart';
import '../../../core/widgets/app_toast.dart';
import '../../settings/presentation/settings_cubit.dart';
import '../../settings/presentation/settings_screen.dart';
import '../../../core/models/enums.dart';
import 'review_cubit.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewCubit, ReviewState>(
      builder: (context, state) {
        final hPad = AppSpacing.screenPaddingH(context);

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
                        _SectionTitle(AppLocalizations.of(context)!.titleReview),
                        const SizedBox(height: 4),
                        Text(
                          AppLocalizations.of(context)!.reviewSubtitle,
                          style: AppTypography.inter(
                            size: 11,
                            color: context.cTextTertiary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        _ReviewPrompt(
                          question: AppLocalizations.of(context)!.reviewQuestion1,
                          answer: state.review?.whatWorked ?? '',
                          hintText: AppLocalizations.of(context)!.reviewHint1,
                          onChanged: (val) {
                            context.read<ReviewCubit>().updateAnswers(whatWorked: val);
                          },
                        ),
                        _ReviewPrompt(
                          question: AppLocalizations.of(context)!.reviewQuestion2,
                          answer: state.review?.whatSlipped ?? '',
                          hintText: AppLocalizations.of(context)!.reviewHint2,
                          onChanged: (val) {
                            context.read<ReviewCubit>().updateAnswers(whatSlipped: val);
                          },
                        ),
                        
                        const SizedBox(height: 6),
                        BlocBuilder<SettingsCubit, SettingsState>(
                          builder: (context, settingsState) {
                            final settings = settingsState.settings;
                            if (settings == null || !settings.aiSuggestionsEnabled) {
                              return const SizedBox.shrink();
                            }
                            return InkWell(
                              onTap: state.isSynthesizing ? null : () {
                                if (settings.aiApiKey.trim().length < 5) {
                                  AppToast.show(context, AppLocalizations.of(context)!.configureValidApiKey);
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()));
                                } else {
                                  context.read<ReviewCubit>().synthesizeWithAI(
                                    provider: settings.aiProvider,
                                    apiKey: settings.aiApiKey,
                                    fallbackErrorMsg: AppLocalizations.of(context)!.aiSynthesisFailed,
                                    onError: (errorMsg) {
                                      AppToast.showError(context, errorMsg);
                                    },
                                    onSuccess: () {
                                      AppToast.showSuccess(context, AppLocalizations.of(context)!.aiSynthesisComplete);
                                    },
                                  );
                                }
                              },
                              borderRadius: BorderRadius.circular(AppSpacing.radiusM),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(color: context.cBorderStrong),
                                  borderRadius: BorderRadius.circular(AppSpacing.radiusM),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (state.isSynthesizing)
                                      SizedBox(
                                        width: 14,
                                        height: 14,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: context.cTextPrimary,
                                        ),
                                      )
                                    else
                                      Icon(
                                        Icons.auto_awesome_rounded,
                                        size: 14,
                                        color: context.cTextPrimary,
                                      ),
                                    const SizedBox(width: 8),
                                    Text(
                                      state.isSynthesizing ? AppLocalizations.of(context)!.synthesizing : AppLocalizations.of(context)!.synthesizeWithAI,
                                      style: AppTypography.inter(
                                        size: 13,
                                        weight: FontWeight.w500,
                                        color: context.cTextPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        
                        const SizedBox(height: AppSpacing.xxxl),
                        _SectionTitle(AppLocalizations.of(context)!.attentionByRole),
                        const SizedBox(height: 4),
                        Text(
                          AppLocalizations.of(context)!.attentionByRoleDesc,
                          style: AppTypography.inter(
                            size: 11,
                            color: context.cTextTertiary,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 12),
                        
                        _AttentionCard(state: state),
                        
                        const SizedBox(height: 14),
                        Text(
                          AppLocalizations.of(context)!.reviewMirrorText,
                          textAlign: TextAlign.center,
                          style: AppTypography.inter(
                            size: 11,
                            color: context.cTextTertiary,
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

class _ReviewPrompt extends StatefulWidget {
  const _ReviewPrompt({
    required this.question, 
    required this.answer, 
    required this.hintText,
    required this.onChanged,
  });

  final String question;
  final String answer;
  final String hintText;
  final ValueChanged<String> onChanged;

  @override
  State<_ReviewPrompt> createState() => _ReviewPromptState();
}

class _ReviewPromptState extends State<_ReviewPrompt> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.answer);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _ReviewPrompt oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.answer != oldWidget.answer && widget.answer != _controller.text) {
      _controller.text = widget.answer;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question,
            style: AppTypography.fraunces(
              size: 14.5,
              weight: 400,
              color: context.cTextPrimary,
            ).copyWith(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: AppSpacing.s),
          TextField(
            controller: _controller,
            maxLines: null,
            style: AppTypography.inter(size: 13, color: context.cTextPrimary),
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppTypography.inter(size: 13, color: context.cTextTertiary),
              filled: true,
              fillColor: context.cSurfaceRaised,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                borderSide: BorderSide(color: context.cBorderStrong),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                borderSide: BorderSide(color: context.cBorderStrong),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                borderSide: BorderSide(color: context.cBrass),
              ),
              contentPadding: const EdgeInsets.all(AppSpacing.m),
            ),
          ),
        ],
      ),
    );
  }
}

class _AttentionCard extends StatelessWidget {
  const _AttentionCard({required this.state});
  
  final ReviewState state;

  @override
  Widget build(BuildContext context) {
    // If no roles yet, show empty
    if (state.roles.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(AppSpacing.l),
        decoration: BoxDecoration(
          color: context.cSurfaceRaised,
          border: Border.all(color: context.cBorder),
          borderRadius: BorderRadius.circular(AppSpacing.radiusM),
        ),
        child: Text(
          AppLocalizations.of(context)!.noRoleDefinedYet,
          style: AppTypography.inter(size: 13, color: context.cTextTertiary),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.l),
      decoration: BoxDecoration(
        color: context.cSurfaceRaised,
        border: Border.all(color: context.cBorder),
        borderRadius: BorderRadius.circular(AppSpacing.radiusM),
      ),
      child: Column(
        children: state.roles.asMap().entries.map((entry) {
          final index = entry.key;
          final role = entry.value;
          final roleTasks = state.tasksForWeek.where((t) => t.roleId == role.id).toList();
          final totalDots = roleTasks.length.clamp(0, 5);
          final filledDots = roleTasks.where((t) => t.done).length.clamp(0, totalDots);
          final emptyDots = totalDots - filledDots;
          
          return Column(
            children: [
              _AttentionRow(name: role.name, filledDots: filledDots, emptyDots: emptyDots, accent: role.accent),
              if (index < state.roles.length - 1)
                const Divider(height: 18),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _AttentionRow extends StatelessWidget {
  const _AttentionRow({
    required this.name,
    required this.filledDots,
    required this.emptyDots,
    required this.accent,
  });

  final String name;
  final int filledDots;
  final int emptyDots;
  final RoleAccent accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: AppTypography.inter(
            size: 12.5,
            color: context.cTextPrimary,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(filledDots, (_) => _Dot(isFilled: true, accent: accent)),
            ...List.generate(emptyDots, (_) => _Dot(isFilled: false, accent: accent)),
          ],
        ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.isFilled, required this.accent});
  final bool isFilled;
  final RoleAccent accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5,
      height: 5,
      margin: const EdgeInsets.only(left: 3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isFilled ? accent.color(context) : context.cBorderStrong,
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
