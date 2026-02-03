import 'package:isar/isar.dart';

part 'reading_session.g.dart';

@Collection()
class ReadingSession {
  Id id = Isar.autoIncrement;

  late DateTime startTimestamp;
  DateTime? endTimestamp;
  int totalActiveMilliseconds = 0;

  @ignore
  List<String> words = [];
}
