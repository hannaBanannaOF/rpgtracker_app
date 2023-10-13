import 'package:json_annotation/json_annotation.dart';

part 'coc_character_sheet.g.dart';

@JsonSerializable()
class CoCCharacterSheet {
  String? id;
  String? coreId;
  CoCCharacterSheetBasicInfo? basicInfo;
  CoCCharacterSheetBasicAttributes? basicAttributes;
  CoCCharacterSheetCalculatedAttributes? calculatedAttributes;
  CoCOccupation? occupation;
  List<CoCCharacterSheetSkill> skills = [];
  List<CoCCharacterSheetWeapon> weapons = [];
  List<CoCCharacterSheetSpell> spells = [];
  List<CoCCharacterSheetPulpTalents> pulpTalents = [];

  CoCCharacterSheet();

  factory CoCCharacterSheet.fromJson(Map<String, dynamic> json) =>
      _$CoCCharacterSheetFromJson(json);

  Map<String, dynamic> toJson() => _$CoCCharacterSheetToJson(this);
}

@JsonSerializable()
class CoCOccupation {
  String? id;
  String? name;
  String? description;
  String? suggestedContacts;

  CoCOccupation();

  factory CoCOccupation.fromJson(Map<String, dynamic> json) =>
      _$CoCOccupationFromJson(json);

  Map<String, dynamic> toJson() => _$CoCOccupationToJson(this);
}

@JsonSerializable()
class CoCCharacterSheetBasicInfo {
  String? characterName;
  String? playerName;
  bool? pulpCthulhu;
  int? age;
  String? sex;
  String? birthplace;
  String? residence;
  String? pulpArchetype;

  CoCCharacterSheetBasicInfo();

  factory CoCCharacterSheetBasicInfo.fromJson(Map<String, dynamic> json) =>
      _$CoCCharacterSheetBasicInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CoCCharacterSheetBasicInfoToJson(this);
}

@JsonSerializable()
class CoCCharacterSheetBasicAttributes {
  int? strength;
  int? constitution;
  int? size;
  int? dexterity;
  int? appearance;
  int? intelligence;
  int? power;
  int? education;
  int? luck;

  CoCCharacterSheetBasicAttributes();

  factory CoCCharacterSheetBasicAttributes.fromJson(
          Map<String, dynamic> json) =>
      _$CoCCharacterSheetBasicAttributesFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CoCCharacterSheetBasicAttributesToJson(this);
}

@JsonSerializable()
class CoCCharacterSheetCalculatedAttributes {
  int? moveRate;
  int? healthPoints;
  int? magicPoints;
  int? sanity;
  int? startingSanity;
  int? maximumHealthPoints;
  int? maximumMagicPoints;
  int? maximumSanity;
  int? build;
  String? bonusDamage;
  bool? majorWounds;
  bool? temporaryInsanity;
  bool? indefiniteInsanity;
  int? occupationalSkillPoints;
  int? personalInterestSkillPoints;
  int? dodge;

  CoCCharacterSheetCalculatedAttributes();

  factory CoCCharacterSheetCalculatedAttributes.fromJson(
          Map<String, dynamic> json) =>
      _$CoCCharacterSheetCalculatedAttributesFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CoCCharacterSheetCalculatedAttributesToJson(this);
}

@JsonSerializable()
class CoCCharacterSheetSkill {
  String? skillID;
  String? skillName;
  int? value;
  bool? improvementCheck;

  CoCCharacterSheetSkill();

  factory CoCCharacterSheetSkill.fromJson(Map<String, dynamic> json) =>
      _$CoCCharacterSheetSkillFromJson(json);

  Map<String, dynamic> toJson() => _$CoCCharacterSheetSkillToJson(this);
}

@JsonSerializable()
class CoCCharacterSheetWeapon {
  CoCCharacterSheetWeaponInner? weapon;
  int? ammoLeft;
  int? roundsLeft;
  int? quantityCarry;
  String? nickname;
  int? totalAmmoLeft;
  int? successValue;

  CoCCharacterSheetWeapon();

  factory CoCCharacterSheetWeapon.fromJson(Map<String, dynamic> json) =>
      _$CoCCharacterSheetWeaponFromJson(json);

  Map<String, dynamic> toJson() => _$CoCCharacterSheetWeaponToJson(this);
}

@JsonSerializable()
class CoCCharacterSheetWeaponInner {
  String? id;
  String? name;
  String? range;
  String? damage;
  int? attacksPerRound;
  int? malfunction;
  bool? isMelee;
  bool? isThrowable;
  bool? isDualWield;
  String? ammoId;
  String? skillUsedId;

  CoCCharacterSheetWeaponInner();

  factory CoCCharacterSheetWeaponInner.fromJson(Map<String, dynamic> json) =>
      _$CoCCharacterSheetWeaponInnerFromJson(json);

  Map<String, dynamic> toJson() => _$CoCCharacterSheetWeaponInnerToJson(this);
}

@JsonSerializable()
class CoCCharacterSheetSpell {
  String? spellID;
  String? spellChosenName;
  String? spellDescription;
  bool? onlyOniricLandscape;
  bool? folk;
  String? monsterKnowledge;
  String? cost;
  String? conjuringTime;

  CoCCharacterSheetSpell();

  factory CoCCharacterSheetSpell.fromJson(Map<String, dynamic> json) =>
      _$CoCCharacterSheetSpellFromJson(json);

  Map<String, dynamic> toJson() => _$CoCCharacterSheetSpellToJson(this);
}

@JsonSerializable()
class CoCCharacterSheetPulpTalents {
  String? id;
  String? name;
  String? description;

  CoCCharacterSheetPulpTalents();

  factory CoCCharacterSheetPulpTalents.fromJson(Map<String, dynamic> json) =>
      _$CoCCharacterSheetPulpTalentsFromJson(json);

  Map<String, dynamic> toJson() => _$CoCCharacterSheetPulpTalentsToJson(this);
}
