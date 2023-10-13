// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_infos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionInfos _$SessionInfosFromJson(Map<String, dynamic> json) => SessionInfos()
  ..infos = (json['infos'] as List<dynamic>)
      .map((e) => SessionInfosInner.fromJson(e as Map<String, dynamic>))
      .toList()
  ..userRequested = json['userRequested'] as String?
  ..session = json['session'] as String?
  ..microsservice = json['microsservice'] as String?;

Map<String, dynamic> _$SessionInfosToJson(SessionInfos instance) =>
    <String, dynamic>{
      'infos': instance.infos,
      'userRequested': instance.userRequested,
      'session': instance.session,
      'microsservice': instance.microsservice,
    };

SessionInfosInner _$SessionInfosInnerFromJson(Map<String, dynamic> json) =>
    SessionInfosInner()
      ..dmId = json['dmId'] as String?
      ..coreId = json['coreId'] as String?
      ..sessionName = json['sessionName'] as String?
      ..sessionSheets = (json['sessionSheets'] as List<dynamic>)
          .map((e) => SessionSheets.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SessionInfosInnerToJson(SessionInfosInner instance) =>
    <String, dynamic>{
      'dmId': instance.dmId,
      'coreId': instance.coreId,
      'sessionName': instance.sessionName,
      'sessionSheets': instance.sessionSheets,
    };

SessionSheets _$SessionSheetsFromJson(Map<String, dynamic> json) =>
    SessionSheets()
      ..uuid = json['uuid'] as String?
      ..characterName = json['characterName'] as String?;

Map<String, dynamic> _$SessionSheetsToJson(SessionSheets instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'characterName': instance.characterName,
    };
