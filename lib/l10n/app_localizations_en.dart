// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Priorise';

  @override
  String get tagline => 'ESSENTIALS FIRST';

  @override
  String get today => 'Today';

  @override
  String get skip => 'Skip';

  @override
  String get next => 'Next';

  @override
  String get start => 'Get started';

  @override
  String get delete => 'Delete';

  @override
  String get later => 'Later';

  @override
  String get allow => 'Allow';

  @override
  String get notifications => 'Notifications';

  @override
  String get notificationPermissionText =>
      'Priorise needs to send you notifications for gentle reminders (once a day max) and for your weekly planning session.\n\nDo you allow the app to send you notifications?';

  @override
  String get month1 => '1 month';

  @override
  String get months3 => '3 months';

  @override
  String get months6 => '6 months';

  @override
  String get year1 => '1 year';

  @override
  String get navToday => 'Today';

  @override
  String get navRoles => 'Roles';

  @override
  String get navPriorise => 'Priorise';

  @override
  String get navReview => 'Review';

  @override
  String get hello => 'Hello';

  @override
  String get eyebrowRoles => 'WHAT YOU EMBODY';

  @override
  String get titleRoles => 'Life roles';

  @override
  String get eyebrowMatrix => 'WHERE YOUR ATTENTION GOES';

  @override
  String get titleMatrix => 'Matrix';

  @override
  String get eyebrowReview => 'CONTINUOUS IMPROVEMENT';

  @override
  String get titleReview => 'Review';

  @override
  String get sideRailSubtitle => 'Priority management';

  @override
  String get sideRailSection => 'The app';

  @override
  String get sideRailQuote =>
      '\"It\'s not your schedule that should dictate your priorities — it\'s your priorities that should dictate your schedule.\"';

  @override
  String get onb1Title => 'Not just another todo-list';

  @override
  String get onb1Desc =>
      'Priorise follows a simple principle: what\'s important comes before what\'s urgent. Not the other way around.';

  @override
  String get onb2Title => 'Organize by roles';

  @override
  String get onb2Desc =>
      'Parent, professional, friend — your tasks relate to who you are, not to anonymous lists.';

  @override
  String get onb3Title => 'One big rock per week';

  @override
  String get onb3Desc =>
      'Every Sunday, choose a single priority per role. The rest fits around it, never before.';

  @override
  String get onb4Title => 'No guilt, no score';

  @override
  String get onb4Desc =>
      'No streaks, no grades. Just an honest mirror, week after week.';

  @override
  String get weeklyStones => 'Your weekly big rocks';

  @override
  String get todayPriority => 'Your priority, today';

  @override
  String get restOfWeek => 'The rest of the week';

  @override
  String get quadrantLabel => 'Quadrant II';

  @override
  String get emptyFocus => 'No Big Rock defined.\nOpen planning to set one.';

  @override
  String get noTasksYet => 'No tasks for this week';

  @override
  String get addTaskHint => 'Add a task…';

  @override
  String get weekNotPlanned => 'Week not planned';

  @override
  String get planWeek => 'Plan';

  @override
  String get settingsEyebrow => 'YOUR WORKSHOP';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get sectionProfile => 'Profile';

  @override
  String get myMission => 'My mission';

  @override
  String get myMissionSub => 'Reviewed and edited occasionally, not every week';

  @override
  String get weekPlanning => 'Weekly planning';

  @override
  String get weekPlanningSub => 'Sunday ritual — 20 minutes';

  @override
  String get sectionAppearance => 'Appearance';

  @override
  String get gentleReminders => 'Gentle reminders';

  @override
  String get gentleRemindersSub => 'One notification per day, no more';

  @override
  String get sectionAI => 'Artificial Intelligence';

  @override
  String get enableAISuggestions => 'Enable AI suggestions';

  @override
  String get enableAISuggestionsSub =>
      'Task breakdown, weekly review assistance';

  @override
  String get aiProvider => 'Provider';

  @override
  String get apiKey => 'API Key';

  @override
  String get testConnection => 'Test connection';

  @override
  String get connectionSuccess => 'Connection successful!';

  @override
  String get enterApiKey => 'Please enter an API key.';

  @override
  String get securityNote =>
      'Your key is stored only on this device. Nothing is sent to a Priorise server — your requests go directly from your phone to your chosen provider.';

  @override
  String get providerChangedMsg =>
      'Provider changed. Don\'t forget to enter your new API key.';

  @override
  String get themeAuto => 'Auto Theme';

  @override
  String get themeLight => 'Light Theme';

  @override
  String get themeDark => 'Dark Theme';

  @override
  String get themeAutoShort => 'Auto';

  @override
  String get themeLightShort => 'Light';

  @override
  String get themeDarkShort => 'Dark';

  @override
  String get sectionAbout => 'About';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get privacyPolicyText =>
      '1. Local-First and Personal Data\nPriorise is built on a \"Local-First\" architecture. This means ALL your data (roles, tasks, missions) is stored exclusively and locally on your device. We do not own any database servers, we do not perform telemetry, and we do not sell any personal information.\n\n2. Artificial Intelligence (AI) Features\nPriorise offers AI-based assistance features. To function, the application communicates directly from your device to the API of the selected AI provider (e.g., OpenAI or Anthropic) using your own API key.\n- No data passes through our servers.\n- Requests sent to the AI contain only the context strictly necessary for the requested assistance.\n- Please refer to the privacy policy of the chosen AI provider regarding the retention and use of your requests.\n\n3. API Keys\nYour API key is securely stored and encrypted only on your device. We have no access to it.\n\n4. Your Rights (GDPR)\nSince we do not collect any personal data on remote servers, you have full control over your data. You can exercise your right to complete erasure (right to be forgotten) simply by uninstalling the application or clearing the application data from your device settings.';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get termsOfServiceText =>
      '1. Acceptance of Terms\nBy using Priorise, you agree to be bound by these terms. Priorise is a personal productivity tool operating primarily offline.\n\n2. Use of Artificial Intelligence (Bring Your Own Key)\nCertain features of Priorise require the use of a third-party API (OpenAI, Anthropic, etc.). The user agrees to provide their own valid API key.\n- You are solely responsible for any costs and fees billed by your API provider.\n- You are responsible for securing your API key. We disclaim any liability in the event of a leak or compromise of your key due to a security breach on your device.\n\n3. AI-Generated Content\nThe suggestions and prioritizations generated by the AI are provided for informational purposes. The AI may generate inaccurate information. You are the sole judge and responsible for the organization of your tasks.\n\n4. Liability\nThe application is provided \"as is\", without warranties of any kind. We cannot be held liable for any data loss (since your data is stored locally), service interruption, or indirect damages related to the use of the application.\n\n5. Intellectual Property\nThe code, design, logo, and graphical elements of Priorise remain our exclusive property.';

  @override
  String get userGuide => 'User Guide';

  @override
  String get userGuideText =>
      'Welcome to the Priorise philosophy. Here are 4 steps to regain control of your time:\n\n1. Define your Life Roles\nYou are much more than just your profession. Parent, creator, friend, athlete... Declare your different Roles. Every task you accomplish will be tied to one of these facets, ensuring a healthy personal balance.\n\n2. Empty your mind\nAs soon as an obligation arises, use the \"+\" button to note it instantly. Don\'t categorize it right away. The goal is to reduce your mental load.\n\n3. The compass before the clock\nTake 10 minutes every Sunday to distribute your essential tasks for the week among your different roles. This ritual ensures that you are moving in the right direction, rather than racing against the clock.\n\n4. The Decision Matrix\nDaily, drag your tasks into the 4 zones of the Matrix:\n• Important and Urgent: Crises to handle immediately.\n• Important, Not Urgent: The progress zone (your true goals). This is the core of the app. Spend as much time here as possible.\n• Not Important, Urgent: Interruptions. Delegate or limit them.\n• Not Important, Not Urgent: Distractions. Eliminate them.';

  @override
  String get appVersion => 'App version';

  @override
  String get yourRoles => 'YOUR LIFE ROLES';

  @override
  String get mainRole => 'Primary role';

  @override
  String get addRole => 'Add a role';

  @override
  String get editRole => 'Edit role';

  @override
  String get roleName => 'Role name';

  @override
  String get roleNameHint => 'E.g. Community, Creativity...';

  @override
  String get cancel => 'Cancel';

  @override
  String get createRole => 'Create role';

  @override
  String get saveRole => 'Save';

  @override
  String get colorBrass => 'Brass';

  @override
  String get colorSage => 'Sage';

  @override
  String get colorClay => 'Clay';

  @override
  String get colorSlate => 'Slate';

  @override
  String get colorAmethyst => 'Amethyst';

  @override
  String get colorMoss => 'Moss';

  @override
  String get reminderScheduled => 'Review reminder scheduled';

  @override
  String get schedule => 'Schedule';

  @override
  String get importantUrgent => 'Important + Urgent';

  @override
  String get importantNotUrgent => 'Important + Not Urgent';

  @override
  String get notImportantUrgent => 'Not Important + Urgent';

  @override
  String get notImportantNotUrgent => 'Not Important + Not Urgent';

  @override
  String get synthesize => 'Synthesize with AI';

  @override
  String get whatWorked => 'What worked';

  @override
  String get whatSlipped => 'What slipped';

  @override
  String get quickCapture => 'Quick capture';

  @override
  String get quickCaptureHint => 'What\'s on your mind?';

  @override
  String get add => 'Add';

  @override
  String get captureTask => 'Capture task';

  @override
  String get editTask => 'Edit task';

  @override
  String get whatLabel => 'What';

  @override
  String get taskHint => 'E.g. Call the plumber';

  @override
  String get roleLabel => 'Role';

  @override
  String get noRolesDefined =>
      'No roles defined yet.\nGo to the Roles tab to create one before adding a task.';

  @override
  String get priorityMatrixLabel => 'Priority (Matrix)';

  @override
  String get selectPriority => 'Select a priority';

  @override
  String get priorityStrategic => 'Strategic / To plan';

  @override
  String get priorityUrgent => 'Urgent and Important';

  @override
  String get priorityDelegate => 'Distraction / To delegate';

  @override
  String get priorityEliminate => 'Useless / To eliminate';

  @override
  String get taskAdded => 'Task added to your day';

  @override
  String get taskUpdated => 'Task updated';

  @override
  String get deleteRoleTitle => 'Delete role?';

  @override
  String deleteRoleDesc(String roleName) {
    return 'Are you sure you want to delete \"$roleName\"?';
  }

  @override
  String get deleteTaskTitle => 'Delete task?';

  @override
  String deleteTaskDesc(String taskName) {
    return 'Are you sure you want to delete \"$taskName\"?';
  }

  @override
  String get matrixInfoTitle => 'Eisenhower Matrix';

  @override
  String get matrixInfoDesc =>
      'A simple method to visualize where your attention really goes.';

  @override
  String get matrixInfoQ1Title => 'Do (Urgent & Important)';

  @override
  String get matrixInfoQ1Desc =>
      'Top left. What cannot wait. To be handled immediately.';

  @override
  String get matrixInfoQ2Title => 'Schedule (Important, Not urgent)';

  @override
  String get matrixInfoQ2Desc =>
      'Top right. The real foundational work that advances your goals.';

  @override
  String get matrixInfoQ3Title => 'Delegate (Urgent, Not important)';

  @override
  String get matrixInfoQ3Desc =>
      'Bottom left. Interruptions and false emergencies. Delegate if possible.';

  @override
  String get matrixInfoQ4Title => 'Drop (Not urgent, Not important)';

  @override
  String get matrixInfoQ4Desc =>
      'Bottom right. Distractions and the hidden cost of your time.';

  @override
  String get understood => 'Understood';

  @override
  String get planReview => 'Schedule a review';

  @override
  String get planReviewDesc =>
      'A mission is rarely reviewed, but deliberately so. Choose a deadline — you\'ll receive a one-time reminder, not a recurring notification.';

  @override
  String get inTime => 'IN';

  @override
  String get iconLabel => 'Icon';

  @override
  String get colorLabel => 'Color';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get january => 'January';

  @override
  String get february => 'February';

  @override
  String get march => 'March';

  @override
  String get april => 'April';

  @override
  String get may => 'May';

  @override
  String get june => 'June';

  @override
  String get july => 'July';

  @override
  String get august => 'August';

  @override
  String get september => 'September';

  @override
  String get october => 'October';

  @override
  String get november => 'November';

  @override
  String get december => 'December';
}
