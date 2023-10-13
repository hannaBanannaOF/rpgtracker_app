// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_ws_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWSResponse _$UserWSResponseFromJson(Map<String, dynamic> json) =>
    UserWSResponse()
      ..users = (json['users'] as List<dynamic>)
          .map((e) => UsersWS.fromJson(e as Map<String, dynamic>))
          .toList()
      ..session = json['session'] as String?
      ..characterSheet = json['characterSheet'] as String?;

Map<String, dynamic> _$UserWSResponseToJson(UserWSResponse instance) =>
    <String, dynamic>{
      'users': instance.users,
      'session': instance.session,
      'characterSheet': instance.characterSheet,
    };

UsersWS _$UsersWSFromJson(Map<String, dynamic> json) => UsersWS()
  ..uuid = json['uuid'] as String?
  ..firstName = json['firstName'] as String?
  ..lastName = json['lastName'] as String?
  ..displayName = json['displayName'] as String?;

Map<String, dynamic> _$UsersWSToJson(UsersWS instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'displayName': instance.displayName,
    };
