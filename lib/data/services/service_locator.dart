import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rapid_read_v2/data/services/import_service.dart';
import 'package:rapid_read_v2/domain/entities/source_document.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [SourceDocumentSchema],
    directory: dir.path,
  );

  getIt.registerSingleton<Isar>(isar);
  getIt.registerLazySingleton<ImportService>(() => ImportService(getIt<Isar>()));
}
