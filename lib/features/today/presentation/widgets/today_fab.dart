import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:priorise/core/tokens/app_colors.dart';
import 'package:priorise/core/tokens/app_spacing.dart';
import 'package:priorise/core/tokens/app_typography.dart';
import 'package:priorise/core/models/role_model.dart';

import '../today_cubit.dart';

class TodayFab extends StatelessWidget {
  const TodayFab();

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
  const TodayCaptureTaskSheet();

  @override
  State<TodayCaptureTaskSheet> createState() => TodayCaptureTaskSheetState();
}

class TodayCaptureTaskSheetState extends State<TodayCaptureTaskSheet> {
  final _titleController = TextEditingController();
  int? _selectedRoleId;
  String? _selectedPriority;

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
      'Stratégique / À planifier',
      'Urgent et Important',
      'Distraction / À déléguer',
      'Inutile / À éliminer'
    ];
    _selectedPriority ??= priorities.first;

    return Container(
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: bottomInset > 0 ? bottomInset + 16 : 24,
      ),
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 26),
      decoration: BoxDecoration(
        color: context.cSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: context.cBorderStrong),
      ),
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
            'Capturer une tâche',
            style: AppTypography.fraunces(
              size: 17,
              weight: 560,
              color: context.cTextPrimary,
            ),
          ),
          const SizedBox(height: 16),
          // Field 1: Quoi
          const TodayModalLabel(text: 'Quoi'),
          const SizedBox(height: 6),
          TodayModalTextField(
            hint: 'Ex. Rappeler le plombier',
            controller: _titleController,
            autofocus: true,
          ),
          const SizedBox(height: 12),
          // Field 2: Rôle
          const TodayModalLabel(text: 'Rôle'),
          const SizedBox(height: 6),
          TodayModalDropdownField<int>(
            hint: 'Sélectionner un rôle',
            value: _selectedRoleId,
            items: roles.map((r) => DropdownMenuItem(value: r.id, child: Text(r.name))).toList(),
            onChanged: (val) {
              if (val != null) setState(() => _selectedRoleId = val);
            },
          ),
          const SizedBox(height: 12),
          // Field 3: Important ? Urgent ?
          const TodayModalLabel(text: 'Important ? Urgent ?'),
          const SizedBox(height: 6),
          TodayModalDropdownField<String>(
            hint: 'Sélectionner une priorité',
            value: _selectedPriority,
            items: priorities.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
            onChanged: (val) {
              if (val != null) setState(() => _selectedPriority = val);
            },
          ),
          const SizedBox(height: 16),
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
                      'Annuler',
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
                  onTap: () {
                    final title = _titleController.text.trim();
                    if (title.isNotEmpty && _selectedRoleId != null) {
                      bool important = false;
                      bool urgent = false;
                      if (_selectedPriority == 'Stratégique / À planifier') {
                        important = true;
                        urgent = false;
                      } else if (_selectedPriority == 'Urgent et Important') {
                        important = true;
                        urgent = true;
                      } else if (_selectedPriority == 'Distraction / À déléguer') {
                        important = false;
                        urgent = true;
                      } else {
                        important = false;
                        urgent = false;
                      }
                      context.read<TodayCubit>().addTask(title, _selectedRoleId!, important: important, urgent: urgent);
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Icon(Icons.check, color: context.cSage, size: 14),
                              const SizedBox(width: 8),
                              Text(
                                'Tâche ajoutée à votre journée',
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
                    }
                  },
                  borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                  child: Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: context.cBrass,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Enregistrer',
                      style: AppTypography.inter(
                        size: 13.5,
                        weight: FontWeight.w600,
                        color: const Color(0xFF1B140B),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TodayModalLabel extends StatelessWidget {
  final String text;
  const TodayModalLabel({required this.text});

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
  const TodayModalTextField({required this.hint, this.controller, this.autofocus = false});

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

  const TodayModalDropdownField({
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