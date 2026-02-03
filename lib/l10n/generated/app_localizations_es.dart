// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'RapidRead V2';

  @override
  String get homeScreenTitle => 'Inicio';

  @override
  String get helloWorld => '¡Hola Mundo!';

  @override
  String get libraryScreenTitle => 'Biblioteca';

  @override
  String get importDocumentButton => 'Importar Documento';

  @override
  String get noDocumentsFound =>
      'No se encontraron documents. Importa un archivo para comenzar.';

  @override
  String get fileImportSuccess => '¡Archivo importado con éxito!';

  @override
  String get fileImportFailed => 'Falló la importación del archivo.';
}
