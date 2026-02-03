import 'package:isar/isar.dart';

part 'placeholder_schema.g.dart';

/// This is a placeholder schema to satisfy Isar's requirement for at least one
/// collection during initialization. It can be removed or replaced when
/// actual data models are created.
@collection
class PlaceholderSchema {
  Id id = Isar.autoIncrement;

  String? name;
}
