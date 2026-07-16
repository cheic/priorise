import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/tokens/app_colors.dart';
import '../../../core/tokens/app_spacing.dart';
import '../../../core/tokens/app_typography.dart';
import '../../../shared/widgets/page_header.dart';
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
            eyebrow: 'RITUEL HEBDOMADAIRE',
            title: 'Planification',
            horizontalPadding: hPad,
            showBackButton: true,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(hPad, AppSpacing.xxl, hPad, AppSpacing.xxxxl + MediaQuery.paddingOf(context).bottom),
              children: [
                Text(
                  'DIMANCHE, 20 MINUTES',
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
                  'Les grosses pierres d\'abord — le reste trouve toujours sa place.',
                  textAlign: TextAlign.center,
                  style: AppTypography.inter(
                    size: 12,
                    color: context.cTextTertiary,
                  ),
                ),
                
                const SizedBox(height: AppSpacing.xxxxl),
                Text(
                  'UNE PIERRE, PAR RÔLE',
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
                          'Aucun rôle défini pour le moment.',
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
                      'Valider ma semaine',
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
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: 14),
      decoration: BoxDecoration(
        color: context.cSurfaceRaised,
        borderRadius: BorderRadius.circular(AppSpacing.radiusM),
        border: Border.all(color: context.cBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 14),
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
                TextField(
                  controller: _controller,
                  onChanged: (val) {
                    context.read<PlanCubit>().updateTaskForRole(widget.roleId, val);
                  },
                  style: AppTypography.inter(size: 14, color: context.cTextPrimary),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: false,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    hintText: 'Quelle est la seule chose qui compte ?',
                    hintStyle: AppTypography.inter(size: 14, color: context.cTextTertiary),
                  ),
                ),
              ],
            ),
          ),
        ],
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
