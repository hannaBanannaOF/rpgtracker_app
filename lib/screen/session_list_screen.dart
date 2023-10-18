import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:rpgtracker_app/constants/routes.dart';
import 'package:rpgtracker_app/data/listings/session.dart';
import 'package:rpgtracker_app/data/ws/user_ws_response.dart';
import 'package:rpgtracker_app/extensions/string.dart';
import 'package:rpgtracker_app/providers/session_provider.dart';
import 'package:rpgtracker_app/screen/coc/session_details_screen.dart';
import 'package:rpgtracker_app/ui/empty_list.dart';
import 'package:rpgtracker_app/ui/list_tile_title.dart';
import 'package:rpgtracker_app/ui/skeleton.dart';

class SessionListScreen extends StatefulWidget {
  const SessionListScreen({super.key});

  @override
  State<SessionListScreen> createState() => _SessionListScreenState();
}

class _SessionListScreenState extends State<SessionListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Provider.of<SessionProvider>(context, listen: false).getData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<SessionProvider>(context, listen: false).resetListing();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('session:myDMedSessions'.translate(context)),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ChangeNotifierProvider<SessionProvider>.value(
              value: Provider.of<SessionProvider>(context),
              child: Consumer<SessionProvider>(
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
                          return Card(
                            color: Colors.transparent,
                            child: ListTile(
                              tileColor: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              title: ListTileTitle(
                                item.sessionName!,
                              ),
                              subtitle: buildAvatarGroup(item, value.users),
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
                                var session =
                                    await Provider.of<SessionProvider>(context,
                                            listen: false)
                                        .getSessionDetails(item.uuid ?? '');
                                // ignore: use_build_context_synchronously
                                context.loaderOverlay.hide();
                                if (session != null) {
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pushNamed(
                                    Routes.cocSessionDetails,
                                    arguments: CoCSessionDetailScreenArgs(
                                        session, item.sessionName ?? ''),
                                  );
                                }
                              },
                            ),
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
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      Provider.of<SessionProvider>(context, listen: false)
          .getData(loadMore: true);
    }
    return false;
  }

  Widget? buildAvatarGroup(
      SessionListing session, List<UserWSResponse> usersInfo) {
    UserWSResponse data = usersInfo.lastWhere((u) => u.session == session.uuid,
        orElse: () => UserWSResponse());

    int surplus = 0;
    List<UsersWS> users = [];
    // check for surplus
    if (data.users.isNotEmpty) {
      if (data.users.length > 3) {
        surplus = data.users.length - 3;
        users = data.users.sublist(0, 3);
      } else {
        users = data.users;
      }
    }

    List<Widget> avatars = users
        .map(
          (e) => Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 0.2,
                  blurRadius: 7,
                  offset: Offset(-1, 0),
                ),
              ],
            ),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(
                '${e.firstName != null ? e.firstName.toString()[0].toUpperCase() : ''}${e.lastName != null ? e.lastName.toString()[0].toUpperCase() : ''}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
        .toList();

    if (surplus > 0) {
      avatars.add(
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                spreadRadius: 0.2,
                blurRadius: 7,
                offset: Offset(-1, 0),
              ),
            ],
          ),
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              '+$surplus',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    return Skeleton(
      enabled: users.isEmpty,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: RowSuper(
          innerDistance: -20,
          children: avatars,
        ),
      ),
    );
  }
}
