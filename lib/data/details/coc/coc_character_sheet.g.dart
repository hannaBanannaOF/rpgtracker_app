// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coc_character_sheet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoCCharacterSheet _$CoCCharacterSheetFromJson(Map<String, dynamic> json) =>
    CoCCharacterSheet()
      ..id = json['id'] as String?
      ..coreId = json['coreId'] as String?
      ..basicInfo = json['basicInfo'] == null
          ? null
          : CoCCharacterSheetBasicInfo.fromJson(
              json['basicInfo'] as Map<String, dynamic>)
      ..basicAttributes = json['basicAttributes'] == null
          ? null
          : CoCCharacterSheetBasicAttributes.fromJson(
              json['basicAttributes'] as Map<String, dynamic>)
      ..calculatedAttributes = json['calculatedAttributes'] == null
          ? null
          : CoCCharacterSheetCalculatedAttributes.fromJson(
              json['calculatedAttributes'] as Map<String, dynamic>)
      ..occupation = json['occupation'] == null
          ? null
          : CoCOccupation.fromJson(json['occupation'] as Map<String, dynamic>)
      ..skills = (json['skills'] as List<dynamic>)
          .map(
              (e) => CoCCharacterSheetSkill.fromJson(e as Map<String, dynamic>))
          .toList()
      ..weapons = (json['weapons'] as List<dynamic>)
          .map((e) =>
              CoCCharacterSheetWeapon.fromJson(e as Map<String, dynamic>))
          .toList()
      ..spells = (json['spells'] as List<dynamic>)
          .map(
              (e) => CoCCharacterSheetSpell.fromJson(e as Map<String, dynamic>))
          .toList()
      ..pulpTalents = (json['pulpTalents'] as List<dynamic>)
          .map((e) =>
              CoCCharacterSheetPulpTalents.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$CoCCharacterSheetToJson(CoCCharacterSheet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'coreId': instance.coreId,
      'basicInfo': instance.basicInfo,
      'basicAttributes': instance.basicAttributes,
      'calculatedAttributes': instance.calculatedAttributes,
      'occupation': instance.occupation,
      'skills': instance.skills,
      'weapons': instance.weapons,
      'spells': instance.spells,
      'pulpTalents': instance.pulpTalents,
    };

CoCOccupation _$CoCOccupationFromJson(Map<String, dynamic> json) =>
    CoCOccupation()
      ..id = json['id'] as String?
      ..name = json['name'] as String?
      ..description = json['description'] as String?
      ..suggestedContacts = json['suggestedContacts'] as String?;

Map<String, dynamic> _$CoCOccupationToJson(CoCOccupation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'suggestedContacts': instance.suggestedContacts,
    };

CoCCharacterSheetBasicInfo _$CoCCharacterSheetBasicInfoFromJson(
        Map<String, dynamic> json) =>
    CoCCharacterSheetBasicInfo()
      ..characterName = json['characterName'] as String?
      ..playerName = json['playerName'] as String?
      ..pulpCthulhu = json['pulpCthulhu'] as bool?
      ..age = json['age'] as int?
      ..sex = json['sex'] as String?
      ..birthplace = json['birthplace'] as String?
      ..residence = json['residence'] as String?
      ..pulpArchetype = json['pulpArchetype'] as String?;

Map<String, dynamic> _$CoCCharacterSheetBasicInfoToJson(
        CoCCharacterSheetBasicInfo instance) =>
    <String, dynamic>{
      'characterName': instance.characterName,
      'playerName': instance.playerName,
      'pulpCthulhu': instance.pulpCthulhu,
      'age': instance.age,
      'sex': instance.sex,
      'birthplace': instance.birthplace,
      'residence': instance.residence,
      'pulpArchetype': instance.pulpArchetype,
    };

CoCCharacterSheetBasicAttributes _$CoCCharacterSheetBasicAttributesFromJson(
        Map<String, dynamic> json) =>
    CoCCharacterSheetBasicAttributes()
      ..strength = json['strength'] as int?
      ..constitution = json['constitution'] as int?
      ..size = json['size'] as int?
      ..dexterity = json['dexterity'] as int?
      ..appearance = json['appearance'] as int?
      ..intelligence = json['intelligence'] as int?
      ..power = json['power'] as int?
      ..education = json['education'] as int?
      ..luck = json['luck'] as int?;

Map<String, dynamic> _$CoCCharacterSheetBasicAttributesToJson(
        CoCCharacterSheetBasicAttributes instance) =>
    <String, dynamic>{
      'strength': instance.strength,
      'constitution': instance.constitution,
      'size': instance.size,
      'dexterity': instance.dexterity,
      'appearance': instance.appearance,
      'intelligence': instance.intelligence,
      'power': instance.power,
      'education': instance.education,
      'luck': instance.luck,
    };

CoCCharacterSheetCalculatedAttributes
    _$CoCCharacterSheetCalculatedAttributesFromJson(
            Map<String, dynamic> json) =>
        CoCCharacterSheetCalculatedAttributes()
          ..moveRate = json['moveRate'] as int?
          ..healthPoints = json['healthPoints'] as int?
          ..magicPoints = json['magicPoints'] as int?
          ..sanity = json['sanity'] as int?
          ..startingSanity = json['startingSanity'] as int?
          ..maximumHealthPoints = json['maximumHealthPoints'] as int?
          ..maximumMagicPoints = json['maximumMagicPoints'] as int?
          ..maximumSanity = json['maximumSanity'] as int?
          ..build = json['build'] as int?
          ..bonusDamage = json['bonusDamage'] as String?
          ..majorWounds = json['majorWounds'] as bool?
          ..temporaryInsanity = json['temporaryInsanity'] as bool?
          ..indefiniteInsanity = json['indefiniteInsanity'] as bool?
          ..occupationalSkillPoints = json['occupationalSkillPoints'] as int?
          ..personalInterestSkillPoints =
              json['personalInterestSkillPoints'] as int?
          ..dodge = json['dodge'] as int?;

Map<String, dynamic> _$CoCCharacterSheetCalculatedAttributesToJson(
        CoCCharacterSheetCalculatedAttributes instance) =>
    <String, dynamic>{
      'moveRate': instance.moveRate,
      'healthPoints': instance.healthPoints,
      'magicPoints': instance.magicPoints,
      'sanity': instance.sanity,
      'startingSanity': instance.startingSanity,
      'maximumHealthPoints': instance.maximumHealthPoints,
      'maximumMagicPoints': instance.maximumMagicPoints,
      'maximumSanity': instance.maximumSanity,
      'build': instance.build,
      'bonusDamage': instance.bonusDamage,
      'majorWounds': instance.majorWounds,
      'temporaryInsanity': instance.temporaryInsanity,
      'indefiniteInsanity': instance.indefiniteInsanity,
      'occupationalSkillPoints': instance.occupationalSkillPoints,
      'personalInterestSkillPoints': instance.personalInterestSkillPoints,
      'dodge': instance.dodge,
    };

CoCCharacterSheetSkill _$CoCCharacterSheetSkillFromJson(
        Map<String, dynamic> json) =>
    CoCCharacterSheetSkill()
      ..skillID = json['skillID'] as String?
      ..skillName = json['skillName'] as String?
      ..value = json['value'] as int?
      ..improvementCheck = json['improvementCheck'] as bool?;

Map<String, dynamic> _$CoCCharacterSheetSkillToJson(
        CoCCharacterSheetSkill instance) =>
    <String, dynamic>{
      'skillID': instance.skillID,
      'skillName': instance.skillName,
      'value': instance.value,
      'improvementCheck': instance.improvementCheck,
    };

CoCCharacterSheetWeapon _$CoCCharacterSheetWeaponFromJson(
        Map<String, dynamic> json) =>
    CoCCharacterSheetWeapon()
      ..weapon = json['weapon'] == null
          ? null
          : CoCCharacterSheetWeaponInner.fromJson(
              json['weapon'] as Map<String, dynamic>)
      ..ammoLeft = json['ammoLeft'] as int?
      ..roundsLeft = json['roundsLeft'] as int?
      ..quantityCarry = json['quantityCarry'] as int?
      ..nickname = json['nickname'] as String?
      ..totalAmmoLeft = json['totalAmmoLeft'] as int?
      ..successValue = json['successValue'] as int?;

Map<String, dynamic> _$CoCCharacterSheetWeaponToJson(
        CoCCharacterSheetWeapon instance) =>
    <String, dynamic>{
      'weapon': instance.weapon,
      'ammoLeft': instance.ammoLeft,
      'roundsLeft': instance.roundsLeft,
      'quantityCarry': instance.quantityCarry,
      'nickname': instance.nickname,
      'totalAmmoLeft': instance.totalAmmoLeft,
      'successValue': instance.successValue,
    };

CoCCharacterSheetWeaponInner _$CoCCharacterSheetWeaponInnerFromJson(
        Map<String, dynamic> json) =>
    CoCCharacterSheetWeaponInner()
      ..id = json['id'] as String?
      ..name = json['name'] as String?
      ..range = json['range'] as String?
      ..damage = json['damage'] as String?
      ..attacksPerRound = json['attacksPerRound'] as int?
      ..malfunction = json['malfunction'] as int?
      ..isMelee = json['isMelee'] as bool?
      ..isThrowable = json['isThrowable'] as bool?
      ..isDualWield = json['isDualWield'] as bool?
      ..ammoId = json['ammoId'] as String?
      ..skillUsedId = json['skillUsedId'] as String?;

Map<String, dynamic> _$CoCCharacterSheetWeaponInnerToJson(
        CoCCharacterSheetWeaponInner instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'range': instance.range,
      'damage': instance.damage,
      'attacksPerRound': instance.attacksPerRound,
      'malfunction': instance.malfunction,
      'isMelee': instance.isMelee,
      'isThrowable': instance.isThrowable,
      'isDualWield': instance.isDualWield,
      'ammoId': instance.ammoId,
      'skillUsedId': instance.skillUsedId,
    };

CoCCharacterSheetSpell _$CoCCharacterSheetSpellFromJson(
        Map<String, dynamic> json) =>
    CoCCharacterSheetSpell()
      ..spellID = json['spellID'] as String?
      ..spellChosenName = json['spellChosenName'] as String?
      ..spellDescription = json['spellDescription'] as String?
      ..onlyOniricLandscape = json['onlyOniricLandscape'] as bool?
      ..folk = json['folk'] as bool?
      ..monsterKnowledge = json['monsterKnowledge'] as String?
      ..cost = json['cost'] as String?
      ..conjuringTime = json['conjuringTime'] as String?;

Map<String, dynamic> _$CoCCharacterSheetSpellToJson(
        CoCCharacterSheetSpell instance) =>
    <String, dynamic>{
      'spellID': instance.spellID,
      'spellChosenName': instance.spellChosenName,
      'spellDescription': instance.spellDescription,
      'onlyOniricLandscape': instance.onlyOniricLandscape,
      'folk': instance.folk,
      'monsterKnowledge': instance.monsterKnowledge,
      'cost': instance.cost,
      'conjuringTime': instance.conjuringTime,
    };

CoCCharacterSheetPulpTalents _$CoCCharacterSheetPulpTalentsFromJson(
        Map<String, dynamic> json) =>
    CoCCharacterSheetPulpTalents()
      ..id = json['id'] as String?
      ..name = json['name'] as String?
      ..description = json['description'] as String?;

Map<String, dynamic> _$CoCCharacterSheetPulpTalentsToJson(
        CoCCharacterSheetPulpTalents instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
