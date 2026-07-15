import 'package:priorise/l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:priorise/core/tokens/app_spacing.dart';
import '../../../core/tokens/app_colors.dart';
import '../../../core/tokens/app_typography.dart';
import '../../../core/models/enums.dart';
import '../../../shared/widgets/card_border_painter.dart';
import '../../../shared/widgets/role_icons.dart';
import 'roles_cubit.dart';

class RolesPage extends StatelessWidget {
  const RolesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = AppSpacing.screenPaddingH(context);

    return Center(
      child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 840),
                child: BlocBuilder<RolesCubit, RolesState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ListView(
                      padding: EdgeInsets.fromLTRB(
                        hPad,
                        AppSpacing.xxl,
                        hPad,
                        AppSpacing.xxxxl,
                      ),
                      children: [
                        Text(
                          AppLocalizations.of(context)!.yourRoles,
                          style: AppTypography.mono(
                            size: 11,
                            color: context.cTextTertiary,
                            letterSpacing: 1.3,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.l),
                        
                        if (state.roles.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
                            child: Text(
                              "Aucun rôle n'a encore été défini. Ajoutez-en un pour commencer.",
                              style: AppTypography.inter(size: 14, color: context.cTextSecondary),
                              textAlign: TextAlign.center,
                            ),
                          ),

                        ...state.roles.map((role) {
                          final roleColor = role.accent.color(context);
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: CustomPaint(
                              foregroundPainter: CardBorderPainter(
                                borderColor: context.cBorder,
                                leftBorderColor: roleColor,
                                leftBorderWidth: 4,
                                radius: AppSpacing.radiusM,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: context.cSurfaceRaised,
                                  borderRadius: BorderRadius.circular(AppSpacing.radiusM),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(AppSpacing.radiusM),
                                  child: Dismissible(
                                    key: ValueKey('role_${role.id}'),
                                    direction: DismissDirection.endToStart,
                                    confirmDismiss: (direction) async {
                                      return await showDialog<bool>(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          backgroundColor: context.cSurfaceRaised,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusM)),
                                          title: Text(
                                            AppLocalizations.of(context)!.deleteRoleTitle,
                                            style: AppTypography.fraunces(size: 20, color: context.cTextPrimary),
                                          ),
                                          content: Text(
                                            AppLocalizations.of(context)!.deleteRoleDesc(role.name),
                                            style: AppTypography.inter(size: 14, color: context.cTextSecondary),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.of(context).pop(false),
                                              child: Text(AppLocalizations.of(context)!.cancel, style: AppTypography.inter(color: context.cTextPrimary, weight: FontWeight.w600)),
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.of(context).pop(true),
                                              child: Text(AppLocalizations.of(context)!.delete, style: AppTypography.inter(color: context.cError, weight: FontWeight.w600)),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    onDismissed: (_) {
                                      context.read<RolesCubit>().deleteRole(role.id);
                                    },
                                    background: Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.only(right: AppSpacing.l),
                                      color: context.cError.withAlpha(50),
                                      child: Icon(Icons.delete_outline, color: context.cError),
                                    ),
                                    child: GestureDetector(
                                      onTap: () => AddRoleSheet.show(
                                        context, 
                                        initialId: role.id,
                                        initialName: role.name, 
                                        initialAccent: role.accent,
                                        initialIconKey: role.iconKey,
                                      ),
                                      behavior: HitTestBehavior.opaque,
                                      child: Container(
                                        padding: const EdgeInsets.all(14.0),
                                        // Background is transparent to show parent
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 36,
                                              height: 36,
                                              decoration: BoxDecoration(
                                                color: context.cSurface,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(RoleIcons.getIcon(role.iconKey), color: roleColor, size: 17),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    role.name,
                                                    style: AppTypography.fraunces(
                                                      size: 14,
                                                      weight: 600,
                                                      color: context.cTextPrimary,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 3),
                                                  Text(
                                                    AppLocalizations.of(context)!.mainRole, // Mock subtitle
                                                    style: AppTypography.inter(
                                                      size: 12,
                                                      color: context.cTextSecondary,
                                                    ).copyWith(height: 1.4),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                        
                        const SizedBox(height: 4),
                        InkWell(
                          onTap: () => AddRoleSheet.show(context),
                          borderRadius: BorderRadius.circular(AppSpacing.radiusM),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: context.cBorderStrong),
                              borderRadius: BorderRadius.circular(AppSpacing.radiusM),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add, size: 16, color: context.cTextTertiary),
                                const SizedBox(width: 8),
                                Text(
                                  AppLocalizations.of(context)!.addRole,
                                  style: AppTypography.inter(
                                    size: 13,
                                    color: context.cTextTertiary,
                                  ),
                                ),
                              ],
                            ),
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

class AddRoleSheet extends StatefulWidget {
  const AddRoleSheet({super.key, this.initialId, this.initialName, this.initialAccent, this.initialIconKey});

  final int? initialId;
  final String? initialName;
  final RoleAccent? initialAccent;
  final String? initialIconKey;

  static void show(BuildContext context, {int? initialId, String? initialName, RoleAccent? initialAccent, String? initialIconKey}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<RolesCubit>(),
        child: AddRoleSheet(
          initialId: initialId, 
          initialName: initialName, 
          initialAccent: initialAccent,
          initialIconKey: initialIconKey,
        ),
      ),
    );
  }

  @override
  State<AddRoleSheet> createState() => _AddRoleSheetState();
}

class _AddRoleSheetState extends State<AddRoleSheet> {
  final _nameController = TextEditingController();
  late RoleAccent _selectedAccent;
  late String _selectedIconKey;

  late final List<({String name, RoleAccent accent, Color Function(BuildContext) colorBuilder})> _colorOptions;

  @override
  void initState() {
    super.initState();
    if (widget.initialName != null) {
      _nameController.text = widget.initialName!;
    }
    _selectedAccent = widget.initialAccent ?? RoleAccent.brass;
    _selectedIconKey = widget.initialIconKey ?? 'star';
    
    _colorOptions = [
      (name: 'Laiton', accent: RoleAccent.brass, colorBuilder: (c) => c.cBrass),
      (name: 'Sauge', accent: RoleAccent.sage, colorBuilder: (c) => c.cSage),
      (name: 'Argile', accent: RoleAccent.clay, colorBuilder: (c) => c.cClay),
      (name: 'Ardoise', accent: RoleAccent.slate, colorBuilder: (c) => c.cSlate),
      (name: 'Améthyste', accent: RoleAccent.amethyst, colorBuilder: (c) => c.cAmethyst),
      (name: 'Mousse', accent: RoleAccent.moss, colorBuilder: (c) => c.cMoss),
    ];
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInsets = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInsets),
      child: Container(
        margin: const EdgeInsets.only(
          top: 40,
          left: 16,
          right: 16,
          bottom: 24,
        ),
        decoration: BoxDecoration(
          color: context.cSurface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: context.cBorderStrong),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(AppSpacing.xl, AppSpacing.l, AppSpacing.xl, AppSpacing.xxl),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          // Handle
          Center(
            child: Container(
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                color: context.cBorderStrong,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            widget.initialName != null ? AppLocalizations.of(context)!.editRole : AppLocalizations.of(context)!.addRole,
            style: AppTypography.fraunces(
              size: 20,
              weight: 560,
              color: context.cTextPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          
          _buildLabel(AppLocalizations.of(context)!.roleName),
          const SizedBox(height: AppSpacing.s),
          TextField(
            controller: _nameController,
            style: AppTypography.inter(size: 14, color: context.cTextPrimary),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.roleNameHint,
              hintStyle: AppTypography.inter(size: 14, color: context.cTextTertiary),
              filled: true,
              fillColor: context.cSurfaceRaised,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                borderSide: BorderSide(color: context.cBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                borderSide: BorderSide(color: context.cBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                borderSide: BorderSide(color: context.cBrass),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
          ),
          
          const SizedBox(height: AppSpacing.xl),
          _buildLabel(AppLocalizations.of(context)!.colorLabel),
          const SizedBox(height: AppSpacing.m),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _colorOptions.map((option) {
              final isSelected = _selectedAccent == option.accent;
              final color = option.colorBuilder(context);
              return GestureDetector(
                onTap: () => setState(() => _selectedAccent = option.accent),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? context.cTextPrimary : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow: isSelected
                        ? [BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 8)]
                        : null,
                  ),
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: AppSpacing.xl),
          _buildLabel(AppLocalizations.of(context)!.iconLabel),
          const SizedBox(height: AppSpacing.m),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: RoleIcons.icons.keys.map((key) {
              final isSelected = _selectedIconKey == key;
              return GestureDetector(
                onTap: () => setState(() => _selectedIconKey = key),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isSelected ? context.cSurfaceRaised : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? context.cBrass : context.cBorder,
                    ),
                  ),
                  child: Icon(
                    RoleIcons.getIcon(key),
                    color: isSelected ? context.cBrassBright : context.cTextTertiary,
                    size: 20,
                  ),
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: AppSpacing.xxxxl),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: context.cBorder),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.cancel,
                      style: AppTypography.inter(
                        size: 13,
                        weight: FontWeight.w600,
                        color: context.cTextSecondary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.m),
              Expanded(
                child: InkWell(
                  onTap: () {
                    final name = _nameController.text.trim();
                    if (name.isNotEmpty) {
                      if (widget.initialId != null) {
                        context.read<RolesCubit>().updateRole(
                          widget.initialId!, 
                          name, 
                          _selectedAccent, 
                          _selectedIconKey,
                        );
                      } else {
                        context.read<RolesCubit>().addRole(
                          name, 
                          _selectedAccent, 
                          _selectedIconKey,
                        );
                      }
                    }
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: context.cTextPrimary,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                    ),
                    child: Text(
                      widget.initialName != null ? AppLocalizations.of(context)!.saveRole : AppLocalizations.of(context)!.createRole,
                      style: AppTypography.inter(
                        size: 13,
                        weight: FontWeight.w600,
                        color: context.cInk,
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

  Widget _buildLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: AppTypography.inter(
        size: 11,
        weight: FontWeight.w600,
        color: context.cTextTertiary,
        letterSpacing: 1.2,
      ),
    );
  }
}
