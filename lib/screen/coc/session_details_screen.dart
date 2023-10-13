import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:rpgtracker_app/constants/routes.dart';
import 'package:rpgtracker_app/data/details/coc/coc_session_base.dart';
import 'package:rpgtracker_app/extensions/string.dart';
import 'package:rpgtracker_app/providers/character_sheet_provider.dart';
import 'package:rpgtracker_app/providers/session_provider.dart';
import 'package:rpgtracker_app/screen/coc/character_sheet_detail_screen.dart';
import 'package:rpgtracker_app/ui/list_tile_title.dart';
import 'package:rpgtracker_app/ui/skeleton.dart';

class CoCSessionDetailScreenArgs {
  CoCSessionBase sessionBase;
  String screenTitle;

  CoCSessionDetailScreenArgs(this.sessionBase, this.screenTitle);
}

class CoCSessionDetailsScreen extends StatefulWidget {
  const CoCSessionDetailsScreen({super.key});

  @override
  State<CoCSessionDetailsScreen> createState() =>
      _CoCSessionDetailsScreenState();
}

class _CoCSessionDetailsScreenState extends State<CoCSessionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as CoCSessionDetailScreenArgs;
    return WillPopScope(
      onWillPop: () async {
        Provider.of<SessionProvider>(context, listen: false).resetDetailCoC();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(args.screenTitle),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ChangeNotifierProvider<SessionProvider>.value(
              value: Provider.of<SessionProvider>(context),
              child: Consumer<SessionProvider>(
                builder: (context, value, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTileTitle(
                        'session:coc.sessionSheets'.translate(context),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: Skeleton(
                          enabled: value.sesionSheets.isEmpty,
                          size: 120,
                          child: ListView.separated(
                            itemCount: value.sesionSheets.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 8,
                            ),
                            itemBuilder: (context, index) {
                              var item = value.sesionSheets[index];
                              return Card(
                                child: ListTile(
                                  title: ListTileTitle(
                                    item.characterName ?? '',
                                  ),
                                  trailing: const Icon(Icons.chevron_right),
                                  onTap: () async {
                                    context.loaderOverlay.show();
                                    var sheet = await Provider.of<
                                                CharacterSheetProvider>(context,
                                            listen: false)
                                        .loadCoCSheet(item.uuid ?? '');
                                    // ignore: use_build_context_synchronously
                                    context.loaderOverlay.hide();
                                    if (sheet != null) {
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context).pushNamed(
                                        Routes.cocSheetDetails,
                                        arguments:
                                            CoCCharacterSheetDetailScreenArgs(
                                          item.characterName ?? '',
                                          sheet,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
