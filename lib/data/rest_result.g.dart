// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestResult<T> _$RestResultFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    RestResult<T>()
      ..content = (json['content'] as List<dynamic>).map(fromJsonT).toList()
      ..pageable = json['pageable'] == null
          ? null
          : Pageable.fromJson(json['pageable'] as Map<String, dynamic>)
      ..last = json['last'] as bool?
      ..totalPages = json['totalPages'] as int?
      ..totalElements = json['totalElements'] as int?
      ..size = json['size'] as int?
      ..number = json['number'] as int?
      ..sort = json['sort'] == null
          ? null
          : Sort.fromJson(json['sort'] as Map<String, dynamic>)
      ..first = json['first'] as bool?
      ..numberOfElements = json['numberOfElements'] as int?
      ..empty = json['empty'] as bool?;

Map<String, dynamic> _$RestResultToJson<T>(
  RestResult<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'content': instance.content.map(toJsonT).toList(),
      'pageable': instance.pageable,
      'last': instance.last,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'size': instance.size,
      'number': instance.number,
      'sort': instance.sort,
      'first': instance.first,
      'numberOfElements': instance.numberOfElements,
      'empty': instance.empty,
    };

Pageable _$PageableFromJson(Map<String, dynamic> json) => Pageable()
  ..sort = json['sort'] == null
      ? null
      : Sort.fromJson(json['sort'] as Map<String, dynamic>)
  ..offset = json['offset'] as int?
  ..pageSize = json['pageSize'] as int?
  ..pageNumber = json['pageNumber'] as int?
  ..paged = json['paged'] as bool?
  ..unpaged = json['unpaged'] as bool?;

Map<String, dynamic> _$PageableToJson(Pageable instance) => <String, dynamic>{
      'sort': instance.sort,
      'offset': instance.offset,
      'pageSize': instance.pageSize,
      'pageNumber': instance.pageNumber,
      'paged': instance.paged,
      'unpaged': instance.unpaged,
    };

Sort _$SortFromJson(Map<String, dynamic> json) => Sort()
  ..empty = json['empty'] as bool?
  ..sorted = json['sorted'] as bool?
  ..unsorted = json['unsorted'] as bool?;

Map<String, dynamic> _$SortToJson(Sort instance) => <String, dynamic>{
      'empty': instance.empty,
      'sorted': instance.sorted,
      'unsorted': instance.unsorted,
    };
