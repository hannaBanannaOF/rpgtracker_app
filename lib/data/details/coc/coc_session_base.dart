import 'package:json_annotation/json_annotation.dart';

part 'coc_session_base.g.dart';

@JsonSerializable()
class CoCSessionBase {
  String? uuid;
  bool? inPlay;
  bool? pulpCthulhu;
  String? coreId;

  CoCSessionBase();

  factory CoCSessionBase.fromJson(Map<String, dynamic> json) =>
      _$CoCSessionBaseFromJson(json);

  Map<String, dynamic> toJson() => _$CoCSessionBaseToJson(this);
}
