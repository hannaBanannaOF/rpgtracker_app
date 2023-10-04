import 'package:json_annotation/json_annotation.dart';
import 'package:rpgtracker_app/enums/trpg_system.dart';

part 'character_sheet.g.dart';

@JsonSerializable()
class CharacterSheetListing {
  String? uuid;
  String? characterName;
  @JsonKey(fromJson: TRPGSystem.fromJson, toJson: TRPGSystem.toJson)
  TRPGSystem? system;
  Session? session;

  CharacterSheetListing();

  factory CharacterSheetListing.fromJson(Map<String, dynamic> json) =>
      _$CharacterSheetListingFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterSheetListingToJson(this);
}

@JsonSerializable()
class Session {
  String? uuid;
  String? sessionName;
  @JsonKey(fromJson: TRPGSystem.fromJson, toJson: TRPGSystem.toJson)
  TRPGSystem? system;
  bool? inPlay;

  Session();

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
