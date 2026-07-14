import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/tokens/app_colors.dart';
import '../../../core/tokens/app_spacing.dart';
import '../../../core/tokens/app_typography.dart';
import '../../../shared/widgets/page_header.dart';
import '../../../shared/painters/dashed_border_painter.dart';
import 'resizable_text_field.dart';
import 'mission_cubit.dart';

class MissionScreen extends StatelessWidget {
  const MissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MissionCubit(),
      child: const _MissionScreenContent(),
    );
  }
}

class _MissionScreenContent extends StatefulWidget {
  const _MissionScreenContent();

  @override
  State<_MissionScreenContent> createState() => _MissionScreenContentState();
}

class _MissionScreenContentState extends State<_MissionScreenContent> {
  bool _isEditing = false;
  late final TextEditingController _missionController;

  @override
  void initState() {
    super.initState();
    _missionController = TextEditingController();
  }

  @override
  void dispose() {
    _missionController.dispose();
    super.dispose();
  }

  void _showScheduleModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => const _ScheduleModal(),
    );
  }

  String _formatDate(DateTime d) {
    const months = ['janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'];
    return "Modifiée le ${d.day} ${months[d.month - 1]} · prochaine révision programmée pour octobre";
  }

  @override
  Widget build(BuildContext context) {
    final hPad = AppSpacing.screenPaddingH(context);

    return Scaffold(
      backgroundColor: context.cSurface,
      body: SafeArea(
        bottom: false,
        child: BlocConsumer<MissionCubit, MissionState>(
        listener: (context, state) {
          if (state is MissionLoaded && !_isEditing) {
            _missionController.text = state.statement;
          }
        },
        builder: (context, state) {
          if (state is MissionLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MissionError) {
            return Center(child: Text(state.message));
          }

          final loadedState = state as MissionLoaded;
          if (!_isEditing && _missionController.text.isEmpty) {
            _missionController.text = loadedState.statement;
          }

          return Column(
            children: [
              PageHeader(
                eyebrow: 'CE QUI VOUS GUIDE',
                title: 'Mission',
                horizontalPadding: hPad,
                showBackButton: true,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(hPad, AppSpacing.xxl, hPad, AppSpacing.xxxxl),
                  children: [
                    Text(
                      'VOTRE DÉCLARATION',
                      style: AppTypography.mono(
                        size: 11,
                        color: context.cTextTertiary,
                        letterSpacing: 1.3,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.m),
                    
                    // Quote Card
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      decoration: BoxDecoration(
                        color: context.cSurfaceRaised,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusM),
                        border: Border.all(color: context.cBorder),
                      ),
                      child: _isEditing
                          ? ResizableTextField(
                              minHeight: 120,
                              controller: _missionController,
                              style: AppTypography.fraunces(
                                size: 18,
                                weight: 600,
                                color: context.cTextPrimary,
                              ).copyWith(
                                height: 1.5,
                                fontStyle: FontStyle.italic,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: context.cBorderStrong,
                                    width: 1,
                                  ),
                                ),
                                filled: false,
                                contentPadding: const EdgeInsets.all(8),
                              ),
                            )
                          : Text(
                              '« ${loadedState.statement} »',
                              style: AppTypography.fraunces(
                                size: 18,
                                weight: 600,
                                color: context.cTextPrimary,
                              ).copyWith(
                                height: 1.5,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                    ),
                    
                    const SizedBox(height: AppSpacing.s),
                    Text(
                      _formatDate(loadedState.lastEditedAt),
                      style: AppTypography.inter(size: 10.5, color: context.cTextTertiary),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    
                    // Dashed Hint Cards
                    _DashedHint(text: 'Qui voulez-vous être, dans vos rôles les plus importants ?'),
                    const SizedBox(height: AppSpacing.m),
                    _DashedHint(text: 'Qu\'est-ce que vous voulez accomplir, et pour qui ?'),
                    const SizedBox(height: AppSpacing.m),
                    _DashedHint(text: 'Sur quels principes refusez-vous de transiger ?'),
                    
                    const SizedBox(height: AppSpacing.xxxxl),
                    
                    if (_isEditing)
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  _isEditing = false;
                                  _missionController.text = loadedState.statement;
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: context.cTextSecondary,
                                side: BorderSide(color: context.cBorderStrong),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                                ),
                              ),
                              child: Text(
                                'Annuler',
                                style: AppTypography.inter(size: 14, weight: FontWeight.w500, color: context.cTextSecondary),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: FilledButton(
                              onPressed: () {
                                setState(() {
                                  _isEditing = false;
                                });
                                context.read<MissionCubit>().updateMission(_missionController.text.trim());
                                
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: [
                                        Icon(Icons.check, color: context.cSage, size: 14),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Mission mise à jour',
                                          style: AppTypography.inter(
                                            size: 12,
                                            color: context.cTextPrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    backgroundColor: context.cSurfaceRaised,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(999),
                                      side: BorderSide(color: context.cBorderStrong),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    margin: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
                                    elevation: 10,
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  ),
                                );
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: context.cBrass,
                                foregroundColor: context.cInk,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                                ),
                              ),
                              child: Text(
                                'Enregistrer',
                                style: AppTypography.inter(size: 14, weight: FontWeight.w600, color: context.cInk),
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton(
                              onPressed: () {
                                setState(() {
                                  _missionController.text = loadedState.statement;
                                  _isEditing = true;
                                });
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: context.cBrass,
                                foregroundColor: context.cInk,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                                ),
                              ),
                              child: Text(
                                'Modifier',
                                style: AppTypography.inter(size: 14, weight: FontWeight.w600, color: context.cInk),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _showScheduleModal,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: context.cTextSecondary,
                                side: BorderSide(color: context.cBorderStrong),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                                ),
                              ),
                              child: Text(
                                'Planifier une révision',
                                style: AppTypography.inter(size: 14, weight: FontWeight.w500, color: context.cTextSecondary),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      ),
    );
  }
}

class _DashedHint extends StatelessWidget {
  const _DashedHint({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        color: context.cBorderStrong,
        strokeWidth: 1.2,
        dashWidth: 4,
        dashSpace: 4,
        radius: AppSpacing.radiusS,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusS),
        ),
        child: Text(
          text,
          style: AppTypography.inter(size: 13, color: context.cTextSecondary).copyWith(height: 1.4),
        ),
      ),
    );
  }
}

class _ScheduleModal extends StatelessWidget {
  const _ScheduleModal();

  @override
  Widget build(BuildContext context) {
    final bottomInsets = MediaQuery.viewInsetsOf(context).bottom;
    
    return Container(
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: bottomInsets > 0 ? bottomInsets + 16 : 24,
      ),
      decoration: BoxDecoration(
        color: context.cSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: context.cBorderStrong),
      ),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.cBorderStrong,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Planifier une révision',
              style: AppTypography.fraunces(size: 20, weight: 600, color: context.cTextPrimary),
            ),
            const SizedBox(height: 12),
            Text(
              'Une mission se révise rarement, mais délibérément. Choisissez une échéance — vous recevrez un rappel unique, pas une notification récurrente.',
              style: AppTypography.inter(size: 13, color: context.cTextSecondary).copyWith(height: 1.5),
            ),
            const SizedBox(height: 24),
            Text(
              'DANS',
              style: AppTypography.mono(size: 11, color: context.cTextTertiary, letterSpacing: 1),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: context.cSurfaceRaised,
                borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                border: Border.all(color: context.cBorderStrong),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  isExpanded: true,
                  value: 3,
                  dropdownColor: context.cSurfaceRaised,
                  icon: Icon(Icons.expand_more, color: context.cTextSecondary),
                  style: AppTypography.inter(size: 15, color: context.cTextPrimary),
                  items: const [
                    DropdownMenuItem(value: 1, child: Text('1 mois')),
                    DropdownMenuItem(value: 3, child: Text('3 mois')),
                    DropdownMenuItem(value: 6, child: Text('6 mois')),
                    DropdownMenuItem(value: 12, child: Text('1 an')),
                  ],
                  onChanged: (val) {},
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: context.cTextSecondary,
                      side: BorderSide(color: context.cBorderStrong),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                      ),
                    ),
                    child: Text('Annuler', style: AppTypography.inter(size: 15, weight: FontWeight.w500)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Rappel de révision programmé',
                            style: AppTypography.inter(size: 14, color: context.cTextPrimary),
                          ),
                          backgroundColor: context.cSurfaceRaised,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: context.cBrass,
                      foregroundColor: context.cInk,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                      ),
                    ),
                    child: Text('Programmer', style: AppTypography.inter(size: 15, weight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
