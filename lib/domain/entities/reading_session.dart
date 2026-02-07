import 'package:isar/isar.dart';

part 'reading_session.g.dart';

@Collection()
class ReadingSession {
  Id id = Isar.autoIncrement;

  @Index()
  int documentId = 0;

  late DateTime startTimestamp;
  DateTime? endTimestamp;
  int totalActiveMilliseconds = 0;
  int currentWordIndex = 0;
  int totalWords = 0;
  bool isCompleted = false;

  @ignore
  List<String> words = [];
}
