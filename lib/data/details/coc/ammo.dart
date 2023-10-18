import 'package:json_annotation/json_annotation.dart';

part 'ammo.g.dart';

@JsonSerializable()
class CoCAmmoDTO {
  String? id;
  String? name;
  int? roundsShotWithEach;
  String? creatorId;

  CoCAmmoDTO();

  factory CoCAmmoDTO.fromJson(Map<String, dynamic> json) =>
      _$CoCAmmoDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CoCAmmoDTOToJson(this);
}
