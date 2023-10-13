import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rpgtracker_app/constants/assets.dart';
import 'package:rpgtracker_app/constants/endpoints.dart';
import 'package:rpgtracker_app/extensions/string.dart';
import 'package:rpgtracker_app/managers/get_it_helper.dart';
import 'package:rpgtracker_app/managers/session_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: const AssetImage(Assets.loginBackground),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.multiply)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'login:welcome'.translate(context),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white),
                ),
                ElevatedButton(
                    onPressed: () async {
                      String? code = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const WebViewScreen(),
                        ),
                      );
                      if (code != null) {
                        // ignore: use_build_context_synchronously
                        context.loaderOverlay.show();
                        await getIt<SessionManager>().signIn(code);
                        // ignore: use_build_context_synchronously
                        context.loaderOverlay.hide();
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final WebViewController _controller = WebViewController();

  @override
  void initState() {
    super.initState();
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    _controller.setNavigationDelegate(
      NavigationDelegate(
        onWebResourceError: (_) {
          Navigator.of(context).pop();
        },
        onNavigationRequest: (navigationRequest) {
          if (navigationRequest.url.startsWith('http://10.0.2.2:3001')) {
            Navigator.of(context)
                .pop(Uri.parse(navigationRequest.url).queryParameters['code']);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
    _controller.loadRequest(Uri.parse(
        '${Endpoints.keycloakBaseUrl}${Endpoints.keycloakAuthUrl}?client_id=rpgtracker&response_type=code&redirect_uri=http://10.0.2.2:3001&scope=openid'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
