// main.dart — Point d'entrée Priorise.
// Initialise les dépendances, puis lance MaterialApp en thème sombre/clair.
// Règle sécurité : aucun print(), aucune clé API ici.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/themes/app_theme.dart';

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
}

class PrioriseApp extends StatelessWidget {
  const PrioriseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Priorise',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: generateRoute,
    );
  }
}
