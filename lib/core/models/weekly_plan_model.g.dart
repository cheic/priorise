// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_plan_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWeeklyPlanCollection on Isar {
  IsarCollection<WeeklyPlan> get weeklyPlans => this.collection();
}

const WeeklyPlanSchema = CollectionSchema(
  name: r'WeeklyPlan',
  id: -6471466353767935358,
  properties: {
    r'bigRocks': PropertySchema(
      id: 0,
      name: r'bigRocks',
      type: IsarType.objectList,
      target: r'BigRock',
    ),
    r'validated': PropertySchema(
      id: 1,
      name: r'validated',
      type: IsarType.bool,
    ),
    r'validatedAt': PropertySchema(
      id: 2,
      name: r'validatedAt',
      type: IsarType.dateTime,
    ),
    r'weekStart': PropertySchema(
      id: 3,
      name: r'weekStart',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _weeklyPlanEstimateSize,
  serialize: _weeklyPlanSerialize,
  deserialize: _weeklyPlanDeserialize,
  deserializeProp: _weeklyPlanDeserializeProp,
  idName: r'id',
  indexes: {
    r'weekStart': IndexSchema(
      id: 6730028936290595099,
      name: r'weekStart',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'weekStart',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'BigRock': BigRockSchema},
  getId: _weeklyPlanGetId,
  getLinks: _weeklyPlanGetLinks,
  attach: _weeklyPlanAttach,
  version: '3.1.0+1',
);

int _weeklyPlanEstimateSize(
  WeeklyPlan object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.bigRocks.length * 3;
  {
    final offsets = allOffsets[BigRock]!;
    for (var i = 0; i < object.bigRocks.length; i++) {
      final value = object.bigRocks[i];
      bytesCount += BigRockSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _weeklyPlanSerialize(
  WeeklyPlan object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<BigRock>(
    offsets[0],
    allOffsets,
    BigRockSchema.serialize,
    object.bigRocks,
  );
  writer.writeBool(offsets[1], object.validated);
  writer.writeDateTime(offsets[2], object.validatedAt);
  writer.writeDateTime(offsets[3], object.weekStart);
}

WeeklyPlan _weeklyPlanDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WeeklyPlan();
  object.bigRocks = reader.readObjectList<BigRock>(
        offsets[0],
        BigRockSchema.deserialize,
        allOffsets,
        BigRock(),
      ) ??
      [];
  object.id = id;
  object.validated = reader.readBool(offsets[1]);
  object.validatedAt = reader.readDateTimeOrNull(offsets[2]);
  object.weekStart = reader.readDateTime(offsets[3]);
  return object;
}

P _weeklyPlanDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<BigRock>(
            offset,
            BigRockSchema.deserialize,
            allOffsets,
            BigRock(),
          ) ??
          []) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _weeklyPlanGetId(WeeklyPlan object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _weeklyPlanGetLinks(WeeklyPlan object) {
  return [];
}

void _weeklyPlanAttach(IsarCollection<dynamic> col, Id id, WeeklyPlan object) {
  object.id = id;
}

extension WeeklyPlanByIndex on IsarCollection<WeeklyPlan> {
  Future<WeeklyPlan?> getByWeekStart(DateTime weekStart) {
    return getByIndex(r'weekStart', [weekStart]);
  }

  WeeklyPlan? getByWeekStartSync(DateTime weekStart) {
    return getByIndexSync(r'weekStart', [weekStart]);
  }

  Future<bool> deleteByWeekStart(DateTime weekStart) {
    return deleteByIndex(r'weekStart', [weekStart]);
  }

  bool deleteByWeekStartSync(DateTime weekStart) {
    return deleteByIndexSync(r'weekStart', [weekStart]);
  }

  Future<List<WeeklyPlan?>> getAllByWeekStart(List<DateTime> weekStartValues) {
    final values = weekStartValues.map((e) => [e]).toList();
    return getAllByIndex(r'weekStart', values);
  }

  List<WeeklyPlan?> getAllByWeekStartSync(List<DateTime> weekStartValues) {
    final values = weekStartValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'weekStart', values);
  }

  Future<int> deleteAllByWeekStart(List<DateTime> weekStartValues) {
    final values = weekStartValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'weekStart', values);
  }

  int deleteAllByWeekStartSync(List<DateTime> weekStartValues) {
    final values = weekStartValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'weekStart', values);
  }

  Future<Id> putByWeekStart(WeeklyPlan object) {
    return putByIndex(r'weekStart', object);
  }

  Id putByWeekStartSync(WeeklyPlan object, {bool saveLinks = true}) {
    return putByIndexSync(r'weekStart', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByWeekStart(List<WeeklyPlan> objects) {
    return putAllByIndex(r'weekStart', objects);
  }

  List<Id> putAllByWeekStartSync(List<WeeklyPlan> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'weekStart', objects, saveLinks: saveLinks);
  }
}

extension WeeklyPlanQueryWhereSort
    on QueryBuilder<WeeklyPlan, WeeklyPlan, QWhere> {
  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterWhere> anyWeekStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'weekStart'),
      );
    });
  }
}

extension WeeklyPlanQueryWhere
    on QueryBuilder<WeeklyPlan, WeeklyPlan, QWhereClause> {
  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterWhereClause> idBetween(
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

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterWhereClause> weekStartEqualTo(
      DateTime weekStart) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'weekStart',
        value: [weekStart],
      ));
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterWhereClause> weekStartNotEqualTo(
      DateTime weekStart) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'weekStart',
              lower: [],
              upper: [weekStart],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'weekStart',
              lower: [weekStart],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'weekStart',
              lower: [weekStart],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'weekStart',
              lower: [],
              upper: [weekStart],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterWhereClause> weekStartGreaterThan(
    DateTime weekStart, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'weekStart',
        lower: [weekStart],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterWhereClause> weekStartLessThan(
    DateTime weekStart, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'weekStart',
        lower: [],
        upper: [weekStart],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterWhereClause> weekStartBetween(
    DateTime lowerWeekStart,
    DateTime upperWeekStart, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'weekStart',
        lower: [lowerWeekStart],
        includeLower: includeLower,
        upper: [upperWeekStart],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WeeklyPlanQueryFilter
    on QueryBuilder<WeeklyPlan, WeeklyPlan, QFilterCondition> {
  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterFilterCondition>
      bigRocksLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bigRocks',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterFilterCondition>
      bigRocksIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bigRocks',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterFilterCondition>
      bigRocksIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bigRocks',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterFilterCondition>
      bigRocksLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bigRocks',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterFilterCondition>
      bigRocksLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bigRocks',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterFilterCondition>
      bigRocksLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'bigRocks',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterFilterCondition> idBetween(
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

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterFilterCondition> validatedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'validated',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterFilterCondition>
      validatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'validatedAt',
      ));
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterFilterCondition>
      validatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'validatedAt',
      ));
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterFilterCondition>
      validatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'validatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterFilterCondition>
      validatedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'validatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterFilterCondition>
      validatedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'validatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterFilterCondition>
      validatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'validatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterFilterCondition> weekStartEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weekStart',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterFilterCondition>
      weekStartGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weekStart',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterFilterCondition> weekStartLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weekStart',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterFilterCondition> weekStartBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weekStart',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension WeeklyPlanQueryObject
    on QueryBuilder<WeeklyPlan, WeeklyPlan, QFilterCondition> {
  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterFilterCondition> bigRocksElement(
      FilterQuery<BigRock> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'bigRocks');
    });
  }
}

extension WeeklyPlanQueryLinks
    on QueryBuilder<WeeklyPlan, WeeklyPlan, QFilterCondition> {}

extension WeeklyPlanQuerySortBy
    on QueryBuilder<WeeklyPlan, WeeklyPlan, QSortBy> {
  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterSortBy> sortByValidated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'validated', Sort.asc);
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterSortBy> sortByValidatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'validated', Sort.desc);
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterSortBy> sortByValidatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'validatedAt', Sort.asc);
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterSortBy> sortByValidatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'validatedAt', Sort.desc);
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterSortBy> sortByWeekStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekStart', Sort.asc);
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterSortBy> sortByWeekStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekStart', Sort.desc);
    });
  }
}

extension WeeklyPlanQuerySortThenBy
    on QueryBuilder<WeeklyPlan, WeeklyPlan, QSortThenBy> {
  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterSortBy> thenByValidated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'validated', Sort.asc);
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterSortBy> thenByValidatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'validated', Sort.desc);
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterSortBy> thenByValidatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'validatedAt', Sort.asc);
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterSortBy> thenByValidatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'validatedAt', Sort.desc);
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterSortBy> thenByWeekStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekStart', Sort.asc);
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QAfterSortBy> thenByWeekStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekStart', Sort.desc);
    });
  }
}

extension WeeklyPlanQueryWhereDistinct
    on QueryBuilder<WeeklyPlan, WeeklyPlan, QDistinct> {
  QueryBuilder<WeeklyPlan, WeeklyPlan, QDistinct> distinctByValidated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'validated');
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QDistinct> distinctByValidatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'validatedAt');
    });
  }

  QueryBuilder<WeeklyPlan, WeeklyPlan, QDistinct> distinctByWeekStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weekStart');
    });
  }
}

extension WeeklyPlanQueryProperty
    on QueryBuilder<WeeklyPlan, WeeklyPlan, QQueryProperty> {
  QueryBuilder<WeeklyPlan, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WeeklyPlan, List<BigRock>, QQueryOperations> bigRocksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bigRocks');
    });
  }

  QueryBuilder<WeeklyPlan, bool, QQueryOperations> validatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'validated');
    });
  }

  QueryBuilder<WeeklyPlan, DateTime?, QQueryOperations> validatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'validatedAt');
    });
  }

  QueryBuilder<WeeklyPlan, DateTime, QQueryOperations> weekStartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weekStart');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const BigRockSchema = Schema(
  name: r'BigRock',
  id: -2965807980543424613,
  properties: {
    r'achieved': PropertySchema(
      id: 0,
      name: r'achieved',
      type: IsarType.bool,
    ),
    r'roleId': PropertySchema(
      id: 1,
      name: r'roleId',
      type: IsarType.long,
    ),
    r'text': PropertySchema(
      id: 2,
      name: r'text',
      type: IsarType.string,
    )
  },
  estimateSize: _bigRockEstimateSize,
  serialize: _bigRockSerialize,
  deserialize: _bigRockDeserialize,
  deserializeProp: _bigRockDeserializeProp,
);

int _bigRockEstimateSize(
  BigRock object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.text.length * 3;
  return bytesCount;
}

void _bigRockSerialize(
  BigRock object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.achieved);
  writer.writeLong(offsets[1], object.roleId);
  writer.writeString(offsets[2], object.text);
}

BigRock _bigRockDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BigRock();
  object.achieved = reader.readBool(offsets[0]);
  object.roleId = reader.readLong(offsets[1]);
  object.text = reader.readString(offsets[2]);
  return object;
}

P _bigRockDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension BigRockQueryFilter
    on QueryBuilder<BigRock, BigRock, QFilterCondition> {
  QueryBuilder<BigRock, BigRock, QAfterFilterCondition> achievedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'achieved',
        value: value,
      ));
    });
  }

  QueryBuilder<BigRock, BigRock, QAfterFilterCondition> roleIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roleId',
        value: value,
      ));
    });
  }

  QueryBuilder<BigRock, BigRock, QAfterFilterCondition> roleIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'roleId',
        value: value,
      ));
    });
  }

  QueryBuilder<BigRock, BigRock, QAfterFilterCondition> roleIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'roleId',
        value: value,
      ));
    });
  }

  QueryBuilder<BigRock, BigRock, QAfterFilterCondition> roleIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'roleId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BigRock, BigRock, QAfterFilterCondition> textEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BigRock, BigRock, QAfterFilterCondition> textGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BigRock, BigRock, QAfterFilterCondition> textLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BigRock, BigRock, QAfterFilterCondition> textBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'text',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BigRock, BigRock, QAfterFilterCondition> textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BigRock, BigRock, QAfterFilterCondition> textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BigRock, BigRock, QAfterFilterCondition> textContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BigRock, BigRock, QAfterFilterCondition> textMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'text',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BigRock, BigRock, QAfterFilterCondition> textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<BigRock, BigRock, QAfterFilterCondition> textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'text',
        value: '',
      ));
    });
  }
}

extension BigRockQueryObject
    on QueryBuilder<BigRock, BigRock, QFilterCondition> {}
