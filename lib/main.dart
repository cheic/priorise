// main.dart — Point d'entrée Priorise.
// Initialise les dépendances, puis lance MaterialApp en thème sombre/clair.
// Règle sécurité : aucun print(), aucune clé API ici.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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
import 'package:home_widget/home_widget.dart';
import 'shared/widgets/quick_capture_dialog.dart';

import 'package:priorise/core/services/secure_storage_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void _handleDeepLink(Uri uri) {
  if (navigatorKey.currentState == null) return;
  final context = navigatorKey.currentState!.context;
  
  if (uri.toString().contains('capture')) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const QuickCaptureDialog(),
    );
  } else {
    navigatorKey.currentState!.pushNamed(uri.toString());
  }
}

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await setupDependencies();
  
  final isFirstLaunch = await getIt<SecureStorageService>().isFirstLaunch();

  runApp(PrioriseApp(isFirstLaunch: isFirstLaunch));

  // Sync widgets after the app is fully running to avoid MissingPluginException
  WidgetsBinding.instance.addPostFrameCallback((_) {
    FlutterNativeSplash.remove();
    
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

    // Setup HomeWidget link handling
    HomeWidget.initiallyLaunchedFromHomeWidget().then((uri) {
      if (uri != null) {
        Future.delayed(const Duration(milliseconds: 500), () {
          _handleDeepLink(uri);
        });
      }
    });

    HomeWidget.widgetClicked.listen((uri) {
      if (uri != null) {
        _handleDeepLink(uri);
      }
    });
  });
}

class PrioriseApp extends StatelessWidget {
  final bool isFirstLaunch;

  const PrioriseApp({super.key, required this.isFirstLaunch});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => SettingsCubit(
          getSettingsUseCase: getIt(),
          saveSettingsUseCase: getIt(),
        )),
        BlocProvider(create: (_) => MockAiCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          final initialRoute = isFirstLaunch ? AppRoutes.onboarding : AppRoutes.today;

          return MaterialApp(
            title: 'Priorise',
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: themeMode,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            initialRoute: initialRoute,
            onGenerateInitialRoutes: (route) {
              return [generateRoute(RouteSettings(name: initialRoute))];
            },
            onGenerateRoute: generateRoute,
          );
        },
      ),
    );
  }
}
