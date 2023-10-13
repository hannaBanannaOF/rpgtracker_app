// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coc_session_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoCSessionBase _$CoCSessionBaseFromJson(Map<String, dynamic> json) =>
    CoCSessionBase()
      ..uuid = json['uuid'] as String?
      ..inPlay = json['inPlay'] as bool?
      ..pulpCthulhu = json['pulpCthulhu'] as bool?
      ..coreId = json['coreId'] as String?;

Map<String, dynamic> _$CoCSessionBaseToJson(CoCSessionBase instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'inPlay': instance.inPlay,
      'pulpCthulhu': instance.pulpCthulhu,
      'coreId': instance.coreId,
    };
