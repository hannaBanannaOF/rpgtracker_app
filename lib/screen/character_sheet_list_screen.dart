import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:rpgtracker_app/constants/routes.dart';
import 'package:rpgtracker_app/extensions/string.dart';
import 'package:rpgtracker_app/providers/character_sheet_provider.dart';
import 'package:rpgtracker_app/screen/coc/character_sheet_detail_screen.dart';
import 'package:rpgtracker_app/ui/empty_list.dart';
import 'package:rpgtracker_app/ui/list_tile_title.dart';

class CharacterSheetListScreen extends StatefulWidget {
  const CharacterSheetListScreen({super.key});

  @override
  State<CharacterSheetListScreen> createState() =>
      _CharacterSheetListScreenState();
}

class _CharacterSheetListScreenState extends State<CharacterSheetListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<CharacterSheetProvider>(context, listen: false).getData();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('characterSheet:myCharacterSheets'.translate(context)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ChangeNotifierProvider<CharacterSheetProvider>.value(
            value: Provider.of<CharacterSheetProvider>(context),
            child: Consumer<CharacterSheetProvider>(
              builder: (context, value, child) {
                if (value.loading) {
                  context.loaderOverlay.show();
                } else {
                  context.loaderOverlay.hide();
                }
                if (value.data.isEmpty && !value.loading) {
                  return const EmptyList();
                }
                return NotificationListener<ScrollEndNotification>(
                  onNotification: _handleScrollNotification,
                  child: ListView.separated(
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        var item = value.data[index];
                        return ListTile(
                          tileColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          title: ListTileTitle(
                            item.characterName!,
                          ),
                          subtitle: item.session != null
                              ? Text('characterSheet:characterSheetSession'
                                  .translate(context, args: {
                                  'sessionName': item.session!.sessionName!
                                }))
                              : null,
                          leading: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            child: Icon(
                              item.system!.icon,
                              color: Colors.black,
                            ),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () async {
                            context.loaderOverlay.show();
                            var sheet =
                                await Provider.of<CharacterSheetProvider>(
                                        context,
                                        listen: false)
                                    .loadCoCSheet(item.uuid ?? '');
                            // ignore: use_build_context_synchronously
                            context.loaderOverlay.hide();
                            if (sheet != null) {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pushNamed(
                                Routes.cocSheetDetails,
                                arguments: CoCCharacterSheetDetailScreenArgs(
                                  item.characterName ?? '',
                                  sheet,
                                ),
                              );
                            }
                          },
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 8,
                          ),
                      itemCount: value.data.length),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      Provider.of<CharacterSheetProvider>(context, listen: false)
          .getData(loadMore: true);
    }
    return false;
  }
}
