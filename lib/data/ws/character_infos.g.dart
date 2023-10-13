// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_infos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterInfos _$CharacterInfosFromJson(Map<String, dynamic> json) =>
    CharacterInfos()
      ..infos = (json['infos'] as List<dynamic>)
          .map((e) => CharacterInfosInner.fromJson(e as Map<String, dynamic>))
          .toList()
      ..userRequested = json['userRequested'] as String?
      ..microservice = json['microservice'] as String?;

Map<String, dynamic> _$CharacterInfosToJson(CharacterInfos instance) =>
    <String, dynamic>{
      'infos': instance.infos,
      'userRequested': instance.userRequested,
      'microservice': instance.microservice,
    };

CharacterInfosInner _$CharacterInfosInnerFromJson(Map<String, dynamic> json) =>
    CharacterInfosInner()
      ..characterName = json['characterName'] as String?
      ..sheetId = json['sheetId'] as String?
      ..playerId = json['playerId'] as String?;

Map<String, dynamic> _$CharacterInfosInnerToJson(
        CharacterInfosInner instance) =>
    <String, dynamic>{
      'characterName': instance.characterName,
      'sheetId': instance.sheetId,
      'playerId': instance.playerId,
    };
