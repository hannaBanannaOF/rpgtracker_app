import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18next/i18next.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rpgtracker_app/constants/routes.dart';
import 'package:rpgtracker_app/managers/get_it_helper.dart';
import 'package:rpgtracker_app/managers/session_manager.dart';
import 'package:rpgtracker_app/screen/character_sheet_list_screen.dart';
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
  @override
  void initState() {
    super.initState();

    getIt<SessionManager>().init();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPGTracker',
      themeMode: ThemeMode.dark,
      localizationsDelegates: [
        I18NextLocalizationDelegate(
          locales: const [Locale('en'), Locale('pt', 'BR'), Locale('es')],
          dataSource: AssetBundleLocalizationDataSource(
            bundlePath: 'i18n',
          ),
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('en'), Locale('pt', 'BR'), Locale('es')],
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF20C997), brightness: Brightness.dark),
          useMaterial3: true),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF20C997)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        Routes.sheetsRoute: (context) => const CharacterSheetListScreen(),
        Routes.sessionsRoute: (context) => const SessionListScreen()
      },
      home: const LoaderOverlay(
        child: ScreenBuilder(),
      ),
    );
  }
}

class ScreenBuilder extends StatelessWidget {
  const ScreenBuilder({super.key});

  void _stateListener(BuildContext context) {
    getIt<SessionManager>().stateStream.listen((SessionState? state) {
      if (state == SessionState.signedOut) {
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
          color: Colors.white,
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
