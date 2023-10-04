import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpgtracker_app/extensions/string.dart';
import 'package:rpgtracker_app/providers/session_provider.dart';
import 'package:shimmer/shimmer.dart';

class SessionListScreen extends StatefulWidget {
  const SessionListScreen({super.key});

  @override
  State<SessionListScreen> createState() => _SessionListScreenState();
}

class _SessionListScreenState extends State<SessionListScreen> {
  SessionProvider? provider;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    provider = SessionProvider();
    Future.delayed(Duration.zero, () {
      provider!.getData();
    });
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
        title: Text('session:myDMedSessions'.translate(context)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ChangeNotifierProvider<SessionProvider>.value(
            value: provider!,
            child: Consumer<SessionProvider>(
              builder: (context, value, child) {
                if (value.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (value.data.isEmpty) {
                  return const Center(child: Text("Nada"));
                }
                return NotificationListener<ScrollEndNotification>(
                  onNotification: _handleScrollNotification,
                  child: ListView.separated(
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        var item = value.data[index];
                        return Card(
                          child: ListTile(
                            title: Text(
                              item.sessionName!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Shimmer.fromColors(
                              baseColor: Theme.of(context).hintColor,
                              highlightColor: Theme.of(context).highlightColor,
                              enabled: item.users == null,
                              child: const SizedBox(
                                height: 20,
                              ),
                            ),
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              child: Icon(
                                item.system!.icon,
                                color: Colors.black,
                              ),
                            ),
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
