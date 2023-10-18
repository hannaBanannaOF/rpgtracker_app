import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:rpgtracker_app/constants/routes.dart';
import 'package:rpgtracker_app/extensions/string.dart';
import 'package:rpgtracker_app/providers/coc/ammo_provider.dart';
import 'package:rpgtracker_app/screen/coc/ammo_detail_screen.dart';
import 'package:rpgtracker_app/services/coc/ammo_service.dart';
import 'package:rpgtracker_app/ui/empty_list.dart';
import 'package:rpgtracker_app/ui/list_tile_title.dart';
import 'package:rpgtracker_app/ui/toast.dart';

class CoCAmmoListScreen extends StatefulWidget {
  const CoCAmmoListScreen({super.key});

  @override
  State<CoCAmmoListScreen> createState() => _CoCAmmoListScreenState();
}

class _CoCAmmoListScreenState extends State<CoCAmmoListScreen> {
  CoCAmmoProvider? provider;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    provider = CoCAmmoProvider();
    provider!.getData();
  }

  @override
  void dispose() {
    provider!.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'listings:coc.ammo.title'.translate(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ChangeNotifierProvider<CoCAmmoProvider>.value(
            value: provider!,
            child: Consumer<CoCAmmoProvider>(
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
                      itemBuilder: (context, index) {
                        var item = value.data[index];
                        return Dismissible(
                          background: Container(
                            color: Theme.of(context).colorScheme.errorContainer,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 12),
                                  child: Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                          key: Key(item.id ?? ''),
                          confirmDismiss: (direction) async {
                            context.loaderOverlay.show();
                            var ret = await provider!.removeItem(
                                CoCAmmoService.deleteAmmo, item.id ?? '');
                            // ignore: use_build_context_synchronously
                            context.loaderOverlay.hide();
                            if (!ret) {
                              // ignore: use_build_context_synchronously
                              Toast.showDeleteError(context);
                            }
                            return ret;
                          },
                          onDismissed: (direction) {
                            provider!.removeAt(index);
                            Toast.showDeleteSuccess(context);
                          },
                          child: ListTile(
                            tileColor: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            title: ListTileTitle(
                              item.name ?? '',
                            ),
                            onTap: () async {
                              context.loaderOverlay.show();
                              var res = await provider!
                                  .getOne(CoCAmmoService.getOne, item.id!);
                              // ignore: use_build_context_synchronously
                              context.loaderOverlay.hide();
                              if (res != null) {
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pushNamed(
                                    Routes.cocAmmoDetailRoute,
                                    arguments: CoCAmmoDetailScreenArgs(res));
                              }
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
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
      provider!.getData(loadMore: true);
    }
    return false;
  }
}
