import 'package:isar/isar.dart';

part 'source_document.g.dart';

@Collection()
class SourceDocument {
  Id id = Isar.autoIncrement;

  @Index()
  late String title;

  late String content;

  @Index()
  late DateTime dateAdded;

  int lastPosition = 0;
}