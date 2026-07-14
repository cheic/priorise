// main.dart — Point d'entrée Priorise.
// Initialise les dépendances, puis lance MaterialApp en thème sombre/clair.
// Règle sécurité : aucun print(), aucune clé API ici.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:priorise/l10n/app_localizations.dart';
import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/themes/app_theme.dart';
import 'core/themes/theme_cubit.dart';
import 'features/settings/presentation/settings_cubit.dart';
import 'shared/mock_ai_cubit.dart';
import 'core/services/widget_service.dart';

import 'core/services/database_service.dart';
import 'core/models/task_model.dart';
import 'core/models/role_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Verrouille l'orientation portrait sur téléphone ;
  // autorise toutes les orientations sur tablette (géré dans AppSpacing).
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  await setupDependencies();

  runApp(const PrioriseApp());

  // Sync widgets after the app is fully running to avoid MissingPluginException
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final isar = getIt<DatabaseService>().isar;
    
    // Initial update
    WidgetService.updateAllWidgets().catchError((_) {});

    // Listen to all task and role changes to automatically refresh home widgets
    isar.tasks.watchLazy().listen((_) {
      WidgetService.updateAllWidgets().catchError((_) {});
    });
    isar.lifeRoles.watchLazy().listen((_) {
      WidgetService.updateAllWidgets().catchError((_) {});
    });
  });
}

class PrioriseApp extends StatelessWidget {
  const PrioriseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => SettingsCubit()),
        BlocProvider(create: (_) => MockAiCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Priorise',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: themeMode,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            initialRoute: AppRoutes.splash,
            onGenerateRoute: generateRoute,
          );
        },
      ),
    );
  }
}
