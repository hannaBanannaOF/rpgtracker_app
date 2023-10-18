import 'package:flutter/material.dart';
import 'package:rpgtracker_app/constants/routes.dart';
import 'package:rpgtracker_app/extensions/string.dart';
import 'package:rpgtracker_app/managers/get_it_helper.dart';
import 'package:rpgtracker_app/managers/session_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MenuItem> _menu = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _menu = _buildMenu();
    return Scaffold(
      appBar: AppBar(
        title: const Text('RPGTracker'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text('home:welcomeBack'.translate(context, args: {
                'userName': getIt<SessionManager>().currentUser?.name ?? 'Anon'
              }))
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView.separated(
          itemBuilder: (context, index) {
            MenuItem item = _menu[index];
            if (item.route != null) {
              return ListTile(
                title: Text(item.label),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, item.route!);
                },
              );
            } else {
              return ExpansionTile(
                title: Text(item.label),
                children: (item.subMenu ?? [])
                    .map(
                      (e) => ListTile(
                        title: Text(e.label),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.pushNamed(context, e.route!);
                        },
                      ),
                    )
                    .toList(),
              );
            }
          },
          itemCount: _menu.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 8,
          ),
        ),
      ),
    );
  }

  List<MenuItem> _buildMenu() {
    List<MenuItem> menu = [
      MenuItem('menu:main.myCHaracterSheets'.translate(context),
          route: Routes.sheetsRoute)
    ];
    if (getIt<SessionManager>().currentUser?.permissions.isCocDm ?? false) {
      menu.add(MenuItem('menu:main.MyDMedSessions'.translate(context),
          route: Routes.sessionsRoute));
    }
    if (getIt<SessionManager>().currentUser?.permissions.hasCocSheet ?? false) {
      menu.add(MenuItem('menu:main.coc'.translate(context), subMenu: [
        MenuItem('menu:coc.ammo'.translate(context),
            route: Routes.cocAmmoListingRoute),
        MenuItem('menu:coc.occupations'.translate(context),
            route: Routes.cocOccupationsListingRoute),
        MenuItem('menu:coc.pulpTalents'.translate(context),
            route: Routes.cocPulpTalentsListingRoute),
        MenuItem('menu:coc.skills'.translate(context),
            route: Routes.cocSkillsListingRoute),
        MenuItem('menu:coc.weapons'.translate(context),
            route: Routes.cocWeaponsListingRoute),
        MenuItem('menu:coc.spells'.translate(context),
            route: Routes.cocSpellsListingRoute)
      ]));
    }
    return menu;
  }
}

class MenuItem {
  String label;
  String? route;
  List<MenuItem>? subMenu;

  MenuItem(this.label, {this.route, this.subMenu});
}
