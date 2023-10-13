import 'package:json_annotation/json_annotation.dart';

part 'user_ws_response.g.dart';

@JsonSerializable()
class UserWSResponse {
  List<UsersWS> users = [];
  String? session;
  String? characterSheet;

  UserWSResponse();

  factory UserWSResponse.fromJson(Map<String, dynamic> json) =>
      _$UserWSResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserWSResponseToJson(this);
}

@JsonSerializable()
class UsersWS {
  String? uuid;
  String? firstName;
  String? lastName;
  String? displayName;

  UsersWS();

  factory UsersWS.fromJson(Map<String, dynamic> json) =>
      _$UsersWSFromJson(json);

  Map<String, dynamic> toJson() => _$UsersWSToJson(this);
}
