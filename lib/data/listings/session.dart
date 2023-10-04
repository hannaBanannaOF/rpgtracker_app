import 'package:json_annotation/json_annotation.dart';
import 'package:rpgtracker_app/enums/trpg_system.dart';

part 'session.g.dart';

@JsonSerializable()
class SessionListing {
  String? uuid;
  String? sessionName;
  @JsonKey(fromJson: TRPGSystem.fromJson, toJson: TRPGSystem.toJson)
  TRPGSystem? system;
  bool? inPlay;

  @JsonKey(includeToJson: false, includeFromJson: false)
  List<String>? users;

  SessionListing();

  factory SessionListing.fromJson(Map<String, dynamic> json) =>
      _$SessionListingFromJson(json);

  Map<String, dynamic> toJson() => _$SessionListingToJson(this);
}
