import 'package:json_annotation/json_annotation.dart';

part 'character_infos.g.dart';

@JsonSerializable()
class CharacterInfos {
  List<CharacterInfosInner> infos = [];
  String? userRequested;
  String? microservice;

  CharacterInfos();

  factory CharacterInfos.fromJson(Map<String, dynamic> json) =>
      _$CharacterInfosFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterInfosToJson(this);
}

@JsonSerializable()
class CharacterInfosInner {
  String? characterName;
  String? sheetId;
  String? playerId;

  CharacterInfosInner();

  factory CharacterInfosInner.fromJson(Map<String, dynamic> json) =>
      _$CharacterInfosInnerFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterInfosInnerToJson(this);
}
