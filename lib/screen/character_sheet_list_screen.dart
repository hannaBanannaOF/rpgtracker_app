import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpgtracker_app/extensions/string.dart';
import 'package:rpgtracker_app/providers/character_sheet_provider.dart';

class CharacterSheetListScreen extends StatefulWidget {
  const CharacterSheetListScreen({super.key});

  @override
  State<CharacterSheetListScreen> createState() =>
      _CharacterSheetListScreenState();
}

class _CharacterSheetListScreenState extends State<CharacterSheetListScreen> {
  CharacterSheetProvider? provider;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    provider = CharacterSheetProvider();
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
        title: Text('characterSheet:myCharacterSheets'.translate(context)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ChangeNotifierProvider<CharacterSheetProvider>.value(
            value: provider!,
            child: Consumer<CharacterSheetProvider>(
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
                              item.characterName!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: item.session != null
                                ? Text('characterSheet:characterSheetSession'
                                    .translate(context, args: {
                                    'sessionName': item.session!.sessionName!
                                  }))
                                : null,
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
