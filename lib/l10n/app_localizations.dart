import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// Nom de l'application
  ///
  /// In fr, this message translates to:
  /// **'Priorise'**
  String get appName;

  /// Accroche splash
  ///
  /// In fr, this message translates to:
  /// **'L\'ESSENTIEL D\'ABORD'**
  String get tagline;

  /// Onglet aujourd'hui
  ///
  /// In fr, this message translates to:
  /// **'Aujourd\'hui'**
  String get today;

  /// Bouton passer onboarding
  ///
  /// In fr, this message translates to:
  /// **'Passer'**
  String get skip;

  /// Bouton suivant onboarding
  ///
  /// In fr, this message translates to:
  /// **'Suivant'**
  String get next;

  /// Bouton final onboarding
  ///
  /// In fr, this message translates to:
  /// **'Commencer'**
  String get start;

  /// No description provided for @delete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get delete;

  /// No description provided for @later.
  ///
  /// In fr, this message translates to:
  /// **'Plus tard'**
  String get later;

  /// No description provided for @allow.
  ///
  /// In fr, this message translates to:
  /// **'Autoriser'**
  String get allow;

  /// No description provided for @notifications.
  ///
  /// In fr, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationPermissionText.
  ///
  /// In fr, this message translates to:
  /// **'Priorise a besoin de vous envoyer des notifications pour vos rappels doux (une fois par jour maximum) et pour votre session de planification hebdomadaire.\n\nAutorisez-vous l\'application à vous envoyer des notifications ?'**
  String get notificationPermissionText;

  /// No description provided for @month1.
  ///
  /// In fr, this message translates to:
  /// **'1 mois'**
  String get month1;

  /// No description provided for @months3.
  ///
  /// In fr, this message translates to:
  /// **'3 mois'**
  String get months3;

  /// No description provided for @months6.
  ///
  /// In fr, this message translates to:
  /// **'6 mois'**
  String get months6;

  /// No description provided for @year1.
  ///
  /// In fr, this message translates to:
  /// **'1 an'**
  String get year1;

  /// No description provided for @navToday.
  ///
  /// In fr, this message translates to:
  /// **'Aujourd\'hui'**
  String get navToday;

  /// No description provided for @navRoles.
  ///
  /// In fr, this message translates to:
  /// **'Rôles'**
  String get navRoles;

  /// No description provided for @navPriorise.
  ///
  /// In fr, this message translates to:
  /// **'Priorise'**
  String get navPriorise;

  /// No description provided for @navReview.
  ///
  /// In fr, this message translates to:
  /// **'Bilan'**
  String get navReview;

  /// No description provided for @hello.
  ///
  /// In fr, this message translates to:
  /// **'Bonjour'**
  String get hello;

  /// No description provided for @eyebrowRoles.
  ///
  /// In fr, this message translates to:
  /// **'CE QUE VOUS INCARNEZ'**
  String get eyebrowRoles;

  /// No description provided for @titleRoles.
  ///
  /// In fr, this message translates to:
  /// **'Rôles de vie'**
  String get titleRoles;

  /// No description provided for @eyebrowMatrix.
  ///
  /// In fr, this message translates to:
  /// **'OÙ VA VOTRE ATTENTION'**
  String get eyebrowMatrix;

  /// No description provided for @titleMatrix.
  ///
  /// In fr, this message translates to:
  /// **'Matrice'**
  String get titleMatrix;

  /// No description provided for @eyebrowReview.
  ///
  /// In fr, this message translates to:
  /// **'AMÉLIORATION CONTINUE'**
  String get eyebrowReview;

  /// No description provided for @titleReview.
  ///
  /// In fr, this message translates to:
  /// **'Bilan'**
  String get titleReview;

  /// No description provided for @sideRailSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Gestion des priorités'**
  String get sideRailSubtitle;

  /// No description provided for @sideRailSection.
  ///
  /// In fr, this message translates to:
  /// **'L\'application'**
  String get sideRailSection;

  /// No description provided for @sideRailQuote.
  ///
  /// In fr, this message translates to:
  /// **'« Ce n\'est pas votre agenda qui doit dicter vos priorités — ce sont vos priorités qui doivent dicter votre agenda. »'**
  String get sideRailQuote;

  /// No description provided for @onb1Title.
  ///
  /// In fr, this message translates to:
  /// **'Pas une todo-list de plus'**
  String get onb1Title;

  /// No description provided for @onb1Desc.
  ///
  /// In fr, this message translates to:
  /// **'Priorise part d\'un principe simple : ce qui est important passe avant ce qui est urgent. Pas l\'inverse.'**
  String get onb1Desc;

  /// No description provided for @onb2Title.
  ///
  /// In fr, this message translates to:
  /// **'Organisez-vous par rôles'**
  String get onb2Title;

  /// No description provided for @onb2Desc.
  ///
  /// In fr, this message translates to:
  /// **'Parent, professionnel, ami — vos tâches se rattachent à qui vous êtes, pas à des listes anonymes.'**
  String get onb2Desc;

  /// No description provided for @onb3Title.
  ///
  /// In fr, this message translates to:
  /// **'Une grosse pierre par semaine'**
  String get onb3Title;

  /// No description provided for @onb3Desc.
  ///
  /// In fr, this message translates to:
  /// **'Chaque dimanche, choisissez une seule priorité par rôle. Le reste se glisse autour, jamais avant.'**
  String get onb3Desc;

  /// No description provided for @onb4Title.
  ///
  /// In fr, this message translates to:
  /// **'Sans culpabilité, sans score'**
  String get onb4Title;

  /// No description provided for @onb4Desc.
  ///
  /// In fr, this message translates to:
  /// **'Pas de streaks, pas de notes chiffrées. Juste un miroir honnête, semaine après semaine.'**
  String get onb4Desc;

  /// No description provided for @weeklyStones.
  ///
  /// In fr, this message translates to:
  /// **'Vos pierres de la semaine'**
  String get weeklyStones;

  /// No description provided for @todayPriority.
  ///
  /// In fr, this message translates to:
  /// **'Votre priorité, aujourd\'hui'**
  String get todayPriority;

  /// No description provided for @restOfWeek.
  ///
  /// In fr, this message translates to:
  /// **'Le reste de la semaine'**
  String get restOfWeek;

  /// No description provided for @quadrantLabel.
  ///
  /// In fr, this message translates to:
  /// **'Quadrant II'**
  String get quadrantLabel;

  /// No description provided for @emptyFocus.
  ///
  /// In fr, this message translates to:
  /// **'Aucune Grosse Pierre définie.\nOuvrez la planification.'**
  String get emptyFocus;

  /// No description provided for @noTasksYet.
  ///
  /// In fr, this message translates to:
  /// **'Aucune tâche pour cette semaine'**
  String get noTasksYet;

  /// No description provided for @addTaskHint.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une tâche…'**
  String get addTaskHint;

  /// No description provided for @weekNotPlanned.
  ///
  /// In fr, this message translates to:
  /// **'Semaine non planifiée'**
  String get weekNotPlanned;

  /// No description provided for @planWeek.
  ///
  /// In fr, this message translates to:
  /// **'Planifier'**
  String get planWeek;

  /// No description provided for @settingsEyebrow.
  ///
  /// In fr, this message translates to:
  /// **'VOTRE ATELIER'**
  String get settingsEyebrow;

  /// No description provided for @settingsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get settingsTitle;

  /// No description provided for @sectionProfile.
  ///
  /// In fr, this message translates to:
  /// **'Profil'**
  String get sectionProfile;

  /// No description provided for @myMission.
  ///
  /// In fr, this message translates to:
  /// **'Ma mission'**
  String get myMission;

  /// No description provided for @myMissionSub.
  ///
  /// In fr, this message translates to:
  /// **'Consultée et modifiée occasionnellement, pas chaque semaine'**
  String get myMissionSub;

  /// No description provided for @weekPlanning.
  ///
  /// In fr, this message translates to:
  /// **'Planification de la semaine'**
  String get weekPlanning;

  /// No description provided for @weekPlanningSub.
  ///
  /// In fr, this message translates to:
  /// **'Rituel du dimanche — 20 minutes'**
  String get weekPlanningSub;

  /// No description provided for @sectionAppearance.
  ///
  /// In fr, this message translates to:
  /// **'Apparence'**
  String get sectionAppearance;

  /// No description provided for @gentleReminders.
  ///
  /// In fr, this message translates to:
  /// **'Rappels doux'**
  String get gentleReminders;

  /// No description provided for @gentleRemindersSub.
  ///
  /// In fr, this message translates to:
  /// **'Une seule notification par jour, jamais plus'**
  String get gentleRemindersSub;

  /// No description provided for @sectionAI.
  ///
  /// In fr, this message translates to:
  /// **'Intelligence artificielle'**
  String get sectionAI;

  /// No description provided for @enableAISuggestions.
  ///
  /// In fr, this message translates to:
  /// **'Activer les suggestions IA'**
  String get enableAISuggestions;

  /// No description provided for @enableAISuggestionsSub.
  ///
  /// In fr, this message translates to:
  /// **'Décomposition de tâches, aide au bilan hebdo'**
  String get enableAISuggestionsSub;

  /// No description provided for @aiProvider.
  ///
  /// In fr, this message translates to:
  /// **'Fournisseur'**
  String get aiProvider;

  /// No description provided for @apiKey.
  ///
  /// In fr, this message translates to:
  /// **'Clé API'**
  String get apiKey;

  /// No description provided for @testConnection.
  ///
  /// In fr, this message translates to:
  /// **'Tester la connexion'**
  String get testConnection;

  /// No description provided for @connectionSuccess.
  ///
  /// In fr, this message translates to:
  /// **'Connexion réussie !'**
  String get connectionSuccess;

  /// No description provided for @enterApiKey.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer une clé API.'**
  String get enterApiKey;

  /// No description provided for @securityNote.
  ///
  /// In fr, this message translates to:
  /// **'Votre clé reste stockée uniquement sur cet appareil. Rien n\'est envoyé à un serveur Priorise — vos requêtes vont directement du téléphone vers le fournisseur choisi.'**
  String get securityNote;

  /// No description provided for @providerChangedMsg.
  ///
  /// In fr, this message translates to:
  /// **'Fournisseur modifié. N\'oubliez pas d\'entrer votre nouvelle clé API.'**
  String get providerChangedMsg;

  /// No description provided for @themeAuto.
  ///
  /// In fr, this message translates to:
  /// **'Thème Automatique'**
  String get themeAuto;

  /// No description provided for @themeLight.
  ///
  /// In fr, this message translates to:
  /// **'Thème Clair'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In fr, this message translates to:
  /// **'Thème Sombre'**
  String get themeDark;

  /// No description provided for @themeAutoShort.
  ///
  /// In fr, this message translates to:
  /// **'Auto'**
  String get themeAutoShort;

  /// No description provided for @themeLightShort.
  ///
  /// In fr, this message translates to:
  /// **'Clair'**
  String get themeLightShort;

  /// No description provided for @themeDarkShort.
  ///
  /// In fr, this message translates to:
  /// **'Sombre'**
  String get themeDarkShort;

  /// No description provided for @sectionAbout.
  ///
  /// In fr, this message translates to:
  /// **'À propos'**
  String get sectionAbout;

  /// No description provided for @privacyPolicy.
  ///
  /// In fr, this message translates to:
  /// **'Politique de confidentialité'**
  String get privacyPolicy;

  /// No description provided for @privacyPolicyText.
  ///
  /// In fr, this message translates to:
  /// **'Priorise est conçue autour du respect de votre temps et de vos données.\n\nToutes vos tâches, rôles et paramètres sont stockés localement sur votre appareil. Aucune donnée personnelle n\'est collectée, analysée ou revendue à des tiers.\n\nSi vous utilisez les suggestions IA, seules les requêtes anonymisées sont envoyées au fournisseur que vous avez configuré (avec votre propre clé API).\n\nEn résumé : vos données vous appartiennent, totalement et exclusivement.'**
  String get privacyPolicyText;

  /// No description provided for @appVersion.
  ///
  /// In fr, this message translates to:
  /// **'Version de l\'application'**
  String get appVersion;

  /// No description provided for @yourRoles.
  ///
  /// In fr, this message translates to:
  /// **'VOS RÔLES DE VIE'**
  String get yourRoles;

  /// No description provided for @mainRole.
  ///
  /// In fr, this message translates to:
  /// **'Rôle principal'**
  String get mainRole;

  /// No description provided for @addRole.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un rôle'**
  String get addRole;

  /// No description provided for @editRole.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le rôle'**
  String get editRole;

  /// No description provided for @roleName.
  ///
  /// In fr, this message translates to:
  /// **'Nom du rôle'**
  String get roleName;

  /// No description provided for @roleNameHint.
  ///
  /// In fr, this message translates to:
  /// **'Ex. Communauté, Créativité...'**
  String get roleNameHint;

  /// No description provided for @cancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get cancel;

  /// No description provided for @createRole.
  ///
  /// In fr, this message translates to:
  /// **'Créer le rôle'**
  String get createRole;

  /// No description provided for @saveRole.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer'**
  String get saveRole;

  /// No description provided for @colorBrass.
  ///
  /// In fr, this message translates to:
  /// **'Laiton'**
  String get colorBrass;

  /// No description provided for @colorSage.
  ///
  /// In fr, this message translates to:
  /// **'Sauge'**
  String get colorSage;

  /// No description provided for @colorClay.
  ///
  /// In fr, this message translates to:
  /// **'Argile'**
  String get colorClay;

  /// No description provided for @colorSlate.
  ///
  /// In fr, this message translates to:
  /// **'Ardoise'**
  String get colorSlate;

  /// No description provided for @colorAmethyst.
  ///
  /// In fr, this message translates to:
  /// **'Améthyste'**
  String get colorAmethyst;

  /// No description provided for @colorMoss.
  ///
  /// In fr, this message translates to:
  /// **'Mousse'**
  String get colorMoss;

  /// No description provided for @reminderScheduled.
  ///
  /// In fr, this message translates to:
  /// **'Rappel de révision programmé'**
  String get reminderScheduled;

  /// No description provided for @schedule.
  ///
  /// In fr, this message translates to:
  /// **'Programmer'**
  String get schedule;

  /// No description provided for @importantUrgent.
  ///
  /// In fr, this message translates to:
  /// **'Important + Urgent'**
  String get importantUrgent;

  /// No description provided for @importantNotUrgent.
  ///
  /// In fr, this message translates to:
  /// **'Important + Non Urgent'**
  String get importantNotUrgent;

  /// No description provided for @notImportantUrgent.
  ///
  /// In fr, this message translates to:
  /// **'Non Important + Urgent'**
  String get notImportantUrgent;

  /// No description provided for @notImportantNotUrgent.
  ///
  /// In fr, this message translates to:
  /// **'Non Important + Non Urgent'**
  String get notImportantNotUrgent;

  /// No description provided for @synthesize.
  ///
  /// In fr, this message translates to:
  /// **'Synthétiser avec l\'IA'**
  String get synthesize;

  /// No description provided for @whatWorked.
  ///
  /// In fr, this message translates to:
  /// **'Ce qui a marché'**
  String get whatWorked;

  /// No description provided for @whatSlipped.
  ///
  /// In fr, this message translates to:
  /// **'Ce qui a dérapé'**
  String get whatSlipped;

  /// No description provided for @quickCapture.
  ///
  /// In fr, this message translates to:
  /// **'Capture rapide'**
  String get quickCapture;

  /// No description provided for @quickCaptureHint.
  ///
  /// In fr, this message translates to:
  /// **'Qu\'avez-vous en tête ?'**
  String get quickCaptureHint;

  /// No description provided for @add.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get add;

  /// No description provided for @captureTask.
  ///
  /// In fr, this message translates to:
  /// **'Capturer une tâche'**
  String get captureTask;

  /// No description provided for @editTask.
  ///
  /// In fr, this message translates to:
  /// **'Modifier la tâche'**
  String get editTask;

  /// No description provided for @whatLabel.
  ///
  /// In fr, this message translates to:
  /// **'Quoi'**
  String get whatLabel;

  /// No description provided for @taskHint.
  ///
  /// In fr, this message translates to:
  /// **'Ex. Rappeler le plombier'**
  String get taskHint;

  /// No description provided for @roleLabel.
  ///
  /// In fr, this message translates to:
  /// **'Rôle'**
  String get roleLabel;

  /// No description provided for @noRolesDefined.
  ///
  /// In fr, this message translates to:
  /// **'Aucun rôle n\'a encore été défini.\nAllez dans l\'onglet Rôles pour en créer un avant d\'ajouter une tâche.'**
  String get noRolesDefined;

  /// No description provided for @priorityMatrixLabel.
  ///
  /// In fr, this message translates to:
  /// **'Priorité (Matrice)'**
  String get priorityMatrixLabel;

  /// No description provided for @selectPriority.
  ///
  /// In fr, this message translates to:
  /// **'Sélectionner une priorité'**
  String get selectPriority;

  /// No description provided for @priorityStrategic.
  ///
  /// In fr, this message translates to:
  /// **'Stratégique / À planifier'**
  String get priorityStrategic;

  /// No description provided for @priorityUrgent.
  ///
  /// In fr, this message translates to:
  /// **'Urgent et Important'**
  String get priorityUrgent;

  /// No description provided for @priorityDelegate.
  ///
  /// In fr, this message translates to:
  /// **'Distraction / À déléguer'**
  String get priorityDelegate;

  /// No description provided for @priorityEliminate.
  ///
  /// In fr, this message translates to:
  /// **'Inutile / À éliminer'**
  String get priorityEliminate;

  /// No description provided for @taskAdded.
  ///
  /// In fr, this message translates to:
  /// **'Tâche ajoutée à votre journée'**
  String get taskAdded;

  /// No description provided for @taskUpdated.
  ///
  /// In fr, this message translates to:
  /// **'Tâche modifiée'**
  String get taskUpdated;

  /// No description provided for @deleteRoleTitle.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer le rôle ?'**
  String get deleteRoleTitle;

  /// No description provided for @deleteRoleDesc.
  ///
  /// In fr, this message translates to:
  /// **'Êtes-vous sûr de vouloir supprimer \"{roleName}\" ?'**
  String deleteRoleDesc(String roleName);

  /// No description provided for @deleteTaskTitle.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer la tâche ?'**
  String get deleteTaskTitle;

  /// No description provided for @deleteTaskDesc.
  ///
  /// In fr, this message translates to:
  /// **'Êtes-vous sûr de vouloir supprimer \"{taskName}\" ?'**
  String deleteTaskDesc(String taskName);

  /// No description provided for @matrixInfoTitle.
  ///
  /// In fr, this message translates to:
  /// **'Matrice d\'Eisenhower'**
  String get matrixInfoTitle;

  /// No description provided for @matrixInfoDesc.
  ///
  /// In fr, this message translates to:
  /// **'Une méthode simple pour visualiser où va vraiment votre attention.'**
  String get matrixInfoDesc;

  /// No description provided for @matrixInfoQ1Title.
  ///
  /// In fr, this message translates to:
  /// **'Agir (Urgent & Important)'**
  String get matrixInfoQ1Title;

  /// No description provided for @matrixInfoQ1Desc.
  ///
  /// In fr, this message translates to:
  /// **'En haut à gauche. Ce qui ne peut pas attendre. À traiter immédiatement.'**
  String get matrixInfoQ1Desc;

  /// No description provided for @matrixInfoQ2Title.
  ///
  /// In fr, this message translates to:
  /// **'Planifier (Important, Non urgent)'**
  String get matrixInfoQ2Title;

  /// No description provided for @matrixInfoQ2Desc.
  ///
  /// In fr, this message translates to:
  /// **'En haut à droite. Le vrai travail de fond, celui qui fait avancer vos objectifs.'**
  String get matrixInfoQ2Desc;

  /// No description provided for @matrixInfoQ3Title.
  ///
  /// In fr, this message translates to:
  /// **'Déléguer (Urgent, Non important)'**
  String get matrixInfoQ3Title;

  /// No description provided for @matrixInfoQ3Desc.
  ///
  /// In fr, this message translates to:
  /// **'En bas à gauche. Les interruptions et fausses urgences. À confier si possible.'**
  String get matrixInfoQ3Desc;

  /// No description provided for @matrixInfoQ4Title.
  ///
  /// In fr, this message translates to:
  /// **'Laisser filer (Ni urgent ni important)'**
  String get matrixInfoQ4Title;

  /// No description provided for @matrixInfoQ4Desc.
  ///
  /// In fr, this message translates to:
  /// **'En bas à droite. Les distractions et le coût caché de votre temps.'**
  String get matrixInfoQ4Desc;

  /// No description provided for @understood.
  ///
  /// In fr, this message translates to:
  /// **'Compris'**
  String get understood;

  /// No description provided for @planReview.
  ///
  /// In fr, this message translates to:
  /// **'Planifier une révision'**
  String get planReview;

  /// No description provided for @planReviewDesc.
  ///
  /// In fr, this message translates to:
  /// **'Une mission se révise rarement, mais délibérément. Choisissez une échéance — vous recevrez un rappel unique, pas une notification récurrente.'**
  String get planReviewDesc;

  /// No description provided for @inTime.
  ///
  /// In fr, this message translates to:
  /// **'DANS'**
  String get inTime;

  /// No description provided for @iconLabel.
  ///
  /// In fr, this message translates to:
  /// **'Icône'**
  String get iconLabel;

  /// No description provided for @colorLabel.
  ///
  /// In fr, this message translates to:
  /// **'Couleur'**
  String get colorLabel;

  /// No description provided for @monday.
  ///
  /// In fr, this message translates to:
  /// **'Lundi'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In fr, this message translates to:
  /// **'Mardi'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In fr, this message translates to:
  /// **'Mercredi'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In fr, this message translates to:
  /// **'Jeudi'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In fr, this message translates to:
  /// **'Vendredi'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In fr, this message translates to:
  /// **'Samedi'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In fr, this message translates to:
  /// **'Dimanche'**
  String get sunday;

  /// No description provided for @january.
  ///
  /// In fr, this message translates to:
  /// **'janvier'**
  String get january;

  /// No description provided for @february.
  ///
  /// In fr, this message translates to:
  /// **'février'**
  String get february;

  /// No description provided for @march.
  ///
  /// In fr, this message translates to:
  /// **'mars'**
  String get march;

  /// No description provided for @april.
  ///
  /// In fr, this message translates to:
  /// **'avril'**
  String get april;

  /// No description provided for @may.
  ///
  /// In fr, this message translates to:
  /// **'mai'**
  String get may;

  /// No description provided for @june.
  ///
  /// In fr, this message translates to:
  /// **'juin'**
  String get june;

  /// No description provided for @july.
  ///
  /// In fr, this message translates to:
  /// **'juillet'**
  String get july;

  /// No description provided for @august.
  ///
  /// In fr, this message translates to:
  /// **'août'**
  String get august;

  /// No description provided for @september.
  ///
  /// In fr, this message translates to:
  /// **'septembre'**
  String get september;

  /// No description provided for @october.
  ///
  /// In fr, this message translates to:
  /// **'octobre'**
  String get october;

  /// No description provided for @november.
  ///
  /// In fr, this message translates to:
  /// **'novembre'**
  String get november;

  /// No description provided for @december.
  ///
  /// In fr, this message translates to:
  /// **'décembre'**
  String get december;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
