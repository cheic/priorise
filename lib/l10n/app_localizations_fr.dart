// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Priorise';

  @override
  String get tagline => 'L\'ESSENTIEL D\'ABORD';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get skip => 'Passer';

  @override
  String get next => 'Suivant';

  @override
  String get start => 'Commencer';

  @override
  String get delete => 'Supprimer';

  @override
  String get later => 'Plus tard';

  @override
  String get allow => 'Autoriser';

  @override
  String get notifications => 'Notifications';

  @override
  String get notificationPermissionText =>
      'Priorise a besoin de vous envoyer des notifications pour vos rappels doux (une fois par jour maximum) et pour votre session de planification hebdomadaire.\n\nAutorisez-vous l\'application à vous envoyer des notifications ?';

  @override
  String get month1 => '1 mois';

  @override
  String get months3 => '3 mois';

  @override
  String get months6 => '6 mois';

  @override
  String get year1 => '1 an';

  @override
  String get navToday => 'Aujourd\'hui';

  @override
  String get navRoles => 'Rôles';

  @override
  String get navPriorise => 'Priorise';

  @override
  String get navReview => 'Bilan';

  @override
  String get hello => 'Bonjour';

  @override
  String get eyebrowRoles => 'CE QUE VOUS INCARNEZ';

  @override
  String get titleRoles => 'Rôles de vie';

  @override
  String get eyebrowMatrix => 'OÙ VA VOTRE ATTENTION';

  @override
  String get titleMatrix => 'Matrice';

  @override
  String get eyebrowReview => 'AMÉLIORATION CONTINUE';

  @override
  String get titleReview => 'Bilan';

  @override
  String get sideRailSubtitle => 'Gestion des priorités';

  @override
  String get sideRailSection => 'L\'application';

  @override
  String get sideRailQuote =>
      '« Concentrez votre énergie sur ce qui compte vraiment. Le reste suivra naturellement. »';

  @override
  String get onb1Title => 'Pas une todo-list de plus';

  @override
  String get onb1Desc =>
      'Priorise part d\'un principe simple : ce qui est important passe avant ce qui est urgent. Pas l\'inverse.';

  @override
  String get onb2Title => 'Organisez-vous par rôles';

  @override
  String get onb2Desc =>
      'Parent, professionnel, ami — vos tâches se rattachent à qui vous êtes, pas à des listes anonymes.';

  @override
  String get onb3Title => 'Un objectif majeur par semaine';

  @override
  String get onb3Desc =>
      'Chaque dimanche, choisissez une seule priorité par rôle. Le reste se glisse autour, jamais avant.';

  @override
  String get onb4Title => 'Sans culpabilité, sans score';

  @override
  String get onb4Desc =>
      'Pas de streaks, pas de notes chiffrées. Juste un miroir honnête, semaine après semaine.';

  @override
  String get weeklyStones => 'Vos objectifs de la semaine';

  @override
  String get todayPriority => 'Votre priorité, aujourd\'hui';

  @override
  String get restOfWeek => 'Le reste de la semaine';

  @override
  String get quadrantLabel => 'Focus Majeur';

  @override
  String get emptyFocus =>
      'Aucun objectif majeur défini.\nOuvrez la planification.';

  @override
  String get noTasksYet => 'Aucune tâche pour cette semaine';

  @override
  String get addTaskHint => 'Ajouter une tâche…';

  @override
  String get weekNotPlanned => 'Semaine non planifiée';

  @override
  String get planWeek => 'Planifier';

  @override
  String get missionEyebrow => 'CE QUI VOUS GUIDE';

  @override
  String get missionTitle => 'Mission';

  @override
  String get missionDeclaration => 'VOTRE DÉCLARATION';

  @override
  String get missionHint1 =>
      'Qui voulez-vous être, dans vos rôles les plus importants ?';

  @override
  String get missionHint2 =>
      'Qu\'est-ce que vous voulez accomplir, et pour qui ?';

  @override
  String get missionHint3 => 'Sur quels principes refusez-vous de transiger ?';

  @override
  String get missionUpdated => 'Mission mise à jour';

  @override
  String get edit => 'Modifier';

  @override
  String lastModified(String day, String month, String nextMonth) {
    return 'Modifiée le $day $month · prochaine révision programmée pour $nextMonth';
  }

  @override
  String get settingsEyebrow => 'VOTRE ATELIER';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get sectionProfile => 'Profil';

  @override
  String get myMission => 'Ma mission';

  @override
  String get myMissionSub =>
      'Consultée et modifiée occasionnellement, pas chaque semaine';

  @override
  String get weekPlanning => 'Planification de la semaine';

  @override
  String get weekPlanningSub => 'Rituel du dimanche — 20 minutes';

  @override
  String get sectionAppearance => 'Apparence';

  @override
  String get gentleReminders => 'Rappels doux';

  @override
  String get gentleRemindersSub =>
      'Une seule notification par jour, jamais plus';

  @override
  String get sectionAI => 'Intelligence artificielle';

  @override
  String get enableAISuggestions => 'Activer les suggestions IA';

  @override
  String get enableAISuggestionsSub =>
      'Décomposition de tâches, aide au bilan hebdo';

  @override
  String get aiProvider => 'Fournisseur';

  @override
  String get apiKey => 'Clé API';

  @override
  String get testConnection => 'Tester la connexion';

  @override
  String get connectionSuccess => 'Connexion réussie !';

  @override
  String get enterApiKey => 'Veuillez entrer une clé API.';

  @override
  String get securityNote =>
      'Votre clé reste stockée uniquement sur cet appareil. Rien n\'est envoyé à un serveur Priorise — vos requêtes vont directement du téléphone vers le fournisseur choisi.';

  @override
  String get weekReviewedToast =>
      'Votre bilan est enregistré. En avant pour la suite.';

  @override
  String get matrixImportanceLabel => 'IMPORTANCE ↑';

  @override
  String get matrixUrgenceLabel => 'URGENCE →';

  @override
  String get planWeeklyRitual => 'RITUEL HEBDOMADAIRE';

  @override
  String get planDuration => 'DIMANCHE, 20 MINUTES';

  @override
  String get planQuote =>
      'Les grosses pierres d\'abord — le reste trouve toujours sa place.';

  @override
  String get planRolesTitle => 'UNE PIERRE, PAR RÔLE';

  @override
  String get planRoleHint => 'Quelle est la seule chose qui compte ?';

  @override
  String get titlePlan => 'Planification';

  @override
  String get seeMyMission => 'Voir ma mission';

  @override
  String get aiSynthesisFailed => 'L\'IA n\'a pas pu synthétiser ce point.';

  @override
  String get providerChangedMsg =>
      'Fournisseur modifié. N\'oubliez pas d\'entrer votre nouvelle clé API.';

  @override
  String get themeAuto => 'Thème Automatique';

  @override
  String get themeLight => 'Thème Clair';

  @override
  String get themeDark => 'Thème Sombre';

  @override
  String get themeAutoShort => 'Auto';

  @override
  String get themeLightShort => 'Clair';

  @override
  String get themeDarkShort => 'Sombre';

  @override
  String get sectionAbout => 'À propos';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get privacyPolicyText =>
      '1. Local-First et Données Personnelles\nPriorise est conçue sur une architecture \"Local-First\". Cela signifie que TOUTES vos données (rôles, tâches, missions) sont stockées exclusivement et localement sur votre appareil. Nous ne possédons aucun serveur de base de données, n\'effectuons aucune télémétrie, et ne revendons aucune information personnelle.\n\n2. Fonctionnalités d\'Intelligence Artificielle (IA)\nPriorise propose des fonctionnalités d\'assistance basées sur l\'IA. Pour fonctionner, l\'application communique directement depuis votre appareil vers l\'API du fournisseur d\'IA sélectionné (par exemple, OpenAI ou Anthropic) en utilisant votre propre clé API.\n- Aucune donnée ne transite par nos serveurs.\n- Les requêtes envoyées à l\'IA ne contiennent que le contexte strictement nécessaire à l\'assistance demandée.\n- Veuillez vous référer à la politique de confidentialité du fournisseur d\'IA choisi concernant la rétention et l\'utilisation de vos requêtes.\n\n3. Clés API\nVotre clé API est stockée de manière sécurisée et chiffrée uniquement sur votre appareil. Nous n\'y avons aucun accès.\n\n4. Vos droits (RGPD)\nPuisque nous ne collectons aucune donnée personnelle sur des serveurs distants, le contrôle de vos données vous appartient entièrement. Vous pouvez exercer votre droit à l\'effacement total (droit à l\'oubli) simplement en désinstallant l\'application ou en effaçant les données de l\'application depuis les paramètres de votre appareil.';

  @override
  String get termsOfService => 'Conditions Générales d\'Utilisation';

  @override
  String get termsOfServiceText =>
      '1. Acceptation des Conditions\nEn utilisant Priorise, vous acceptez d\'être lié par les présentes conditions. Priorise est un outil de productivité personnel fonctionnant principalement hors ligne.\n\n2. Utilisation de l\'Intelligence Artificielle (Bring Your Own Key)\nCertaines fonctionnalités de Priorise nécessitent l\'utilisation d\'une API tierce (OpenAI, Anthropic, etc.). L\'utilisateur s\'engage à fournir sa propre clé API valide.\n- Vous êtes seul responsable des coûts et frais facturés par votre fournisseur d\'API.\n- Vous êtes responsable de la sécurisation de votre clé API. Nous déclinons toute responsabilité en cas de fuite ou de compromission de votre clé due à une faille de sécurité sur votre appareil.\n\n3. Contenu Généré par l\'IA\nLes suggestions et priorisations générées par l\'IA sont fournies à titre indicatif. L\'IA peut générer des informations inexactes. Vous êtes seul juge et responsable de l\'organisation de vos tâches.\n\n4. Responsabilité\nL\'application est fournie \"telle quelle\", sans garantie d\'aucune sorte. Nous ne pourrons être tenus responsables d\'aucune perte de données (vos données étant stockées localement), interruption de service, ou dommage indirect lié à l\'utilisation de l\'application.\n\n5. Propriété Intellectuelle\nLe code, le design, le logo et les éléments graphiques de Priorise restent notre propriété exclusive.';

  @override
  String get userGuide => 'Guide d\'utilisation';

  @override
  String get userGuideText =>
      'Bienvenue dans la philosophie Priorise. Voici 4 étapes pour reprendre le contrôle de votre temps :\n\n1. Définissez vos Rôles de Vie\nVous êtes bien plus que votre simple profession. Parent, créateur, ami, sportif... Déclarez vos différents Rôles. Chaque tâche que vous accomplirez sera reliée à une de ces facettes, garantissant un équilibre personnel sain.\n\n2. Videz votre esprit\nDès qu\'une obligation surgit, utilisez le bouton « + » pour la noter instantanément. Ne la classez pas tout de suite. L\'objectif est de réduire votre charge mentale.\n\n3. La direction avant la vitesse\nPrenez 10 minutes chaque dimanche pour répartir vos tâches essentielles de la semaine entre vos différents rôles. Ce rituel garantit que vous avancez dans la bonne direction, plutôt que de courir contre la montre.\n\n4. La Matrice de Décision\nAu quotidien, glissez vos tâches dans les 4 zones de la Matrice :\n• Important et Urgent : Les crises à gérer immédiatement.\n• Important, Pas Urgent : La zone de progression (vos vrais objectifs). C\'est le cœur de l\'application. Passez-y un maximum de temps.\n• Pas Important, Urgent : Les interruptions. À déléguer ou limiter.\n• Pas Important, Pas Urgent : Les distractions. À éliminer.';

  @override
  String get appVersion => 'Version de l\'application';

  @override
  String get yourRoles => 'VOS RÔLES DE VIE';

  @override
  String get mainRole => 'Rôle principal';

  @override
  String get addRole => 'Ajouter un rôle';

  @override
  String get editRole => 'Modifier le rôle';

  @override
  String get roleName => 'Nom du rôle';

  @override
  String get roleNameHint => 'Ex. Communauté, Créativité...';

  @override
  String get cancel => 'Annuler';

  @override
  String get createRole => 'Créer le rôle';

  @override
  String get saveRole => 'Enregistrer';

  @override
  String get colorBrass => 'Laiton';

  @override
  String get colorSage => 'Sauge';

  @override
  String get colorClay => 'Argile';

  @override
  String get colorSlate => 'Ardoise';

  @override
  String get colorAmethyst => 'Améthyste';

  @override
  String get colorMoss => 'Mousse';

  @override
  String get colorOcean => 'Océan';

  @override
  String get colorSand => 'Sable';

  @override
  String get colorRose => 'Rose';

  @override
  String get colorPine => 'Pin';

  @override
  String get reminderScheduled => 'Rappel de révision programmé';

  @override
  String get schedule => 'Programmer';

  @override
  String get dailyReminderTitle => 'Priorité du jour';

  @override
  String get dailyReminderBody =>
      'N\'oubliez pas votre objectif principal aujourd\'hui.';

  @override
  String get somethingWentWrong => 'Quelque chose s\'est mal passé.';

  @override
  String get importantUrgent => 'Important + Urgent';

  @override
  String get importantNotUrgent => 'Important + Non Urgent';

  @override
  String get notImportantUrgent => 'Non Important + Urgent';

  @override
  String get notImportantNotUrgent => 'Non Important + Non Urgent';

  @override
  String get synthesize => 'Synthétiser avec l\'IA';

  @override
  String get whatWorked => 'Ce qui a marché';

  @override
  String get whatSlipped => 'Ce qui a dérapé';

  @override
  String get quickCapture => 'Capture rapide';

  @override
  String get quickCaptureHint => 'Qu\'avez-vous en tête ?';

  @override
  String get add => 'Ajouter';

  @override
  String get captureTask => 'Capturer une tâche';

  @override
  String get editTask => 'Modifier la tâche';

  @override
  String get whatLabel => 'Quoi';

  @override
  String get taskHint => 'Ex. Rappeler le plombier';

  @override
  String get roleLabel => 'Rôle';

  @override
  String get noRolesDefined =>
      'Aucun rôle n\'a encore été défini.\nAllez dans l\'onglet Rôles pour en créer un avant d\'ajouter une tâche.';

  @override
  String get noRolesEmptyState => 'Aucun rôle n\'a encore été défini.';

  @override
  String get priorityMatrixLabel => 'Priorité (Matrice)';

  @override
  String get selectPriority => 'Sélectionner une priorité';

  @override
  String get priorityStrategic => 'Stratégique / À planifier';

  @override
  String get priorityUrgent => 'Urgent et Important';

  @override
  String get priorityDelegate => 'Distraction / À déléguer';

  @override
  String get priorityEliminate => 'Inutile / À éliminer';

  @override
  String get taskAdded => 'Tâche ajoutée à votre journée';

  @override
  String get taskUpdated => 'Tâche modifiée';

  @override
  String get deleteRoleTitle => 'Supprimer le rôle ?';

  @override
  String deleteRoleDesc(String roleName) {
    return 'Êtes-vous sûr de vouloir supprimer \"$roleName\" ?';
  }

  @override
  String get deleteTaskTitle => 'Supprimer la tâche ?';

  @override
  String deleteTaskDesc(String taskName) {
    return 'Êtes-vous sûr de vouloir supprimer \"$taskName\" ?';
  }

  @override
  String get matrixInfoTitle => 'Matrice des Priorités';

  @override
  String get matrixInfoDesc =>
      'Une méthode simple pour visualiser où va vraiment votre attention.';

  @override
  String get matrixInfoQ1Title => 'Agir (Urgent & Important)';

  @override
  String get matrixInfoQ1Desc =>
      'En haut à gauche. Ce qui ne peut pas attendre. À traiter immédiatement.';

  @override
  String get matrixInfoQ2Title => 'Planifier (Important, Non urgent)';

  @override
  String get matrixInfoQ2Desc =>
      'En haut à droite. Le vrai travail de fond, celui qui fait avancer vos objectifs.';

  @override
  String get matrixInfoQ3Title => 'Déléguer (Urgent, Non important)';

  @override
  String get matrixInfoQ3Desc =>
      'En bas à gauche. Les interruptions et fausses urgences. À confier si possible.';

  @override
  String get matrixInfoQ4Title => 'Laisser filer (Ni urgent ni important)';

  @override
  String get matrixInfoQ4Desc =>
      'En bas à droite. Les distractions et le coût caché de votre temps.';

  @override
  String get matrixLegendQ1Title => 'Agir';

  @override
  String get matrixLegendQ1Desc =>
      'Important & urgent — ce qui ne peut pas attendre';

  @override
  String get matrixLegendQ2Title => 'Planifier';

  @override
  String get matrixLegendQ2Desc =>
      'Important, non urgent — le vrai travail de fond';

  @override
  String get matrixLegendQ3Title => 'Déléguer';

  @override
  String get matrixLegendQ3Desc =>
      'Urgent, peu important — à confier si possible';

  @override
  String get matrixLegendQ4Title => 'Laisser filer';

  @override
  String get matrixLegendQ4Desc =>
      'Ni urgent ni important — le coût caché de votre temps';

  @override
  String get understood => 'Compris';

  @override
  String get planReview => 'Planifier une révision';

  @override
  String get planReviewDesc =>
      'Une mission se révise rarement, mais délibérément. Choisissez une échéance — vous recevrez un rappel unique, pas une notification récurrente.';

  @override
  String get inTime => 'DANS';

  @override
  String get iconLabel => 'Icône';

  @override
  String get colorLabel => 'Couleur';

  @override
  String get monday => 'Lundi';

  @override
  String get tuesday => 'Mardi';

  @override
  String get wednesday => 'Mercredi';

  @override
  String get thursday => 'Jeudi';

  @override
  String get friday => 'Vendredi';

  @override
  String get saturday => 'Samedi';

  @override
  String get sunday => 'Dimanche';

  @override
  String get january => 'janvier';

  @override
  String get february => 'février';

  @override
  String get march => 'mars';

  @override
  String get april => 'avril';

  @override
  String get may => 'mai';

  @override
  String get june => 'juin';

  @override
  String get july => 'juillet';

  @override
  String get august => 'août';

  @override
  String get september => 'septembre';

  @override
  String get october => 'octobre';

  @override
  String get november => 'novembre';

  @override
  String get december => 'décembre';

  @override
  String get noRoleDefinedYet => 'Aucun rôle défini pour l\'instant.';

  @override
  String get yourPrioriseThisWeek => 'VOTRE PRIORISE, CETTE SEMAINE';

  @override
  String get allOtherTasksDone => 'Toutes les autres tâches sont accomplies !';

  @override
  String get noOtherTasks => 'Aucune autre tâche planifiée pour le moment.';

  @override
  String get synthesizing => 'Synthèse en cours...';

  @override
  String get synthesizeWithAI => 'Synthétiser avec l\'IA (optionnel)';

  @override
  String get attentionByRole => 'Attention portée, par rôle';

  @override
  String get attentionByRoleDesc =>
      'Calculé automatiquement à partir des tâches et objectifs cochés cette semaine — rien à remplir ici.';

  @override
  String get reviewMirrorText =>
      'Pas de score. Juste un miroir, pour ajuster la semaine prochaine.';

  @override
  String get reviewListenAdjust => 'S\'écouter, puis ajuster';

  @override
  String get reviewQuestion =>
      'Comment vous sentez-vous par rapport à cette semaine ? Qu\'est-ce qui a bien fonctionné, qu\'est-ce qui a coincé ?';

  @override
  String get writeFreelyHint => 'Écrivez librement...';

  @override
  String get reviewQuestion1 =>
      'Quel objectif majeur a réellement trouvé sa place ?';

  @override
  String get reviewHint1 =>
      'Ex: Le dîner sans téléphone — deux soirs sur trois.';

  @override
  String get reviewQuestion2 =>
      'Qu\'est-ce qui a pris la place d\'une priorité, cette semaine ?';

  @override
  String get reviewHint2 =>
      'Ex: Les urgences du lundi ont grignoté le créneau...';

  @override
  String get reviewSubtitle => 'Un temps d\'arrêt pour observer vos actions.';

  @override
  String get enableAISuggestionsFirst => 'Activez d\'abord les suggestions IA';

  @override
  String get configureValidApiKey => 'Veuillez configurer une clé API valide';

  @override
  String get aiSynthesisComplete => 'Synthèse IA terminée !';

  @override
  String get connectionFailureCheckKey =>
      'Échec de la connexion. Vérifiez la clé API.';

  @override
  String get enterAnApiKey => 'Veuillez entrer une clé API.';

  @override
  String get connectionSuccessful => 'Connexion réussie !';

  @override
  String get validateMyWeek => 'Valider ma semaine';

  @override
  String get postponeTaskTitle => 'Reporter la tâche ?';

  @override
  String postponeTaskDesc(String taskName) {
    return 'Voulez-vous reporter \"$taskName\" à la semaine prochaine ?';
  }

  @override
  String get postpone => 'Reporter';

  @override
  String get planPunctualTasksTitle => 'TÂCHES PONCTUELLES (GRAVIER)';

  @override
  String get planAddPunctualTask => 'Ajouter une tâche ponctuelle';
}
