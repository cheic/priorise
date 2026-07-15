import 'package:priorise/l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:priorise/core/tokens/app_colors.dart';
import 'package:priorise/core/tokens/app_spacing.dart';
import 'package:priorise/core/tokens/app_typography.dart';
import 'package:priorise/core/widgets/app_toast.dart';
import 'package:priorise/core/models/role_model.dart';
import 'package:priorise/core/models/task_model.dart';

import '../today_cubit.dart';

class TodayFab extends StatelessWidget {
  const TodayFab({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final todayCubit = context.read<TodayCubit>();
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => BlocProvider.value(
            value: todayCubit,
            child: const TodayCaptureTaskSheet(),
          ),
        );
      },
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.cBrass,
          boxShadow: [
            BoxShadow(
              color: context.cBrassGlow,
              blurRadius: 20,
              spreadRadius: 4,
            ),
          ],
        ),
        child: const Icon(
          Icons.edit_rounded,
          color: Color(0xFF1B140B), // ink-like dark
          size: 22,
        ),
      ),
    );
  }
}

class TodayCaptureTaskSheet extends StatefulWidget {
  final Task? taskToEdit;
  const TodayCaptureTaskSheet({super.key, this.taskToEdit});

  @override
  State<TodayCaptureTaskSheet> createState() => TodayCaptureTaskSheetState();
}

class TodayCaptureTaskSheetState extends State<TodayCaptureTaskSheet> {
  final _titleController = TextEditingController();
  int? _selectedRoleId;
  int? _selectedPriorityIndex;

  @override
  void initState() {
    super.initState();
    if (widget.taskToEdit != null) {
      _titleController.text = widget.taskToEdit!.title;
      _selectedRoleId = widget.taskToEdit!.roleId;
      if (widget.taskToEdit!.important && !widget.taskToEdit!.urgent) {
        _selectedPriorityIndex = 0;
      } else if (widget.taskToEdit!.important && widget.taskToEdit!.urgent) {
        _selectedPriorityIndex = 1;
      } else if (!widget.taskToEdit!.important && widget.taskToEdit!.urgent) {
        _selectedPriorityIndex = 2;
      } else {
        _selectedPriorityIndex = 3;
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    
    final cubitState = context.read<TodayCubit>().state;
    final roles = cubitState is TodayLoaded ? cubitState.roles : <LifeRole>[];
    
    if (_selectedRoleId == null && roles.isNotEmpty) {
      _selectedRoleId = roles.first.id;
    }
    
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
            widget.taskToEdit == null ? AppLocalizations.of(context)!.captureTask : AppLocalizations.of(context)!.editTask,
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
          if (roles.isEmpty)
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
                itemCount: roles.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final role = roles[index];
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
                  onTap: roles.isEmpty ? null : () {
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
                      if (widget.taskToEdit == null) {
                        context.read<TodayCubit>().addTask(title, _selectedRoleId!, important: important, urgent: urgent);
                        Navigator.of(context).pop();
                        AppToast.showSuccess(context, AppLocalizations.of(context)!.taskAdded);
                      } else {
                        context.read<TodayCubit>().updateTask(widget.taskToEdit!.id, title, _selectedRoleId!, important: important, urgent: urgent);
                        Navigator.of(context).pop();
                        AppToast.showSuccess(context, AppLocalizations.of(context)!.taskUpdated);
                      }
                    }
                  },
                  borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                  child: Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: roles.isEmpty ? context.cSurfaceRaised : context.cBrass,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                      border: roles.isEmpty ? Border.all(color: context.cBorderStrong) : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.saveRole,
                      style: AppTypography.inter(
                        size: 13.5,
                        weight: FontWeight.w600,
                        color: roles.isEmpty ? context.cTextTertiary : const Color(0xFF1B140B),
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
    ));
  }
}

class TodayModalLabel extends StatelessWidget {
  final String text;
  const TodayModalLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: AppTypography.mono(
        size: 10.5,
        color: context.cTextTertiary,
        letterSpacing: 0.08 * 10.5,
      ),
    );
  }
}

class TodayModalTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final bool autofocus;
  const TodayModalTextField({super.key, required this.hint, this.controller, this.autofocus = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.cSurfaceRaised,
        border: Border.all(color: context.cBorderStrong),
        borderRadius: BorderRadius.circular(AppSpacing.radiusS),
      ),
      child: TextField(
        controller: controller,
        autofocus: autofocus,
        style: AppTypography.inter(size: 13, color: context.cTextPrimary),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTypography.inter(size: 13, color: context.cTextTertiary),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          isDense: true,
        ),
      ),
    );
  }
}

class TodayModalDropdownField<T> extends StatelessWidget {
  final String hint;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;

  const TodayModalDropdownField({super.key, 
    required this.hint,
    required this.items,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: context.cSurfaceRaised,
        border: Border.all(color: context.cBorderStrong),
        borderRadius: BorderRadius.circular(AppSpacing.radiusS),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          value: value,
          dropdownColor: context.cSurfaceRaised,
          icon: Icon(Icons.expand_more, size: 16, color: context.cTextTertiary),
          style: AppTypography.inter(size: 13, color: context.cTextPrimary),
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }
}