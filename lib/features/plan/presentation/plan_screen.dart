import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:priorise/l10n/app_localizations.dart';
import '../../../core/tokens/app_colors.dart';
import '../../../core/tokens/app_spacing.dart';
import '../../../core/tokens/app_typography.dart';
import '../../../shared/widgets/card_border_painter.dart';
import '../../../shared/widgets/page_header.dart';
import '../../../core/models/task_model.dart';
import 'plan_cubit.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = AppSpacing.screenPaddingH(context);

    return Scaffold(
      backgroundColor: context.cSurface,
      body: SafeArea(
        bottom: false,
        child: Column(
        children: [
          PageHeader(
            eyebrow: AppLocalizations.of(context)!.planWeeklyRitual,
            title: AppLocalizations.of(context)!.titlePlan,
            horizontalPadding: hPad,
            showBackButton: true,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(hPad, AppSpacing.xxl, hPad, AppSpacing.xxxxl + MediaQuery.paddingOf(context).bottom),
              children: [
                Text(
                  AppLocalizations.of(context)!.planDuration,
                  style: AppTypography.mono(
                    size: 11,
                    color: context.cTextTertiary,
                    letterSpacing: 1.3,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
                
                // Jar Illustration
                Center(
                  child: CustomPaint(
                    size: const Size(180, 200),
                    painter: _JarPainter(context),
                  ),
                ),
                
                const SizedBox(height: AppSpacing.l),
                Text(
                  AppLocalizations.of(context)!.planQuote,
                  textAlign: TextAlign.center,
                  style: AppTypography.inter(
                    size: 12,
                    color: context.cTextTertiary,
                  ),
                ),
                
                const SizedBox(height: AppSpacing.xxxxl),
                Text(
                  AppLocalizations.of(context)!.planRolesTitle,
                  style: AppTypography.mono(
                    size: 11,
                    color: context.cTextTertiary,
                    letterSpacing: 1.3,
                  ),
                ),
                const SizedBox(height: AppSpacing.l),
                
                // Dynamic Roles list
                BlocBuilder<PlanCubit, PlanState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.roles.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppSpacing.l),
                        child: Text(
                          AppLocalizations.of(context)!.noRoleDefinedYet,
                          textAlign: TextAlign.center,
                          style: AppTypography.inter(color: context.cTextTertiary, size: 14),
                        ),
                      );
                    }

                    return Column(
                      children: state.roles.map((role) {
                        final task = state.roleTasks[role.id];
                        return _PlanRow(
                          roleId: role.id,
                          color: role.accent.color(context),
                          roleName: role.name,
                          initialValue: task?.title ?? '',
                        );
                      }).toList(),
                    );
                  },
                ),
                
                const SizedBox(height: AppSpacing.xxxxl),
                
                // --- Tâches Ponctuelles Section ---
                Text(
                  AppLocalizations.of(context)!.planPunctualTasksTitle,
                  style: AppTypography.mono(
                    size: 11,
                    color: context.cTextTertiary,
                    letterSpacing: 1.3,
                  ),
                ),
                const SizedBox(height: AppSpacing.l),
                BlocBuilder<PlanCubit, PlanState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        if (state.punctualTasks.isNotEmpty)
                          ...state.punctualTasks.map((task) {
                            final role = state.roles.firstWhere((r) => r.id == task.roleId, orElse: () => state.roles.first);
                            return _PunctualTaskRow(task: task, color: role.accent.color(context), roleName: role.name);
                          }),
                        const SizedBox(height: AppSpacing.m),
                        OutlinedButton.icon(
                          onPressed: state.roles.isEmpty ? null : () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (ctx) => BlocProvider.value(
                                value: context.read<PlanCubit>(),
                                child: const PlanCaptureTaskSheet(),
                              ),
                            );
                          },
                          icon: Icon(Icons.add, size: 18, color: context.cTextSecondary),
                          label: Text(
                            AppLocalizations.of(context)!.planAddPunctualTask,
                            style: AppTypography.inter(size: 14, weight: FontWeight.w500, color: context.cTextSecondary),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: context.cBorderStrong),
                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSpacing.radiusM),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                ),

                const SizedBox(height: AppSpacing.xxxxl),
                
                Center(
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context, 'goto_matrix');
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: context.cBrass,
                      foregroundColor: context.cInk,
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.m),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.radiusM),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.validateMyWeek,
                      style: AppTypography.inter(size: 14, weight: FontWeight.w600, color: context.cInk),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class _PunctualTaskRow extends StatelessWidget {
  final Task task;
  final Color color;
  final String roleName;

  const _PunctualTaskRow({required this.task, required this.color, required this.roleName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.s),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: 12),
      decoration: BoxDecoration(
        color: context.cSurfaceRaised,
        borderRadius: BorderRadius.circular(AppSpacing.radiusS),
        border: Border.all(color: context.cBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roleName.toUpperCase(),
                  style: AppTypography.mono(size: 9, color: context.cTextTertiary, letterSpacing: 1.1),
                ),
                const SizedBox(height: 2),
                Text(
                  task.title,
                  style: AppTypography.inter(size: 14, color: context.cTextPrimary),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, size: 18, color: context.cTextTertiary),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (ctx) => BlocProvider.value(
                  value: context.read<PlanCubit>(),
                  child: PlanCaptureTaskSheet(taskToEdit: task),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, size: 18, color: context.cTextTertiary),
            onPressed: () {
              context.read<PlanCubit>().removeTask(task.id);
            },
          ),
        ],
      ),
    );
  }
}

class PlanCaptureTaskSheet extends StatefulWidget {
  final Task? taskToEdit;
  const PlanCaptureTaskSheet({super.key, this.taskToEdit});

  @override
  State<PlanCaptureTaskSheet> createState() => PlanCaptureTaskSheetState();
}

class PlanCaptureTaskSheetState extends State<PlanCaptureTaskSheet> {
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
    
    final cubitState = context.read<PlanCubit>().state;
    final roles = cubitState.roles;
    
    if (_selectedRoleId == null && roles.isNotEmpty) {
      _selectedRoleId = roles.first.id;
    }
    
    final priorities = [
      AppLocalizations.of(context)!.priorityStrategic,
      AppLocalizations.of(context)!.priorityUrgent,
      AppLocalizations.of(context)!.priorityDelegate,
      AppLocalizations.of(context)!.priorityEliminate,
    ];
    _selectedPriorityIndex ??= 3; // Default to non-important, non-urgent for gravel

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
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
              Text(
                widget.taskToEdit == null ? AppLocalizations.of(context)!.planAddPunctualTask : AppLocalizations.of(context)!.editTask,
                style: AppTypography.fraunces(size: 17, weight: 560, color: context.cTextPrimary),
              ),
              const SizedBox(height: 16),
              Text(AppLocalizations.of(context)!.whatLabel.toUpperCase(), style: AppTypography.mono(size: 10.5, color: context.cTextTertiary, letterSpacing: 0.8)),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: context.cSurfaceRaised,
                  border: Border.all(color: context.cBorderStrong),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                ),
                child: TextField(
                  controller: _titleController,
                  autofocus: true,
                  style: AppTypography.inter(size: 13, color: context.cTextPrimary),
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.taskHint,
                    hintStyle: AppTypography.inter(size: 13, color: context.cTextTertiary),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(AppLocalizations.of(context)!.roleLabel.toUpperCase(), style: AppTypography.mono(size: 10.5, color: context.cTextTertiary, letterSpacing: 0.8)),
              const SizedBox(height: 8),
              if (roles.isNotEmpty)
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
              Text(AppLocalizations.of(context)!.priorityMatrixLabel.toUpperCase(), style: AppTypography.mono(size: 10.5, color: context.cTextTertiary, letterSpacing: 0.8)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: context.cSurfaceRaised,
                  border: Border.all(color: context.cBorderStrong),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    isExpanded: true,
                    value: _selectedPriorityIndex,
                    dropdownColor: context.cSurfaceRaised,
                    icon: Icon(Icons.expand_more, size: 16, color: context.cTextTertiary),
                    style: AppTypography.inter(size: 13, color: context.cTextPrimary),
                    items: List.generate(
                      priorities.length, 
                      (i) => DropdownMenuItem(value: i, child: Text(priorities[i])),
                    ),
                    onChanged: (val) => setState(() => _selectedPriorityIndex = val),
                  ),
                ),
              ),
              const SizedBox(height: 24),
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
                          style: AppTypography.inter(size: 13, weight: FontWeight.w500, color: context.cTextSecondary),
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
                          if (_selectedPriorityIndex == 0) { important = true; urgent = false; }
                          else if (_selectedPriorityIndex == 1) { important = true; urgent = true; }
                          else if (_selectedPriorityIndex == 2) { important = false; urgent = true; }
                          
                          if (widget.taskToEdit == null) {
                            context.read<PlanCubit>().addPunctualTask(title, _selectedRoleId!, important: important, urgent: urgent);
                          } else {
                            context.read<PlanCubit>().updatePunctualTask(widget.taskToEdit!.id, title, _selectedRoleId!, important: important, urgent: urgent);
                          }
                          Navigator.of(context).pop();
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
                          AppLocalizations.of(context)!.saveRole,
                          style: AppTypography.inter(size: 13.5, weight: FontWeight.w600, color: const Color(0xFF1B140B)),
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

class _PlanRow extends StatefulWidget {
  const _PlanRow({
    required this.roleId,
    required this.color,
    required this.roleName,
    required this.initialValue,
  });

  final int roleId;
  final Color color;
  final String roleName;
  final String initialValue;

  @override
  State<_PlanRow> createState() => _PlanRowState();
}

class _PlanRowState extends State<_PlanRow> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant _PlanRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue && _controller.text != widget.initialValue) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.m),
      child: CustomPaint(
        foregroundPainter: CardBorderPainter(
          borderColor: context.cBorder,
          leftBorderColor: widget.color,
          leftBorderWidth: 4,
          radius: AppSpacing.radiusM,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: context.cSurfaceRaised,
            borderRadius: BorderRadius.circular(AppSpacing.radiusM),
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.roleName.toUpperCase(),
                      style: AppTypography.mono(
                        size: 10,
                        color: context.cTextTertiary,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 120),
                      child: TextField(
                        controller: _controller,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        onChanged: (val) {
                          context.read<PlanCubit>().updateTaskForRole(widget.roleId, val);
                        },
                        style: AppTypography.inter(size: 14, color: context.cTextPrimary),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: false,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 4),
                          hintText: AppLocalizations.of(context)!.planRoleHint,
                          hintStyle: AppTypography.inter(size: 14, color: context.cTextTertiary),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _JarPainter extends CustomPainter {
  final BuildContext context;
  _JarPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final paintBrassStroke = Paint()
      ..color = context.cBrass
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Jar body: M65 20h50v22c18 8 28 24 28 46v78c0 12-10 22-22 22H59c-12 0-22-10-22-22V88c0-22 10-38 28-46V20Z
    final jarPath = Path()
      ..moveTo(65, 20)
      ..lineTo(115, 20)
      ..lineTo(115, 42)
      ..cubicTo(133, 50, 143, 66, 143, 88)
      ..lineTo(143, 166)
      ..cubicTo(143, 178, 133, 188, 121, 188)
      ..lineTo(59, 188)
      ..cubicTo(47, 188, 37, 178, 37, 166)
      ..lineTo(37, 88)
      ..cubicTo(37, 66, 47, 50, 65, 42)
      ..lineTo(65, 20)
      ..close();
    canvas.drawPath(jarPath, paintBrassStroke);

    // Jar lid: rect x="65" y="14" width="50" height="10" rx="3"
    final lidRect = RRect.fromRectAndRadius(const Rect.fromLTWH(65, 14, 50, 10), const Radius.circular(3));
    canvas.drawRRect(lidRect, paintBrassStroke);

    // Big rocks
    final paintClayFill = Paint()..color = context.cClayDim..style = PaintingStyle.fill;
    final paintClayStroke = Paint()..color = context.cClay..style = PaintingStyle.stroke..strokeWidth = 1.4;
    final rock1 = RRect.fromRectAndRadius(const Rect.fromLTWH(42, 128, 42, 34), const Radius.circular(4));
    canvas.drawRRect(rock1, paintClayFill);
    canvas.drawRRect(rock1, paintClayStroke);

    final paintBrassGlowFill = Paint()..color = context.cBrassGlow..style = PaintingStyle.fill;
    final paintBrassRockStroke = Paint()..color = context.cBrass..style = PaintingStyle.stroke..strokeWidth = 1.4;
    final rock2 = RRect.fromRectAndRadius(const Rect.fromLTWH(90, 120, 46, 42), const Radius.circular(4));
    canvas.drawRRect(rock2, paintBrassGlowFill);
    canvas.drawRRect(rock2, paintBrassRockStroke);

    // Pebbles
    final paintSageFill = Paint()..color = context.cSageDim..style = PaintingStyle.fill;
    final paintSageStroke = Paint()..color = context.cSage..style = PaintingStyle.stroke..strokeWidth = 1.2;

    void drawPebble(double cx, double cy, double r) {
      canvas.drawCircle(Offset(cx, cy), r, paintSageFill);
      canvas.drawCircle(Offset(cx, cy), r, paintSageStroke);
    }
    drawPebble(55, 106, 9);
    drawPebble(78, 100, 7);
    drawPebble(112, 102, 8);
    drawPebble(130, 98, 6);

    // Sand
    final paintSandStroke = Paint()
      ..color = context.cTextTertiary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    final sandPath = Path()
      ..moveTo(50, 84)..lineTo(54, 84)
      ..moveTo(60, 80)..lineTo(64, 80)
      ..moveTo(70, 86)..lineTo(74, 86)
      ..moveTo(82, 78)..lineTo(86, 78)
      ..moveTo(94, 84)..lineTo(98, 84)
      ..moveTo(104, 78)..lineTo(108, 78)
      ..moveTo(116, 84)..lineTo(120, 84)
      ..moveTo(126, 80)..lineTo(130, 80);
    
    canvas.drawPath(sandPath, paintSandStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
