// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_sheet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterSheetListing _$CharacterSheetListingFromJson(
        Map<String, dynamic> json) =>
    CharacterSheetListing()
      ..uuid = json['uuid'] as String?
      ..characterName = json['characterName'] as String?
      ..system = TRPGSystem.fromJson(json['system'] as String?)
      ..session = json['session'] == null
          ? null
          : Session.fromJson(json['session'] as Map<String, dynamic>);

Map<String, dynamic> _$CharacterSheetListingToJson(
        CharacterSheetListing instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'characterName': instance.characterName,
      'system': TRPGSystem.toJson(instance.system),
      'session': instance.session,
    };

Session _$SessionFromJson(Map<String, dynamic> json) => Session()
  ..uuid = json['uuid'] as String?
  ..sessionName = json['sessionName'] as String?
  ..system = TRPGSystem.fromJson(json['system'] as String?)
  ..inPlay = json['inPlay'] as bool?;

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'sessionName': instance.sessionName,
      'system': TRPGSystem.toJson(instance.system),
      'inPlay': instance.inPlay,
    };
