// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_review_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWeeklyReviewCollection on Isar {
  IsarCollection<WeeklyReview> get weeklyReviews => this.collection();
}

const WeeklyReviewSchema = CollectionSchema(
  name: r'WeeklyReview',
  id: 1740939263748820166,
  properties: {
    r'aiSynthesis': PropertySchema(
      id: 0,
      name: r'aiSynthesis',
      type: IsarType.string,
    ),
    r'aiSynthesisGeneratedAt': PropertySchema(
      id: 1,
      name: r'aiSynthesisGeneratedAt',
      type: IsarType.dateTime,
    ),
    r'attentionByRole': PropertySchema(
      id: 2,
      name: r'attentionByRole',
      type: IsarType.objectList,
      target: r'RoleAttention',
    ),
    r'weekStart': PropertySchema(
      id: 3,
      name: r'weekStart',
      type: IsarType.dateTime,
    ),
    r'whatSlipped': PropertySchema(
      id: 4,
      name: r'whatSlipped',
      type: IsarType.string,
    ),
    r'whatWorked': PropertySchema(
      id: 5,
      name: r'whatWorked',
      type: IsarType.string,
    )
  },
  estimateSize: _weeklyReviewEstimateSize,
  serialize: _weeklyReviewSerialize,
  deserialize: _weeklyReviewDeserialize,
  deserializeProp: _weeklyReviewDeserializeProp,
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
  embeddedSchemas: {r'RoleAttention': RoleAttentionSchema},
  getId: _weeklyReviewGetId,
  getLinks: _weeklyReviewGetLinks,
  attach: _weeklyReviewAttach,
  version: '3.1.0+1',
);

int _weeklyReviewEstimateSize(
  WeeklyReview object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.aiSynthesis;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.attentionByRole.length * 3;
  {
    final offsets = allOffsets[RoleAttention]!;
    for (var i = 0; i < object.attentionByRole.length; i++) {
      final value = object.attentionByRole[i];
      bytesCount +=
          RoleAttentionSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  {
    final value = object.whatSlipped;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.whatWorked;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _weeklyReviewSerialize(
  WeeklyReview object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.aiSynthesis);
  writer.writeDateTime(offsets[1], object.aiSynthesisGeneratedAt);
  writer.writeObjectList<RoleAttention>(
    offsets[2],
    allOffsets,
    RoleAttentionSchema.serialize,
    object.attentionByRole,
  );
  writer.writeDateTime(offsets[3], object.weekStart);
  writer.writeString(offsets[4], object.whatSlipped);
  writer.writeString(offsets[5], object.whatWorked);
}

WeeklyReview _weeklyReviewDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WeeklyReview();
  object.aiSynthesis = reader.readStringOrNull(offsets[0]);
  object.aiSynthesisGeneratedAt = reader.readDateTimeOrNull(offsets[1]);
  object.attentionByRole = reader.readObjectList<RoleAttention>(
        offsets[2],
        RoleAttentionSchema.deserialize,
        allOffsets,
        RoleAttention(),
      ) ??
      [];
  object.id = id;
  object.weekStart = reader.readDateTime(offsets[3]);
  object.whatSlipped = reader.readStringOrNull(offsets[4]);
  object.whatWorked = reader.readStringOrNull(offsets[5]);
  return object;
}

P _weeklyReviewDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readObjectList<RoleAttention>(
            offset,
            RoleAttentionSchema.deserialize,
            allOffsets,
            RoleAttention(),
          ) ??
          []) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _weeklyReviewGetId(WeeklyReview object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _weeklyReviewGetLinks(WeeklyReview object) {
  return [];
}

void _weeklyReviewAttach(
    IsarCollection<dynamic> col, Id id, WeeklyReview object) {
  object.id = id;
}

extension WeeklyReviewByIndex on IsarCollection<WeeklyReview> {
  Future<WeeklyReview?> getByWeekStart(DateTime weekStart) {
    return getByIndex(r'weekStart', [weekStart]);
  }

  WeeklyReview? getByWeekStartSync(DateTime weekStart) {
    return getByIndexSync(r'weekStart', [weekStart]);
  }

  Future<bool> deleteByWeekStart(DateTime weekStart) {
    return deleteByIndex(r'weekStart', [weekStart]);
  }

  bool deleteByWeekStartSync(DateTime weekStart) {
    return deleteByIndexSync(r'weekStart', [weekStart]);
  }

  Future<List<WeeklyReview?>> getAllByWeekStart(
      List<DateTime> weekStartValues) {
    final values = weekStartValues.map((e) => [e]).toList();
    return getAllByIndex(r'weekStart', values);
  }

  List<WeeklyReview?> getAllByWeekStartSync(List<DateTime> weekStartValues) {
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

  Future<Id> putByWeekStart(WeeklyReview object) {
    return putByIndex(r'weekStart', object);
  }

  Id putByWeekStartSync(WeeklyReview object, {bool saveLinks = true}) {
    return putByIndexSync(r'weekStart', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByWeekStart(List<WeeklyReview> objects) {
    return putAllByIndex(r'weekStart', objects);
  }

  List<Id> putAllByWeekStartSync(List<WeeklyReview> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'weekStart', objects, saveLinks: saveLinks);
  }
}

extension WeeklyReviewQueryWhereSort
    on QueryBuilder<WeeklyReview, WeeklyReview, QWhere> {
  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhere> anyWeekStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'weekStart'),
      );
    });
  }
}

extension WeeklyReviewQueryWhere
    on QueryBuilder<WeeklyReview, WeeklyReview, QWhereClause> {
  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause> idBetween(
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

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause> weekStartEqualTo(
      DateTime weekStart) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'weekStart',
        value: [weekStart],
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause>
      weekStartNotEqualTo(DateTime weekStart) {
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

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause>
      weekStartGreaterThan(
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

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause> weekStartLessThan(
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

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterWhereClause> weekStartBetween(
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

extension WeeklyReviewQueryFilter
    on QueryBuilder<WeeklyReview, WeeklyReview, QFilterCondition> {
  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiSynthesisIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'aiSynthesis',
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiSynthesisIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'aiSynthesis',
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiSynthesisEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiSynthesis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiSynthesisGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aiSynthesis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiSynthesisLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aiSynthesis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiSynthesisBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aiSynthesis',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiSynthesisStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'aiSynthesis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiSynthesisEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'aiSynthesis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiSynthesisContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'aiSynthesis',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiSynthesisMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'aiSynthesis',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiSynthesisIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiSynthesis',
        value: '',
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiSynthesisIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aiSynthesis',
        value: '',
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiSynthesisGeneratedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'aiSynthesisGeneratedAt',
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiSynthesisGeneratedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'aiSynthesisGeneratedAt',
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiSynthesisGeneratedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiSynthesisGeneratedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiSynthesisGeneratedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aiSynthesisGeneratedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiSynthesisGeneratedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aiSynthesisGeneratedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      aiSynthesisGeneratedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aiSynthesisGeneratedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      attentionByRoleLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'attentionByRole',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      attentionByRoleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'attentionByRole',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      attentionByRoleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'attentionByRole',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      attentionByRoleLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'attentionByRole',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      attentionByRoleLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'attentionByRole',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      attentionByRoleLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'attentionByRole',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition> idBetween(
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

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      weekStartEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weekStart',
        value: value,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
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

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      weekStartLessThan(
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

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      weekStartBetween(
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

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      whatSlippedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'whatSlipped',
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      whatSlippedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'whatSlipped',
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      whatSlippedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'whatSlipped',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      whatSlippedGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'whatSlipped',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      whatSlippedLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'whatSlipped',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      whatSlippedBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'whatSlipped',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      whatSlippedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'whatSlipped',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      whatSlippedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'whatSlipped',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      whatSlippedContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'whatSlipped',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      whatSlippedMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'whatSlipped',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      whatSlippedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'whatSlipped',
        value: '',
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      whatSlippedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'whatSlipped',
        value: '',
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      whatWorkedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'whatWorked',
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      whatWorkedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'whatWorked',
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      whatWorkedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'whatWorked',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      whatWorkedGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'whatWorked',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      whatWorkedLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'whatWorked',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      whatWorkedBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'whatWorked',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      whatWorkedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'whatWorked',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      whatWorkedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'whatWorked',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      whatWorkedContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'whatWorked',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      whatWorkedMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'whatWorked',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      whatWorkedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'whatWorked',
        value: '',
      ));
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      whatWorkedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'whatWorked',
        value: '',
      ));
    });
  }
}

extension WeeklyReviewQueryObject
    on QueryBuilder<WeeklyReview, WeeklyReview, QFilterCondition> {
  QueryBuilder<WeeklyReview, WeeklyReview, QAfterFilterCondition>
      attentionByRoleElement(FilterQuery<RoleAttention> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'attentionByRole');
    });
  }
}

extension WeeklyReviewQueryLinks
    on QueryBuilder<WeeklyReview, WeeklyReview, QFilterCondition> {}

extension WeeklyReviewQuerySortBy
    on QueryBuilder<WeeklyReview, WeeklyReview, QSortBy> {
  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> sortByAiSynthesis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiSynthesis', Sort.asc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy>
      sortByAiSynthesisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiSynthesis', Sort.desc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy>
      sortByAiSynthesisGeneratedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiSynthesisGeneratedAt', Sort.asc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy>
      sortByAiSynthesisGeneratedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiSynthesisGeneratedAt', Sort.desc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> sortByWeekStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekStart', Sort.asc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> sortByWeekStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekStart', Sort.desc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> sortByWhatSlipped() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whatSlipped', Sort.asc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy>
      sortByWhatSlippedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whatSlipped', Sort.desc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> sortByWhatWorked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whatWorked', Sort.asc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy>
      sortByWhatWorkedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whatWorked', Sort.desc);
    });
  }
}

extension WeeklyReviewQuerySortThenBy
    on QueryBuilder<WeeklyReview, WeeklyReview, QSortThenBy> {
  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> thenByAiSynthesis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiSynthesis', Sort.asc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy>
      thenByAiSynthesisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiSynthesis', Sort.desc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy>
      thenByAiSynthesisGeneratedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiSynthesisGeneratedAt', Sort.asc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy>
      thenByAiSynthesisGeneratedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiSynthesisGeneratedAt', Sort.desc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> thenByWeekStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekStart', Sort.asc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> thenByWeekStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weekStart', Sort.desc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> thenByWhatSlipped() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whatSlipped', Sort.asc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy>
      thenByWhatSlippedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whatSlipped', Sort.desc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy> thenByWhatWorked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whatWorked', Sort.asc);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QAfterSortBy>
      thenByWhatWorkedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whatWorked', Sort.desc);
    });
  }
}

extension WeeklyReviewQueryWhereDistinct
    on QueryBuilder<WeeklyReview, WeeklyReview, QDistinct> {
  QueryBuilder<WeeklyReview, WeeklyReview, QDistinct> distinctByAiSynthesis(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aiSynthesis', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QDistinct>
      distinctByAiSynthesisGeneratedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aiSynthesisGeneratedAt');
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QDistinct> distinctByWeekStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weekStart');
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QDistinct> distinctByWhatSlipped(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'whatSlipped', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WeeklyReview, WeeklyReview, QDistinct> distinctByWhatWorked(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'whatWorked', caseSensitive: caseSensitive);
    });
  }
}

extension WeeklyReviewQueryProperty
    on QueryBuilder<WeeklyReview, WeeklyReview, QQueryProperty> {
  QueryBuilder<WeeklyReview, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WeeklyReview, String?, QQueryOperations> aiSynthesisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aiSynthesis');
    });
  }

  QueryBuilder<WeeklyReview, DateTime?, QQueryOperations>
      aiSynthesisGeneratedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aiSynthesisGeneratedAt');
    });
  }

  QueryBuilder<WeeklyReview, List<RoleAttention>, QQueryOperations>
      attentionByRoleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'attentionByRole');
    });
  }

  QueryBuilder<WeeklyReview, DateTime, QQueryOperations> weekStartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weekStart');
    });
  }

  QueryBuilder<WeeklyReview, String?, QQueryOperations> whatSlippedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'whatSlipped');
    });
  }

  QueryBuilder<WeeklyReview, String?, QQueryOperations> whatWorkedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'whatWorked');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const RoleAttentionSchema = Schema(
  name: r'RoleAttention',
  id: 1975284475393717526,
  properties: {
    r'daysOfAttention': PropertySchema(
      id: 0,
      name: r'daysOfAttention',
      type: IsarType.long,
    ),
    r'roleId': PropertySchema(
      id: 1,
      name: r'roleId',
      type: IsarType.long,
    )
  },
  estimateSize: _roleAttentionEstimateSize,
  serialize: _roleAttentionSerialize,
  deserialize: _roleAttentionDeserialize,
  deserializeProp: _roleAttentionDeserializeProp,
);

int _roleAttentionEstimateSize(
  RoleAttention object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _roleAttentionSerialize(
  RoleAttention object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.daysOfAttention);
  writer.writeLong(offsets[1], object.roleId);
}

RoleAttention _roleAttentionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RoleAttention();
  object.daysOfAttention = reader.readLong(offsets[0]);
  object.roleId = reader.readLong(offsets[1]);
  return object;
}

P _roleAttentionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension RoleAttentionQueryFilter
    on QueryBuilder<RoleAttention, RoleAttention, QFilterCondition> {
  QueryBuilder<RoleAttention, RoleAttention, QAfterFilterCondition>
      daysOfAttentionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'daysOfAttention',
        value: value,
      ));
    });
  }

  QueryBuilder<RoleAttention, RoleAttention, QAfterFilterCondition>
      daysOfAttentionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'daysOfAttention',
        value: value,
      ));
    });
  }

  QueryBuilder<RoleAttention, RoleAttention, QAfterFilterCondition>
      daysOfAttentionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'daysOfAttention',
        value: value,
      ));
    });
  }

  QueryBuilder<RoleAttention, RoleAttention, QAfterFilterCondition>
      daysOfAttentionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'daysOfAttention',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RoleAttention, RoleAttention, QAfterFilterCondition>
      roleIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roleId',
        value: value,
      ));
    });
  }

  QueryBuilder<RoleAttention, RoleAttention, QAfterFilterCondition>
      roleIdGreaterThan(
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

  QueryBuilder<RoleAttention, RoleAttention, QAfterFilterCondition>
      roleIdLessThan(
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

  QueryBuilder<RoleAttention, RoleAttention, QAfterFilterCondition>
      roleIdBetween(
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
}

extension RoleAttentionQueryObject
    on QueryBuilder<RoleAttention, RoleAttention, QFilterCondition> {}
