// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ammo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoCAmmoDTO _$CoCAmmoDTOFromJson(Map<String, dynamic> json) => CoCAmmoDTO()
  ..id = json['id'] as String?
  ..name = json['name'] as String?
  ..roundsShotWithEach = json['roundsShotWithEach'] as int?
  ..creatorId = json['creatorId'] as String?;

Map<String, dynamic> _$CoCAmmoDTOToJson(CoCAmmoDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'roundsShotWithEach': instance.roundsShotWithEach,
      'creatorId': instance.creatorId,
    };
