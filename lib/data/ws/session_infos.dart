import 'package:json_annotation/json_annotation.dart';

part 'session_infos.g.dart';

@JsonSerializable()
class SessionInfos {
  List<SessionInfosInner> infos = [];
  String? userRequested;
  String? session;
  String? microsservice;

  SessionInfos();

  factory SessionInfos.fromJson(Map<String, dynamic> json) =>
      _$SessionInfosFromJson(json);

  Map<String, dynamic> toJson() => _$SessionInfosToJson(this);
}

@JsonSerializable()
class SessionInfosInner {
  String? dmId;
  String? coreId;
  String? sessionName;
  List<SessionSheets> sessionSheets = [];

  SessionInfosInner();

  factory SessionInfosInner.fromJson(Map<String, dynamic> json) =>
      _$SessionInfosInnerFromJson(json);

  Map<String, dynamic> toJson() => _$SessionInfosInnerToJson(this);
}

@JsonSerializable()
class SessionSheets {
  String? uuid;
  String? characterName;

  SessionSheets();

  factory SessionSheets.fromJson(Map<String, dynamic> json) =>
      _$SessionSheetsFromJson(json);

  Map<String, dynamic> toJson() => _$SessionSheetsToJson(this);
}
