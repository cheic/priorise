// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMissionCollection on Isar {
  IsarCollection<Mission> get missions => this.collection();
}

const MissionSchema = CollectionSchema(
  name: r'Mission',
  id: -3542838313713095933,
  properties: {
    r'lastEditedAt': PropertySchema(
      id: 0,
      name: r'lastEditedAt',
      type: IsarType.dateTime,
    ),
    r'principlesQuestion': PropertySchema(
      id: 1,
      name: r'principlesQuestion',
      type: IsarType.string,
    ),
    r'statement': PropertySchema(
      id: 2,
      name: r'statement',
      type: IsarType.string,
    ),
    r'whatQuestion': PropertySchema(
      id: 3,
      name: r'whatQuestion',
      type: IsarType.string,
    ),
    r'whoQuestion': PropertySchema(
      id: 4,
      name: r'whoQuestion',
      type: IsarType.string,
    )
  },
  estimateSize: _missionEstimateSize,
  serialize: _missionSerialize,
  deserialize: _missionDeserialize,
  deserializeProp: _missionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _missionGetId,
  getLinks: _missionGetLinks,
  attach: _missionAttach,
  version: '3.1.0+1',
);

int _missionEstimateSize(
  Mission object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.principlesQuestion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.statement.length * 3;
  {
    final value = object.whatQuestion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.whoQuestion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _missionSerialize(
  Mission object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.lastEditedAt);
  writer.writeString(offsets[1], object.principlesQuestion);
  writer.writeString(offsets[2], object.statement);
  writer.writeString(offsets[3], object.whatQuestion);
  writer.writeString(offsets[4], object.whoQuestion);
}

Mission _missionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Mission();
  object.id = id;
  object.lastEditedAt = reader.readDateTime(offsets[0]);
  object.principlesQuestion = reader.readStringOrNull(offsets[1]);
  object.statement = reader.readString(offsets[2]);
  object.whatQuestion = reader.readStringOrNull(offsets[3]);
  object.whoQuestion = reader.readStringOrNull(offsets[4]);
  return object;
}

P _missionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _missionGetId(Mission object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _missionGetLinks(Mission object) {
  return [];
}

void _missionAttach(IsarCollection<dynamic> col, Id id, Mission object) {
  object.id = id;
}

extension MissionQueryWhereSort on QueryBuilder<Mission, Mission, QWhere> {
  QueryBuilder<Mission, Mission, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MissionQueryWhere on QueryBuilder<Mission, Mission, QWhereClause> {
  QueryBuilder<Mission, Mission, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Mission, Mission, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Mission, Mission, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Mission, Mission, QAfterWhereClause> idBetween(
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

extension MissionQueryFilter
    on QueryBuilder<Mission, Mission, QFilterCondition> {
  QueryBuilder<Mission, Mission, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Mission, Mission, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Mission, Mission, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Mission, Mission, QAfterFilterCondition> lastEditedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastEditedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> lastEditedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastEditedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> lastEditedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastEditedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> lastEditedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastEditedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition>
      principlesQuestionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'principlesQuestion',
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition>
      principlesQuestionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'principlesQuestion',
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition>
      principlesQuestionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'principlesQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition>
      principlesQuestionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'principlesQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition>
      principlesQuestionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'principlesQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition>
      principlesQuestionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'principlesQuestion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition>
      principlesQuestionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'principlesQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition>
      principlesQuestionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'principlesQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition>
      principlesQuestionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'principlesQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition>
      principlesQuestionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'principlesQuestion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition>
      principlesQuestionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'principlesQuestion',
        value: '',
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition>
      principlesQuestionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'principlesQuestion',
        value: '',
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> statementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> statementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'statement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> statementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'statement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> statementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'statement',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> statementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'statement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> statementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'statement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> statementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'statement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> statementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'statement',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> statementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statement',
        value: '',
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> statementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'statement',
        value: '',
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> whatQuestionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'whatQuestion',
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition>
      whatQuestionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'whatQuestion',
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> whatQuestionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'whatQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> whatQuestionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'whatQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> whatQuestionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'whatQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> whatQuestionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'whatQuestion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> whatQuestionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'whatQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> whatQuestionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'whatQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> whatQuestionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'whatQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> whatQuestionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'whatQuestion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> whatQuestionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'whatQuestion',
        value: '',
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition>
      whatQuestionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'whatQuestion',
        value: '',
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> whoQuestionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'whoQuestion',
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> whoQuestionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'whoQuestion',
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> whoQuestionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'whoQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> whoQuestionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'whoQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> whoQuestionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'whoQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> whoQuestionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'whoQuestion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> whoQuestionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'whoQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> whoQuestionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'whoQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> whoQuestionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'whoQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> whoQuestionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'whoQuestion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition> whoQuestionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'whoQuestion',
        value: '',
      ));
    });
  }

  QueryBuilder<Mission, Mission, QAfterFilterCondition>
      whoQuestionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'whoQuestion',
        value: '',
      ));
    });
  }
}

extension MissionQueryObject
    on QueryBuilder<Mission, Mission, QFilterCondition> {}

extension MissionQueryLinks
    on QueryBuilder<Mission, Mission, QFilterCondition> {}

extension MissionQuerySortBy on QueryBuilder<Mission, Mission, QSortBy> {
  QueryBuilder<Mission, Mission, QAfterSortBy> sortByLastEditedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEditedAt', Sort.asc);
    });
  }

  QueryBuilder<Mission, Mission, QAfterSortBy> sortByLastEditedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEditedAt', Sort.desc);
    });
  }

  QueryBuilder<Mission, Mission, QAfterSortBy> sortByPrinciplesQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'principlesQuestion', Sort.asc);
    });
  }

  QueryBuilder<Mission, Mission, QAfterSortBy> sortByPrinciplesQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'principlesQuestion', Sort.desc);
    });
  }

  QueryBuilder<Mission, Mission, QAfterSortBy> sortByStatement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statement', Sort.asc);
    });
  }

  QueryBuilder<Mission, Mission, QAfterSortBy> sortByStatementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statement', Sort.desc);
    });
  }

  QueryBuilder<Mission, Mission, QAfterSortBy> sortByWhatQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whatQuestion', Sort.asc);
    });
  }

  QueryBuilder<Mission, Mission, QAfterSortBy> sortByWhatQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whatQuestion', Sort.desc);
    });
  }

  QueryBuilder<Mission, Mission, QAfterSortBy> sortByWhoQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whoQuestion', Sort.asc);
    });
  }

  QueryBuilder<Mission, Mission, QAfterSortBy> sortByWhoQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whoQuestion', Sort.desc);
    });
  }
}

extension MissionQuerySortThenBy
    on QueryBuilder<Mission, Mission, QSortThenBy> {
  QueryBuilder<Mission, Mission, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Mission, Mission, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Mission, Mission, QAfterSortBy> thenByLastEditedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEditedAt', Sort.asc);
    });
  }

  QueryBuilder<Mission, Mission, QAfterSortBy> thenByLastEditedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEditedAt', Sort.desc);
    });
  }

  QueryBuilder<Mission, Mission, QAfterSortBy> thenByPrinciplesQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'principlesQuestion', Sort.asc);
    });
  }

  QueryBuilder<Mission, Mission, QAfterSortBy> thenByPrinciplesQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'principlesQuestion', Sort.desc);
    });
  }

  QueryBuilder<Mission, Mission, QAfterSortBy> thenByStatement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statement', Sort.asc);
    });
  }

  QueryBuilder<Mission, Mission, QAfterSortBy> thenByStatementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statement', Sort.desc);
    });
  }

  QueryBuilder<Mission, Mission, QAfterSortBy> thenByWhatQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whatQuestion', Sort.asc);
    });
  }

  QueryBuilder<Mission, Mission, QAfterSortBy> thenByWhatQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whatQuestion', Sort.desc);
    });
  }

  QueryBuilder<Mission, Mission, QAfterSortBy> thenByWhoQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whoQuestion', Sort.asc);
    });
  }

  QueryBuilder<Mission, Mission, QAfterSortBy> thenByWhoQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'whoQuestion', Sort.desc);
    });
  }
}

extension MissionQueryWhereDistinct
    on QueryBuilder<Mission, Mission, QDistinct> {
  QueryBuilder<Mission, Mission, QDistinct> distinctByLastEditedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastEditedAt');
    });
  }

  QueryBuilder<Mission, Mission, QDistinct> distinctByPrinciplesQuestion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'principlesQuestion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Mission, Mission, QDistinct> distinctByStatement(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'statement', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Mission, Mission, QDistinct> distinctByWhatQuestion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'whatQuestion', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Mission, Mission, QDistinct> distinctByWhoQuestion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'whoQuestion', caseSensitive: caseSensitive);
    });
  }
}

extension MissionQueryProperty
    on QueryBuilder<Mission, Mission, QQueryProperty> {
  QueryBuilder<Mission, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Mission, DateTime, QQueryOperations> lastEditedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastEditedAt');
    });
  }

  QueryBuilder<Mission, String?, QQueryOperations>
      principlesQuestionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'principlesQuestion');
    });
  }

  QueryBuilder<Mission, String, QQueryOperations> statementProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'statement');
    });
  }

  QueryBuilder<Mission, String?, QQueryOperations> whatQuestionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'whatQuestion');
    });
  }

  QueryBuilder<Mission, String?, QQueryOperations> whoQuestionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'whoQuestion');
    });
  }
}
