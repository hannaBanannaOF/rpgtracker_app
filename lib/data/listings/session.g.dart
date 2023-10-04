// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionListing _$SessionListingFromJson(Map<String, dynamic> json) =>
    SessionListing()
      ..uuid = json['uuid'] as String?
      ..sessionName = json['sessionName'] as String?
      ..system = TRPGSystem.fromJson(json['system'] as String?)
      ..inPlay = json['inPlay'] as bool?;

Map<String, dynamic> _$SessionListingToJson(SessionListing instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'sessionName': instance.sessionName,
      'system': TRPGSystem.toJson(instance.system),
      'inPlay': instance.inPlay,
    };
