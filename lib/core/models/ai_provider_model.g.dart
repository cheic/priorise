// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_provider_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAiProviderConfigCollection on Isar {
  IsarCollection<AiProviderConfig> get aiProviderConfigs => this.collection();
}

const AiProviderConfigSchema = CollectionSchema(
  name: r'AiProviderConfig',
  id: 5238243076434168389,
  properties: {
    r'apiKeySecureRef': PropertySchema(
      id: 0,
      name: r'apiKeySecureRef',
      type: IsarType.string,
    ),
    r'isActive': PropertySchema(
      id: 1,
      name: r'isActive',
      type: IsarType.bool,
    ),
    r'lastTestSucceeded': PropertySchema(
      id: 2,
      name: r'lastTestSucceeded',
      type: IsarType.bool,
    ),
    r'lastTestedAt': PropertySchema(
      id: 3,
      name: r'lastTestedAt',
      type: IsarType.dateTime,
    ),
    r'model': PropertySchema(
      id: 4,
      name: r'model',
      type: IsarType.string,
    ),
    r'ollamaHostUrl': PropertySchema(
      id: 5,
      name: r'ollamaHostUrl',
      type: IsarType.string,
    ),
    r'providerId': PropertySchema(
      id: 6,
      name: r'providerId',
      type: IsarType.string,
      enumMap: _AiProviderConfigproviderIdEnumValueMap,
    )
  },
  estimateSize: _aiProviderConfigEstimateSize,
  serialize: _aiProviderConfigSerialize,
  deserialize: _aiProviderConfigDeserialize,
  deserializeProp: _aiProviderConfigDeserializeProp,
  idName: r'id',
  indexes: {
    r'providerId': IndexSchema(
      id: -1675978104265523206,
      name: r'providerId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'providerId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _aiProviderConfigGetId,
  getLinks: _aiProviderConfigGetLinks,
  attach: _aiProviderConfigAttach,
  version: '3.1.0+1',
);

int _aiProviderConfigEstimateSize(
  AiProviderConfig object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.apiKeySecureRef;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.model.length * 3;
  {
    final value = object.ollamaHostUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.providerId.name.length * 3;
  return bytesCount;
}

void _aiProviderConfigSerialize(
  AiProviderConfig object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.apiKeySecureRef);
  writer.writeBool(offsets[1], object.isActive);
  writer.writeBool(offsets[2], object.lastTestSucceeded);
  writer.writeDateTime(offsets[3], object.lastTestedAt);
  writer.writeString(offsets[4], object.model);
  writer.writeString(offsets[5], object.ollamaHostUrl);
  writer.writeString(offsets[6], object.providerId.name);
}

AiProviderConfig _aiProviderConfigDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AiProviderConfig();
  object.apiKeySecureRef = reader.readStringOrNull(offsets[0]);
  object.id = id;
  object.isActive = reader.readBool(offsets[1]);
  object.lastTestSucceeded = reader.readBoolOrNull(offsets[2]);
  object.lastTestedAt = reader.readDateTimeOrNull(offsets[3]);
  object.model = reader.readString(offsets[4]);
  object.ollamaHostUrl = reader.readStringOrNull(offsets[5]);
  object.providerId = _AiProviderConfigproviderIdValueEnumMap[
          reader.readStringOrNull(offsets[6])] ??
      AiProviderId.claude;
  return object;
}

P _aiProviderConfigDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readBoolOrNull(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (_AiProviderConfigproviderIdValueEnumMap[
              reader.readStringOrNull(offset)] ??
          AiProviderId.claude) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _AiProviderConfigproviderIdEnumValueMap = {
  r'claude': r'claude',
  r'gemini': r'gemini',
  r'openai': r'openai',
  r'kimi': r'kimi',
  r'qwen': r'qwen',
  r'ollama': r'ollama',
};
const _AiProviderConfigproviderIdValueEnumMap = {
  r'claude': AiProviderId.claude,
  r'gemini': AiProviderId.gemini,
  r'openai': AiProviderId.openai,
  r'kimi': AiProviderId.kimi,
  r'qwen': AiProviderId.qwen,
  r'ollama': AiProviderId.ollama,
};

Id _aiProviderConfigGetId(AiProviderConfig object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _aiProviderConfigGetLinks(AiProviderConfig object) {
  return [];
}

void _aiProviderConfigAttach(
    IsarCollection<dynamic> col, Id id, AiProviderConfig object) {
  object.id = id;
}

extension AiProviderConfigByIndex on IsarCollection<AiProviderConfig> {
  Future<AiProviderConfig?> getByProviderId(AiProviderId providerId) {
    return getByIndex(r'providerId', [providerId]);
  }

  AiProviderConfig? getByProviderIdSync(AiProviderId providerId) {
    return getByIndexSync(r'providerId', [providerId]);
  }

  Future<bool> deleteByProviderId(AiProviderId providerId) {
    return deleteByIndex(r'providerId', [providerId]);
  }

  bool deleteByProviderIdSync(AiProviderId providerId) {
    return deleteByIndexSync(r'providerId', [providerId]);
  }

  Future<List<AiProviderConfig?>> getAllByProviderId(
      List<AiProviderId> providerIdValues) {
    final values = providerIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'providerId', values);
  }

  List<AiProviderConfig?> getAllByProviderIdSync(
      List<AiProviderId> providerIdValues) {
    final values = providerIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'providerId', values);
  }

  Future<int> deleteAllByProviderId(List<AiProviderId> providerIdValues) {
    final values = providerIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'providerId', values);
  }

  int deleteAllByProviderIdSync(List<AiProviderId> providerIdValues) {
    final values = providerIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'providerId', values);
  }

  Future<Id> putByProviderId(AiProviderConfig object) {
    return putByIndex(r'providerId', object);
  }

  Id putByProviderIdSync(AiProviderConfig object, {bool saveLinks = true}) {
    return putByIndexSync(r'providerId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByProviderId(List<AiProviderConfig> objects) {
    return putAllByIndex(r'providerId', objects);
  }

  List<Id> putAllByProviderIdSync(List<AiProviderConfig> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'providerId', objects, saveLinks: saveLinks);
  }
}

extension AiProviderConfigQueryWhereSort
    on QueryBuilder<AiProviderConfig, AiProviderConfig, QWhere> {
  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AiProviderConfigQueryWhere
    on QueryBuilder<AiProviderConfig, AiProviderConfig, QWhereClause> {
  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterWhereClause> idBetween(
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

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterWhereClause>
      providerIdEqualTo(AiProviderId providerId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'providerId',
        value: [providerId],
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterWhereClause>
      providerIdNotEqualTo(AiProviderId providerId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'providerId',
              lower: [],
              upper: [providerId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'providerId',
              lower: [providerId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'providerId',
              lower: [providerId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'providerId',
              lower: [],
              upper: [providerId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension AiProviderConfigQueryFilter
    on QueryBuilder<AiProviderConfig, AiProviderConfig, QFilterCondition> {
  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      apiKeySecureRefIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'apiKeySecureRef',
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      apiKeySecureRefIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'apiKeySecureRef',
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      apiKeySecureRefEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'apiKeySecureRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      apiKeySecureRefGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'apiKeySecureRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      apiKeySecureRefLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'apiKeySecureRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      apiKeySecureRefBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'apiKeySecureRef',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      apiKeySecureRefStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'apiKeySecureRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      apiKeySecureRefEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'apiKeySecureRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      apiKeySecureRefContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'apiKeySecureRef',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      apiKeySecureRefMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'apiKeySecureRef',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      apiKeySecureRefIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'apiKeySecureRef',
        value: '',
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      apiKeySecureRefIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'apiKeySecureRef',
        value: '',
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
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

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
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

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      isActiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      lastTestSucceededIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastTestSucceeded',
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      lastTestSucceededIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastTestSucceeded',
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      lastTestSucceededEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastTestSucceeded',
        value: value,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      lastTestedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastTestedAt',
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      lastTestedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastTestedAt',
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      lastTestedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastTestedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      lastTestedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastTestedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      lastTestedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastTestedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      lastTestedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastTestedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      modelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      modelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      modelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      modelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'model',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      modelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      modelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      modelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      modelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'model',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      modelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'model',
        value: '',
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      modelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'model',
        value: '',
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      ollamaHostUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ollamaHostUrl',
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      ollamaHostUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ollamaHostUrl',
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      ollamaHostUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ollamaHostUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      ollamaHostUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ollamaHostUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      ollamaHostUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ollamaHostUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      ollamaHostUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ollamaHostUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      ollamaHostUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ollamaHostUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      ollamaHostUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ollamaHostUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      ollamaHostUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ollamaHostUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      ollamaHostUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ollamaHostUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      ollamaHostUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ollamaHostUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      ollamaHostUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ollamaHostUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      providerIdEqualTo(
    AiProviderId value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'providerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      providerIdGreaterThan(
    AiProviderId value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'providerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      providerIdLessThan(
    AiProviderId value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'providerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      providerIdBetween(
    AiProviderId lower,
    AiProviderId upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'providerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      providerIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'providerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      providerIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'providerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      providerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'providerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      providerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'providerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      providerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'providerId',
        value: '',
      ));
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterFilterCondition>
      providerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'providerId',
        value: '',
      ));
    });
  }
}

extension AiProviderConfigQueryObject
    on QueryBuilder<AiProviderConfig, AiProviderConfig, QFilterCondition> {}

extension AiProviderConfigQueryLinks
    on QueryBuilder<AiProviderConfig, AiProviderConfig, QFilterCondition> {}

extension AiProviderConfigQuerySortBy
    on QueryBuilder<AiProviderConfig, AiProviderConfig, QSortBy> {
  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      sortByApiKeySecureRef() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apiKeySecureRef', Sort.asc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      sortByApiKeySecureRefDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apiKeySecureRef', Sort.desc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      sortByLastTestSucceeded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTestSucceeded', Sort.asc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      sortByLastTestSucceededDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTestSucceeded', Sort.desc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      sortByLastTestedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTestedAt', Sort.asc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      sortByLastTestedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTestedAt', Sort.desc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy> sortByModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.asc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      sortByModelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.desc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      sortByOllamaHostUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ollamaHostUrl', Sort.asc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      sortByOllamaHostUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ollamaHostUrl', Sort.desc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      sortByProviderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'providerId', Sort.asc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      sortByProviderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'providerId', Sort.desc);
    });
  }
}

extension AiProviderConfigQuerySortThenBy
    on QueryBuilder<AiProviderConfig, AiProviderConfig, QSortThenBy> {
  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      thenByApiKeySecureRef() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apiKeySecureRef', Sort.asc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      thenByApiKeySecureRefDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'apiKeySecureRef', Sort.desc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      thenByLastTestSucceeded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTestSucceeded', Sort.asc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      thenByLastTestSucceededDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTestSucceeded', Sort.desc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      thenByLastTestedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTestedAt', Sort.asc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      thenByLastTestedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTestedAt', Sort.desc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy> thenByModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.asc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      thenByModelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.desc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      thenByOllamaHostUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ollamaHostUrl', Sort.asc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      thenByOllamaHostUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ollamaHostUrl', Sort.desc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      thenByProviderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'providerId', Sort.asc);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QAfterSortBy>
      thenByProviderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'providerId', Sort.desc);
    });
  }
}

extension AiProviderConfigQueryWhereDistinct
    on QueryBuilder<AiProviderConfig, AiProviderConfig, QDistinct> {
  QueryBuilder<AiProviderConfig, AiProviderConfig, QDistinct>
      distinctByApiKeySecureRef({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'apiKeySecureRef',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QDistinct>
      distinctByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive');
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QDistinct>
      distinctByLastTestSucceeded() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastTestSucceeded');
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QDistinct>
      distinctByLastTestedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastTestedAt');
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QDistinct> distinctByModel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'model', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QDistinct>
      distinctByOllamaHostUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ollamaHostUrl',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderConfig, QDistinct>
      distinctByProviderId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'providerId', caseSensitive: caseSensitive);
    });
  }
}

extension AiProviderConfigQueryProperty
    on QueryBuilder<AiProviderConfig, AiProviderConfig, QQueryProperty> {
  QueryBuilder<AiProviderConfig, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AiProviderConfig, String?, QQueryOperations>
      apiKeySecureRefProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'apiKeySecureRef');
    });
  }

  QueryBuilder<AiProviderConfig, bool, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<AiProviderConfig, bool?, QQueryOperations>
      lastTestSucceededProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastTestSucceeded');
    });
  }

  QueryBuilder<AiProviderConfig, DateTime?, QQueryOperations>
      lastTestedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastTestedAt');
    });
  }

  QueryBuilder<AiProviderConfig, String, QQueryOperations> modelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'model');
    });
  }

  QueryBuilder<AiProviderConfig, String?, QQueryOperations>
      ollamaHostUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ollamaHostUrl');
    });
  }

  QueryBuilder<AiProviderConfig, AiProviderId, QQueryOperations>
      providerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'providerId');
    });
  }
}
