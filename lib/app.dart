import 'package:flutter/material.dart';
import 'package:rapid_read_v2/l10n/generated/app_localizations.dart';
import 'package:rapid_read_v2/core/router/app_router.dart';
import 'package:rapid_read_v2/core/theme/app_theme.dart';

/// The root widget of the application.
/// It sets up MaterialApp.router, connecting the app's theme, localization,
/// and routing. Keeping this separate from main.dart improves organization.
/// The `main.dart` file is responsible for initialization (the "how"), while
/// this widget is responsible for the app's configuration (the "what").
import 'package:provider/provider.dart';
import 'package:rapid_read_v2/presentation/providers/locale_provider.dart';

class RapidReadApp extends StatelessWidget {
  const RapidReadApp({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleProvider>().locale;

    return MaterialApp.router(
      title: 'RapidRead V2',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: AppRouter.router,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
