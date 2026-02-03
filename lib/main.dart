import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapid_read_v2/app.dart';
import 'package:rapid_read_v2/data/services/service_locator.dart';
import 'package:rapid_read_v2/presentation/providers/locale_provider.dart';

/// The entry point of the application.
/// This function is responsible for initializing critical services before the
/// app runs. This follows the Single Responsibility Principle, as main's only
/// job is to set up the environment.
///
/// It ensures that:
/// 1. Flutter engine is initialized.
/// 2. The service locator is set up for dependency injection.
/// 3. The root widget `RapidReadApp` is run.
Future<void> main() async {
  // Ensures that widget binding is initialized before any async operations.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the service locator.
  await setupServiceLocator();

  runApp(
    /// Provider is used for state management and dependency injection.
    /// By wrapping the app in `MultiProvider`, we can inject dependencies
    /// and promote a decoupled architecture.
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),

        // Example of a ProxyProvider for a repository.
        // It depends on another provider to be created.
        // ProxyProvider is useful for dependencies that rely on other providers.
        //
        // ProxyProvider<Isar, MyRepository>(
        //   update: (context, isar, previous) => MyRepository(isar),
        // ),
      ],
      child: const RapidReadApp(),
    ),
  );
}
