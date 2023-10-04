import 'package:json_annotation/json_annotation.dart';

part 'rest_result.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class RestResult<T> {
  List<T> content = [];
  Pageable? pageable;
  bool? last;
  int? totalPages;
  int? totalElements;
  int? size;
  int? number;
  Sort? sort;
  bool? first;
  int? numberOfElements;
  bool? empty;

  RestResult();

  factory RestResult.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$RestResultFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$RestResultToJson(this, toJsonT);
}

@JsonSerializable()
class Pageable {
  Sort? sort;
  int? offset;
  int? pageSize;
  int? pageNumber;
  bool? paged;
  bool? unpaged;

  Pageable();

  factory Pageable.fromJson(Map<String, dynamic> json) =>
      _$PageableFromJson(json);

  Map<String, dynamic> toJson() => _$PageableToJson(this);
}

@JsonSerializable()
class Sort {
  bool? empty;
  bool? sorted;
  bool? unsorted;

  Sort();

  factory Sort.fromJson(Map<String, dynamic> json) => _$SortFromJson(json);

  Map<String, dynamic> toJson() => _$SortToJson(this);
}
