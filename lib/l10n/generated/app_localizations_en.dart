// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'RapidRead V2';

  @override
  String get homeScreenTitle => 'Home';

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get libraryScreenTitle => 'Library';

  @override
  String get importDocumentButton => 'Import Document';

  @override
  String get noDocumentsFound =>
      'No documents found. Import a file to get started.';

  @override
  String get fileImportSuccess => 'File imported successfully!';

  @override
  String get fileImportFailed => 'File import failed.';
}
