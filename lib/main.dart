import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18next/i18next.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:rpgtracker_app/constants/routes.dart';
import 'package:rpgtracker_app/managers/get_it_helper.dart';
import 'package:rpgtracker_app/managers/session_manager.dart';
import 'package:rpgtracker_app/providers/character_sheet_provider.dart';
import 'package:rpgtracker_app/providers/session_provider.dart';
import 'package:rpgtracker_app/screen/character_sheet_list_screen.dart';
import 'package:rpgtracker_app/screen/coc/ammo_detail_screen.dart';
import 'package:rpgtracker_app/screen/coc/ammo_list_screen.dart';
import 'package:rpgtracker_app/screen/coc/character_sheet_detail_screen.dart';
import 'package:rpgtracker_app/screen/coc/session_details_screen.dart';
import 'package:rpgtracker_app/screen/home_screen.dart';
import 'package:rpgtracker_app/screen/login_screen.dart';
import 'package:rpgtracker_app/screen/session_list_screen.dart';

void main() {
  initGetIt();
  runApp(const RPGTrackerApp());
}

class RPGTrackerApp extends StatefulWidget {
  const RPGTrackerApp({super.key});

  @override
  State<RPGTrackerApp> createState() => _RPGTrackerAppState();
}

class _RPGTrackerAppState extends State<RPGTrackerApp>
    with WidgetsBindingObserver {
  final CharacterSheetProvider characterSheetProvider =
      CharacterSheetProvider();
  final SessionProvider sessionProvider = SessionProvider();

  @override
  void initState() {
    super.initState();

    getIt<SessionManager>().init();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    characterSheetProvider.dispose();
    sessionProvider.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayColor: Colors.black.withOpacity(0.5),
      overlayWidget: const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF20C997),
        ),
      ),
      useDefaultLoading: false,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: characterSheetProvider),
          ChangeNotifierProvider.value(value: sessionProvider),
        ],
        child: MaterialApp(
          title: 'RPGTracker',
          themeMode: ThemeMode.dark,
          localizationsDelegates: [
            I18NextLocalizationDelegate(
              locales: const [Locale('en'), Locale('pt', 'BR'), Locale('es')],
              dataSource: AssetBundleLocalizationDataSource(
                bundlePath: 'i18n',
              ),
            ),
            ...GlobalMaterialLocalizations.delegates,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('pt', 'BR'),
            Locale('es')
          ],
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF20C997),
                brightness: Brightness.dark),
            useMaterial3: true,
          ),
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFF20C997)),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            Routes.sheetsRoute: (context) => const CharacterSheetListScreen(),
            Routes.sessionsRoute: (context) => const SessionListScreen(),
            Routes.cocSheetDetails: (context) =>
                const CoCCharacterScreenDetailScreen(),
            Routes.cocSessionDetails: (context) =>
                const CoCSessionDetailsScreen(),
            Routes.cocAmmoListingRoute: (context) => const CoCAmmoListScreen(),
            Routes.cocAmmoDetailRoute: (context) => const CoCAmmoDetailScreen(),
          },
          home: const ScreenBuilder(),
        ),
      ),
    );
  }
}

class ScreenBuilder extends StatelessWidget {
  const ScreenBuilder({super.key});

  void _stateListener(BuildContext context) {
    getIt<SessionManager>().stateStream.listen((SessionState? state) {
      if (state == SessionState.signedOut) {
        if (context.loaderOverlay.visible) {
          context.loaderOverlay.hide();
        }
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _stateListener(context);

    return StreamBuilder<SessionState>(
      stream: getIt<SessionManager>().stateStream,
      initialData: SessionState.loading,
      builder: (BuildContext context, AsyncSnapshot<SessionState> snapshot) {
        final state = snapshot.data!;
        return buildUi(context, state);
      },
    );
  }

  Widget buildUi(BuildContext context, SessionState state) {
    switch (state) {
      case SessionState.loading:
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      case SessionState.signedOut:
        return const LoginScreen();
      case SessionState.authenticated:
        return const HomeScreen();
    }
  }
}
