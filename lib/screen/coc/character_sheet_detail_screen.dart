import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpgtracker_app/data/details/coc/coc_character_sheet.dart';
import 'package:rpgtracker_app/extensions/string.dart';
import 'package:rpgtracker_app/providers/character_sheet_provider.dart';
import 'package:rpgtracker_app/ui/bordered_container.dart';
import 'package:rpgtracker_app/ui/coc_stat.dart';
import 'package:rpgtracker_app/ui/empty_list.dart';
import 'package:rpgtracker_app/ui/labeled_checkbox.dart';
import 'package:rpgtracker_app/ui/labeled_slider.dart';
import 'package:rpgtracker_app/ui/list_tile_title.dart';
import 'package:rpgtracker_app/ui/skeleton.dart';
import 'package:rpgtracker_app/ui/titled_text.dart';

class CoCCharacterSheetDetailScreenArgs {
  String screenTitle;
  CoCCharacterSheet characterSheet;

  CoCCharacterSheetDetailScreenArgs(this.screenTitle, this.characterSheet);
}

class CoCCharacterScreenDetailScreen extends StatefulWidget {
  const CoCCharacterScreenDetailScreen({super.key});

  @override
  State<CoCCharacterScreenDetailScreen> createState() =>
      _CoCCharacterScreenDetailScreenState();
}

class _CoCCharacterScreenDetailScreenState
    extends State<CoCCharacterScreenDetailScreen> {
  final String characterSheetTranslationPrefix = 'characterSheet:coc';
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as CoCCharacterSheetDetailScreenArgs;
    return WillPopScope(
      onWillPop: () async {
        Provider.of<CharacterSheetProvider>(context, listen: false)
            .resetProvider();
        return true;
      },
      child: ChangeNotifierProvider<CharacterSheetProvider>.value(
        value: Provider.of<CharacterSheetProvider>(context),
        child:
            Consumer<CharacterSheetProvider>(builder: (context, value, child) {
          return DefaultTabController(
            length: args.characterSheet.basicInfo!.pulpCthulhu ?? false ? 6 : 5,
            child: Scaffold(
              appBar: AppBar(
                title: Text(value.selectedCharacterName ?? args.screenTitle),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(30.0),
                  child: TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(
                        text: '$characterSheetTranslationPrefix.basicInfo'
                            .translate(context),
                      ),
                      Tab(
                        text:
                            '$characterSheetTranslationPrefix.characteristics.title'
                                .translate(context),
                      ),
                      Tab(
                        text: '$characterSheetTranslationPrefix.skills'
                            .translate(context),
                      ),
                      Tab(
                        text: '$characterSheetTranslationPrefix.weapons.title'
                            .translate(context),
                      ),
                      Tab(
                        text: '$characterSheetTranslationPrefix.spells.title'
                            .translate(context),
                      ),
                      if (args.characterSheet.basicInfo!.pulpCthulhu ??
                          false) ...[
                        Tab(
                          text:
                              '$characterSheetTranslationPrefix.pulpTalent.title'
                                  .translate(context),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: TabBarView(
                    children: [
                      // Básicos
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            BorderedContainer(
                              label: (args.characterSheet.basicInfo!
                                              .pulpCthulhu ??
                                          false
                                      ? '$characterSheetTranslationPrefix.hero'
                                      : '$characterSheetTranslationPrefix.investigator')
                                  .translate(context),
                              children: [
                                Skeleton(
                                  enabled: value.selectedCharacterName == null,
                                  child: TitledText(
                                    title:
                                        '$characterSheetTranslationPrefix.characterName'
                                            .translate(context),
                                    content: value.selectedCharacterName ?? '',
                                  ),
                                ),
                                Skeleton(
                                  enabled:
                                      value.selectedCharacterPlayerName == null,
                                  child: TitledText(
                                    title:
                                        '$characterSheetTranslationPrefix.playerName'
                                            .translate(context),
                                    content:
                                        value.selectedCharacterPlayerName ?? '',
                                  ),
                                ),
                                TitledText(
                                  title: '$characterSheetTranslationPrefix.age'
                                      .translate(context),
                                  content: args.characterSheet.basicInfo!.age
                                      .toString(),
                                ),
                                TitledText(
                                  title:
                                      '$characterSheetTranslationPrefix.residency'
                                          .translate(context),
                                  content: args.characterSheet.basicInfo!
                                          .residence ??
                                      '',
                                ),
                                TitledText(
                                  title:
                                      '$characterSheetTranslationPrefix.birthplace'
                                          .translate(context),
                                  content: args.characterSheet.basicInfo!
                                          .birthplace ??
                                      '',
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    if (args.characterSheet.occupation !=
                                        null) {
                                      showDialog(
                                        useSafeArea: true,
                                        context: context,
                                        builder: (context) => SimpleDialog(
                                          title: Text(args.characterSheet
                                                  .occupation!.name ??
                                              ''),
                                          contentPadding:
                                              const EdgeInsets.all(12),
                                          children: [
                                            BorderedContainer(
                                              label:
                                                  '$characterSheetTranslationPrefix.occupation.description'
                                                      .translate(context),
                                              children: [
                                                Text(args
                                                        .characterSheet
                                                        .occupation!
                                                        .description ??
                                                    '')
                                              ],
                                            ),
                                            BorderedContainer(
                                              label:
                                                  '$characterSheetTranslationPrefix.occupation.suggestedContacts'
                                                      .translate(context),
                                              children: [
                                                Text(args
                                                        .characterSheet
                                                        .occupation!
                                                        .suggestedContacts ??
                                                    '')
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  child: TitledText(
                                    title:
                                        '$characterSheetTranslationPrefix.occupation.title'
                                            .translate(context),
                                    content: args
                                            .characterSheet.occupation?.name ??
                                        '$characterSheetTranslationPrefix.occupation.unoccupied'
                                            .translate(context),
                                    suffix:
                                        args.characterSheet.occupation != null
                                            ? const Icon(Icons.info)
                                            : null,
                                  ),
                                ),
                                if (args.characterSheet.basicInfo!
                                        .pulpCthulhu ??
                                    false) ...[
                                  TitledText(
                                    title:
                                        '$characterSheetTranslationPrefix.occupation.archetype'
                                            .translate(context),
                                    content: args.characterSheet.basicInfo!
                                            .pulpArchetype ??
                                        '',
                                  )
                                ]
                              ],
                            ),
                            BorderedContainer(
                              label:
                                  '$characterSheetTranslationPrefix.characteristics.title'
                                      .translate(context),
                              children: [
                                CoCStat(
                                  stat:
                                      '$characterSheetTranslationPrefix.characteristics.str'
                                          .translate(context),
                                  value: args.characterSheet.basicAttributes!
                                          .strength ??
                                      0,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                CoCStat(
                                  stat:
                                      '$characterSheetTranslationPrefix.characteristics.dex'
                                          .translate(context),
                                  value: args.characterSheet.basicAttributes!
                                          .dexterity ??
                                      0,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                CoCStat(
                                  stat:
                                      '$characterSheetTranslationPrefix.characteristics.pow'
                                          .translate(context),
                                  value: args.characterSheet.basicAttributes!
                                          .power ??
                                      0,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                CoCStat(
                                  stat:
                                      '$characterSheetTranslationPrefix.characteristics.con'
                                          .translate(context),
                                  value: args.characterSheet.basicAttributes!
                                          .constitution ??
                                      0,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                CoCStat(
                                  stat:
                                      '$characterSheetTranslationPrefix.characteristics.app'
                                          .translate(context),
                                  value: args.characterSheet.basicAttributes!
                                          .appearance ??
                                      0,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                CoCStat(
                                  stat:
                                      '$characterSheetTranslationPrefix.characteristics.edu'
                                          .translate(context),
                                  value: args.characterSheet.basicAttributes!
                                          .education ??
                                      0,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                CoCStat(
                                  stat:
                                      '$characterSheetTranslationPrefix.characteristics.siz'
                                          .translate(context),
                                  value: args.characterSheet.basicAttributes!
                                          .size ??
                                      0,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                CoCStat(
                                  stat:
                                      '$characterSheetTranslationPrefix.characteristics.int'
                                          .translate(context),
                                  value: args.characterSheet.basicAttributes!
                                          .intelligence ??
                                      0,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                CoCStat(
                                    unique: true,
                                    stat:
                                        '$characterSheetTranslationPrefix.characteristics.moveRate'
                                            .translate(context),
                                    value: args.characterSheet
                                            .calculatedAttributes!.moveRate ??
                                        0)
                              ],
                            )
                          ],
                        ),
                      ),
                      // Características
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            BorderedContainer(
                              label:
                                  '$characterSheetTranslationPrefix.healthPoints.title'
                                      .translate(context),
                              children: [
                                LabeledSlider(
                                  enabled: false,
                                  value: args.characterSheet
                                          .calculatedAttributes!.healthPoints
                                          ?.toDouble() ??
                                      0.0,
                                  max: args.characterSheet.calculatedAttributes!
                                          .maximumHealthPoints
                                          ?.toDouble() ??
                                      0.0,
                                  onUpdate: (value) {},
                                ),
                                TitledText(
                                  title:
                                      '$characterSheetTranslationPrefix.healthPoints.maxHp'
                                          .translate(context),
                                  content: args
                                          .characterSheet
                                          .calculatedAttributes!
                                          .maximumHealthPoints
                                          ?.toString() ??
                                      '',
                                ),
                                LabeledCheckbox(
                                  enabled: false,
                                  label:
                                      '$characterSheetTranslationPrefix.healthPoints.majorWound'
                                          .translate(context),
                                  value: args.characterSheet
                                          .calculatedAttributes!.majorWounds ??
                                      false,
                                ),
                              ],
                            ),
                            BorderedContainer(
                              label:
                                  '$characterSheetTranslationPrefix.sanity.title'
                                      .translate(context),
                              children: [
                                LabeledSlider(
                                  enabled: false,
                                  value: args.characterSheet
                                          .calculatedAttributes!.sanity
                                          ?.toDouble() ??
                                      0.0,
                                  max: 99.0,
                                  onUpdate: (value) {},
                                ),
                                TitledText(
                                  title:
                                      '$characterSheetTranslationPrefix.sanity.maxSan'
                                          .translate(context),
                                  content: args.characterSheet
                                          .calculatedAttributes!.maximumSanity
                                          ?.toString() ??
                                      '',
                                ),
                                TitledText(
                                  title:
                                      '$characterSheetTranslationPrefix.sanity.initialSan'
                                          .translate(context),
                                  content: args.characterSheet
                                          .calculatedAttributes!.startingSanity
                                          ?.toString() ??
                                      '',
                                ),
                                LabeledCheckbox(
                                  enabled: false,
                                  label:
                                      '$characterSheetTranslationPrefix.sanity.tempInsanity'
                                          .translate(context),
                                  value: args
                                          .characterSheet
                                          .calculatedAttributes!
                                          .temporaryInsanity ??
                                      false,
                                ),
                                LabeledCheckbox(
                                  enabled: false,
                                  label:
                                      '$characterSheetTranslationPrefix.sanity.indefInsanity'
                                          .translate(context),
                                  value: args
                                          .characterSheet
                                          .calculatedAttributes!
                                          .indefiniteInsanity ??
                                      false,
                                ),
                              ],
                            ),
                            BorderedContainer(
                              label:
                                  '$characterSheetTranslationPrefix.magicPoints.title'
                                      .translate(context),
                              children: [
                                LabeledSlider(
                                  enabled: false,
                                  value: args.characterSheet
                                          .calculatedAttributes!.magicPoints
                                          ?.toDouble() ??
                                      0.0,
                                  onUpdate: (value) {},
                                  max: args.characterSheet.calculatedAttributes!
                                          .maximumMagicPoints
                                          ?.toDouble() ??
                                      0.0,
                                ),
                                TitledText(
                                  title:
                                      '$characterSheetTranslationPrefix.magicPoints.maxMp'
                                          .translate(context),
                                  content: args
                                          .characterSheet
                                          .calculatedAttributes!
                                          .maximumMagicPoints
                                          ?.toString() ??
                                      '',
                                ),
                              ],
                            ),
                            BorderedContainer(
                              label:
                                  '$characterSheetTranslationPrefix.luck.title'
                                      .translate(context),
                              children: [
                                LabeledSlider(
                                  value: args
                                          .characterSheet.basicAttributes!.luck
                                          ?.toDouble() ??
                                      0.0,
                                  onUpdate: (value) {},
                                  max: 99.0,
                                  enabled: false,
                                )
                              ],
                            ),
                            BorderedContainer(
                              label:
                                  '$characterSheetTranslationPrefix.combat.title'
                                      .translate(context),
                              children: [
                                CoCStat(
                                  unique: true,
                                  stat:
                                      '$characterSheetTranslationPrefix.combat.bonusDamage'
                                          .translate(context),
                                  value: args.characterSheet
                                          .calculatedAttributes?.bonusDamage ??
                                      '',
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                CoCStat(
                                  unique: true,
                                  stat:
                                      '$characterSheetTranslationPrefix.combat.build'
                                          .translate(context),
                                  value: args.characterSheet
                                          .calculatedAttributes?.build ??
                                      '',
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                CoCStat(
                                  stat:
                                      '$characterSheetTranslationPrefix.combat.dodge'
                                          .translate(context),
                                  value: args.characterSheet
                                          .calculatedAttributes?.dodge ??
                                      0,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Skills
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            BorderedContainer(
                              children: List.generate(
                                args.characterSheet.skills.length,
                                (index) {
                                  var item = args.characterSheet.skills[index];
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: index <
                                                args.characterSheet.skills
                                                        .length -
                                                    1
                                            ? 12
                                            : 0),
                                    child: CoCStat(
                                      stat: item.skillName ?? '',
                                      value: item.value ?? 0,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Weapons
                      Builder(
                        builder: (context) {
                          if (args.characterSheet.weapons.isEmpty) {
                            return const Center(
                              child: EmptyList(),
                            );
                          }
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: List.generate(
                                args.characterSheet.weapons.length,
                                (index) {
                                  var item = args.characterSheet.weapons[index];
                                  return Card(
                                    child: ListTile(
                                      title: ListTileTitle(
                                        item.nickname ??
                                            item.weapon?.name ??
                                            '',
                                      ),
                                      trailing: const Icon(Icons.info),
                                      onTap: () {
                                        showDialog(
                                          useSafeArea: true,
                                          context: context,
                                          builder: (context) => SimpleDialog(
                                            title: Text(item.nickname ??
                                                item.weapon?.name ??
                                                ''),
                                            contentPadding:
                                                const EdgeInsets.all(12),
                                            children: [
                                              if (item.weapon?.isMelee ??
                                                  false) ...[
                                                Badge(
                                                  label: Text(
                                                    '$characterSheetTranslationPrefix.weapons.advancedInfo.meleeWeapon'
                                                        .translate(context),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                              ],
                                              BorderedContainer(
                                                label:
                                                    '$characterSheetTranslationPrefix.weapons.basicInfo.title'
                                                        .translate(context),
                                                children: [
                                                  TitledText(
                                                    title:
                                                        '$characterSheetTranslationPrefix.weapons.basicInfo.damage'
                                                            .translate(context),
                                                    content:
                                                        item.weapon?.damage ??
                                                            '',
                                                  ),
                                                  TitledText(
                                                    title:
                                                        '$characterSheetTranslationPrefix.weapons.basicInfo.attacks'
                                                            .translate(context),
                                                    content: item.weapon
                                                            ?.attacksPerRound
                                                            ?.toString() ??
                                                        '',
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              BorderedContainer(
                                                label:
                                                    '$characterSheetTranslationPrefix.weapons.advancedInfo.title'
                                                        .translate(context),
                                                children: [
                                                  TitledText(
                                                    title:
                                                        '$characterSheetTranslationPrefix.weapons.advancedInfo.normalSuccess'
                                                            .translate(context),
                                                    content: item.successValue
                                                            ?.toString() ??
                                                        '',
                                                  ),
                                                  TitledText(
                                                    title:
                                                        '$characterSheetTranslationPrefix.weapons.advancedInfo.goodSuccess'
                                                            .translate(context),
                                                    content:
                                                        ((item.successValue ??
                                                                    0) /
                                                                2)
                                                            .floor()
                                                            .toString(),
                                                  ),
                                                  TitledText(
                                                    title:
                                                        '$characterSheetTranslationPrefix.weapons.advancedInfo.extremeSuccess'
                                                            .translate(context),
                                                    content:
                                                        ((item.successValue ??
                                                                    0) /
                                                                5)
                                                            .floor()
                                                            .toString(),
                                                  ),
                                                  if (!(item.weapon?.isMelee ??
                                                      false)) ...[
                                                    TitledText(
                                                      title:
                                                          '$characterSheetTranslationPrefix.weapons.advancedInfo.availableAmmo',
                                                      content:
                                                          '${item.roundsLeft} (${item.totalAmmoLeft})',
                                                    ),
                                                  ],
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      // Spells
                      Builder(
                        builder: (context) {
                          if (args.characterSheet.spells.isEmpty) {
                            return const EmptyList();
                          }
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: List.generate(
                                args.characterSheet.spells.length,
                                (index) {
                                  var item = args.characterSheet.spells[index];
                                  var spellName =
                                      '${item.spellChosenName}${item.onlyOniricLandscape ?? false ? ' (${'$characterSheetTranslationPrefix.spells.oniric'.translate(context)})' : ''}${item.folk ?? false ? ' (${'$characterSheetTranslationPrefix.spells.folk'.translate(context)})' : ''}${item.monsterKnowledge != null ? ' (${item.monsterKnowledge})' : ''}';
                                  return Card(
                                    child: ListTile(
                                      title: ListTileTitle(spellName),
                                      trailing: const Icon(Icons.info),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          useSafeArea: true,
                                          builder: (context) => SimpleDialog(
                                            title: Text(spellName),
                                            contentPadding:
                                                const EdgeInsets.all(12),
                                            children: [
                                              BorderedContainer(
                                                label:
                                                    '$characterSheetTranslationPrefix.spells.basicInfo'
                                                        .translate(context),
                                                children: [
                                                  TitledText(
                                                    title:
                                                        '$characterSheetTranslationPrefix.spells.cost'
                                                            .translate(context),
                                                    content: item.cost ?? '',
                                                  ),
                                                  TitledText(
                                                    title:
                                                        '$characterSheetTranslationPrefix.spells.castingTime'
                                                            .translate(context),
                                                    content:
                                                        item.conjuringTime ??
                                                            '',
                                                  ),
                                                  TitledText(
                                                    title:
                                                        '$characterSheetTranslationPrefix.spells.description'
                                                            .translate(context),
                                                    content:
                                                        item.spellDescription ??
                                                            '',
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      // Pulp talents
                      if (args.characterSheet.basicInfo!.pulpCthulhu ??
                          false) ...[
                        Builder(
                          builder: (context) {
                            if (args.characterSheet.pulpTalents.isEmpty) {
                              return const EmptyList();
                            }
                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: List.generate(
                                  args.characterSheet.pulpTalents.length,
                                  (index) {
                                    var item =
                                        args.characterSheet.pulpTalents[index];
                                    return Card(
                                      child: ListTile(
                                        title: ListTileTitle(item.name ?? ''),
                                        trailing: const Icon(Icons.info),
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            useSafeArea: true,
                                            builder: (context) => SimpleDialog(
                                              contentPadding:
                                                  const EdgeInsets.all(12),
                                              title: Text(
                                                item.name ?? '',
                                              ),
                                              children: [
                                                BorderedContainer(
                                                  label:
                                                      '$characterSheetTranslationPrefix.pulpTalent.description'
                                                          .translate(context),
                                                  children: [
                                                    Text(
                                                      item.description ?? '',
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
