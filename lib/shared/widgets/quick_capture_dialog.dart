import 'package:flutter/material.dart';
import 'package:priorise/l10n/app_localizations.dart';
import '../../../core/tokens/app_colors.dart';
import '../../../core/tokens/app_spacing.dart';
import '../../../core/tokens/app_typography.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/di/injection.dart';
import '../../../core/models/role_model.dart';
import '../../../domain/usecases/task_usecases.dart';
import '../../../domain/usecases/role_usecases.dart';
import '../../../core/services/widget_service.dart';
import '../../features/today/presentation/widgets/today_fab.dart';

class QuickCaptureDialog extends StatefulWidget {
  const QuickCaptureDialog({super.key});

  @override
  State<QuickCaptureDialog> createState() => _QuickCaptureDialogState();
}

class _QuickCaptureDialogState extends State<QuickCaptureDialog> {
  final _titleController = TextEditingController();
  int? _selectedRoleId;
  int? _selectedPriorityIndex;
  List<LifeRole> _roles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRoles();
  }

  Future<void> _loadRoles() async {
    try {
      final roles = await getIt<GetAllRolesUseCase>()();
      if (mounted) {
        setState(() {
          _roles = roles;
          _isLoading = false;
          if (roles.isNotEmpty) {
            _selectedRoleId = roles.first.id;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _submitCapturedTask() {
    final title = _titleController.text.trim();
    if (title.isNotEmpty && _selectedRoleId != null) {
      bool important = false;
      bool urgent = false;
      if (_selectedPriorityIndex == 0) {
        important = true;
        urgent = false;
      } else if (_selectedPriorityIndex == 1) {
        important = true;
        urgent = true;
      } else if (_selectedPriorityIndex == 2) {
        important = false;
        urgent = true;
      } else {
        important = false;
        urgent = false;
      }

      getIt<AddTaskUseCase>()(title, _selectedRoleId!, important: important, urgent: urgent).then((_) {
        WidgetService.updateAllWidgets().catchError((_) {});
        if (mounted) {
          Navigator.of(context).pop();
          AppToast.showSuccess(context, AppLocalizations.of(context)!.taskAdded);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    
    final priorities = [
      AppLocalizations.of(context)!.priorityStrategic,
      AppLocalizations.of(context)!.priorityUrgent,
      AppLocalizations.of(context)!.priorityDelegate,
      AppLocalizations.of(context)!.priorityEliminate,
    ];
    _selectedPriorityIndex ??= 0;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        margin: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 24,
        ),
        padding: const EdgeInsets.fromLTRB(22, 20, 22, 26),
        decoration: BoxDecoration(
          color: context.cSurface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: context.cBorderStrong),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: context.cBorderStrong,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Title
              Text(
                AppLocalizations.of(context)!.captureTask,
                style: AppTypography.fraunces(
                  size: 17,
                  weight: 560,
                  color: context.cTextPrimary,
                ),
              ),
              const SizedBox(height: 16),
              // Field 1: Quoi
              TodayModalLabel(text: AppLocalizations.of(context)!.whatLabel),
              const SizedBox(height: 6),
              TodayModalTextField(
                hint: AppLocalizations.of(context)!.taskHint,
                controller: _titleController,
                autofocus: true,
              ),
              const SizedBox(height: 16),
              // Field 2: Rôle
              TodayModalLabel(text: AppLocalizations.of(context)!.roleLabel),
              const SizedBox(height: 8),
              if (_isLoading)
                const Center(child: Padding(padding: EdgeInsets.all(8.0), child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))))
              else if (_roles.isEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: context.cSurfaceRaised,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                    border: Border.all(color: context.cBorder),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.noRolesDefined,
                    style: AppTypography.inter(size: 13, color: context.cTextSecondary).copyWith(height: 1.4),
                    textAlign: TextAlign.center,
                  ),
                )
              else
                SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _roles.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final role = _roles[index];
                      final isSelected = _selectedRoleId == role.id;
                      final roleColor = role.accent.color(context);
                      return GestureDetector(
                        onTap: () => setState(() => _selectedRoleId = role.id),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? roleColor.withValues(alpha: 0.15) : context.cSurfaceRaised,
                            border: Border.all(color: isSelected ? roleColor : context.cBorderStrong),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            role.name,
                            textAlign: TextAlign.center,
                            style: AppTypography.inter(
                              size: 13,
                              weight: isSelected ? FontWeight.w600 : FontWeight.w500,
                              color: isSelected ? roleColor : context.cTextSecondary,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 16),
              // Field 3: Important ? Urgent ?
              TodayModalLabel(text: AppLocalizations.of(context)!.priorityMatrixLabel),
              const SizedBox(height: 8),
              TodayModalDropdownField<int>(
                hint: AppLocalizations.of(context)!.selectPriority,
                value: _selectedPriorityIndex,
                items: List.generate(
                  priorities.length, 
                  (i) => DropdownMenuItem(value: i, child: Text(priorities[i])),
                ),
                onChanged: (val) => setState(() => _selectedPriorityIndex = val),
              ),
              const SizedBox(height: 24),
              // Actions
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: context.cBorderStrong),
                          borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)!.cancel,
                          style: AppTypography.inter(
                            size: 13,
                            weight: FontWeight.w500,
                            color: context.cTextSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: _roles.isEmpty ? null : _submitCapturedTask,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                      child: Container(
                        padding: const EdgeInsets.all(13),
                        decoration: BoxDecoration(
                          color: _roles.isEmpty ? context.cSurfaceRaised : context.cBrass,
                          borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                          border: _roles.isEmpty ? Border.all(color: context.cBorderStrong) : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)!.add,
                          style: AppTypography.inter(
                            size: 13.5,
                            weight: FontWeight.w600,
                            color: _roles.isEmpty ? context.cTextTertiary : const Color(0xFF1B140B),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
