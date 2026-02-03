// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_session.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetReadingSessionCollection on Isar {
  IsarCollection<ReadingSession> get readingSessions => this.collection();
}

const ReadingSessionSchema = CollectionSchema(
  name: r'ReadingSession',
  id: -2237521196892654814,
  properties: {
    r'endTimestamp': PropertySchema(
      id: 0,
      name: r'endTimestamp',
      type: IsarType.dateTime,
    ),
    r'startTimestamp': PropertySchema(
      id: 1,
      name: r'startTimestamp',
      type: IsarType.dateTime,
    ),
    r'totalActiveMilliseconds': PropertySchema(
      id: 2,
      name: r'totalActiveMilliseconds',
      type: IsarType.long,
    )
  },
  estimateSize: _readingSessionEstimateSize,
  serialize: _readingSessionSerialize,
  deserialize: _readingSessionDeserialize,
  deserializeProp: _readingSessionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _readingSessionGetId,
  getLinks: _readingSessionGetLinks,
  attach: _readingSessionAttach,
  version: '3.1.0+1',
);

int _readingSessionEstimateSize(
  ReadingSession object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _readingSessionSerialize(
  ReadingSession object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.endTimestamp);
  writer.writeDateTime(offsets[1], object.startTimestamp);
  writer.writeLong(offsets[2], object.totalActiveMilliseconds);
}

ReadingSession _readingSessionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ReadingSession();
  object.endTimestamp = reader.readDateTimeOrNull(offsets[0]);
  object.id = id;
  object.startTimestamp = reader.readDateTime(offsets[1]);
  object.totalActiveMilliseconds = reader.readLong(offsets[2]);
  return object;
}

P _readingSessionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _readingSessionGetId(ReadingSession object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _readingSessionGetLinks(ReadingSession object) {
  return [];
}

void _readingSessionAttach(
    IsarCollection<dynamic> col, Id id, ReadingSession object) {
  object.id = id;
}

extension ReadingSessionQueryWhereSort
    on QueryBuilder<ReadingSession, ReadingSession, QWhere> {
  QueryBuilder<ReadingSession, ReadingSession, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ReadingSessionQueryWhere
    on QueryBuilder<ReadingSession, ReadingSession, QWhereClause> {
  QueryBuilder<ReadingSession, ReadingSession, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ReadingSessionQueryFilter
    on QueryBuilder<ReadingSession, ReadingSession, QFilterCondition> {
  QueryBuilder<ReadingSession, ReadingSession, QAfterFilterCondition>
      endTimestampIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endTimestamp',
      ));
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterFilterCondition>
      endTimestampIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endTimestamp',
      ));
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterFilterCondition>
      endTimestampEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterFilterCondition>
      endTimestampGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterFilterCondition>
      endTimestampLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterFilterCondition>
      endTimestampBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endTimestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterFilterCondition>
      startTimestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterFilterCondition>
      startTimestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterFilterCondition>
      startTimestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startTimestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterFilterCondition>
      startTimestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startTimestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterFilterCondition>
      totalActiveMillisecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalActiveMilliseconds',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterFilterCondition>
      totalActiveMillisecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalActiveMilliseconds',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterFilterCondition>
      totalActiveMillisecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalActiveMilliseconds',
        value: value,
      ));
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterFilterCondition>
      totalActiveMillisecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalActiveMilliseconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ReadingSessionQueryObject
    on QueryBuilder<ReadingSession, ReadingSession, QFilterCondition> {}

extension ReadingSessionQueryLinks
    on QueryBuilder<ReadingSession, ReadingSession, QFilterCondition> {}

extension ReadingSessionQuerySortBy
    on QueryBuilder<ReadingSession, ReadingSession, QSortBy> {
  QueryBuilder<ReadingSession, ReadingSession, QAfterSortBy>
      sortByEndTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTimestamp', Sort.asc);
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterSortBy>
      sortByEndTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTimestamp', Sort.desc);
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterSortBy>
      sortByStartTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimestamp', Sort.asc);
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterSortBy>
      sortByStartTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimestamp', Sort.desc);
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterSortBy>
      sortByTotalActiveMilliseconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalActiveMilliseconds', Sort.asc);
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterSortBy>
      sortByTotalActiveMillisecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalActiveMilliseconds', Sort.desc);
    });
  }
}

extension ReadingSessionQuerySortThenBy
    on QueryBuilder<ReadingSession, ReadingSession, QSortThenBy> {
  QueryBuilder<ReadingSession, ReadingSession, QAfterSortBy>
      thenByEndTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTimestamp', Sort.asc);
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterSortBy>
      thenByEndTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTimestamp', Sort.desc);
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterSortBy>
      thenByStartTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimestamp', Sort.asc);
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterSortBy>
      thenByStartTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTimestamp', Sort.desc);
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterSortBy>
      thenByTotalActiveMilliseconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalActiveMilliseconds', Sort.asc);
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QAfterSortBy>
      thenByTotalActiveMillisecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalActiveMilliseconds', Sort.desc);
    });
  }
}

extension ReadingSessionQueryWhereDistinct
    on QueryBuilder<ReadingSession, ReadingSession, QDistinct> {
  QueryBuilder<ReadingSession, ReadingSession, QDistinct>
      distinctByEndTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endTimestamp');
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QDistinct>
      distinctByStartTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTimestamp');
    });
  }

  QueryBuilder<ReadingSession, ReadingSession, QDistinct>
      distinctByTotalActiveMilliseconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalActiveMilliseconds');
    });
  }
}

extension ReadingSessionQueryProperty
    on QueryBuilder<ReadingSession, ReadingSession, QQueryProperty> {
  QueryBuilder<ReadingSession, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ReadingSession, DateTime?, QQueryOperations>
      endTimestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endTimestamp');
    });
  }

  QueryBuilder<ReadingSession, DateTime, QQueryOperations>
      startTimestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTimestamp');
    });
  }

  QueryBuilder<ReadingSession, int, QQueryOperations>
      totalActiveMillisecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalActiveMilliseconds');
    });
  }
}
