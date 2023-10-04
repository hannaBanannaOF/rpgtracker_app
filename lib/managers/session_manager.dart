import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rpgtracker_app/constants/endpoints.dart';
import 'package:rpgtracker_app/managers/preferences.dart';
import 'package:rpgtracker_app/managers/dio_helper.dart';
import 'package:rxdart/rxdart.dart';

enum SessionState { loading, signedOut, authenticated }

class User {
  bool isUser = false;
  String name = '';
  String uuid = '';
  Permissions permissions = Permissions();

  User(this.isUser, this.name, this.uuid, this.permissions);
}

class Permissions {
  bool? isCocDm;
  bool? hasCocSheet;

  Permissions();

  Permissions.create(this.isCocDm, this.hasCocSheet);
}

class SessionManager {
  final _streamController = BehaviorSubject<SessionState>();
  Stream<SessionState> get stateStream => _streamController.stream;

  late Preferences _prefs;

  User? _currentUser;
  User? get currentUser => _currentUser;

  Future init() async {
    _streamController.add(SessionState.loading);

    try {
      _prefs = await Preferences.instance;
      String? token = _prefs.getAccessToken();
      String? refresh = _prefs.getRefreshToken();

      // try to refresh token if exists
      if (token != null && JwtDecoder.isExpired(token) && refresh != null) {
        token = await _refreshToken(refresh);
      }
      // if token = null, signOut user
      if (token == null) {
        signOut();
      } else {
        // otherwise, decode token and get permissions
        Map<String, dynamic> decoded = JwtDecoder.decode(token);
        bool isUser =
            decoded['resource_access']['rpgtracker']['roles'].contains('user');
        if (!isUser) {
          signOut();
        } else {
          Permissions p = await _getPermissions();
          _currentUser = User(
              isUser,
              decoded['given_name'] ?? decoded['preferred_username'] ?? 'Anon',
              decoded['sub'],
              p);
          _streamController.add(SessionState.authenticated);
        }
      }
      // on any error, sign out user
    } catch (_) {
      signOut();
    }
  }

  void signIn(String code) async {
    Dio dio = Dio();
    var response = await dio.post(
        '${Endpoints.keycloakBaseUrl}${Endpoints.keycloakTokenEndpoint}',
        data: {
          'redirect_uri': 'http://10.0.2.2:3001',
          'grant_type': 'authorization_code',
          'client_id': 'rpgtracker',
          'code': code,
          'scope': 'openid'
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
    if (response.statusCode == 200) {
      _prefs.setAccessToken(response.data['access_token']);
      _prefs.setRefreshToken(response.data['refresh_token']);
    }
    init();
  }

  Future<Permissions> _getPermissions() async {
    Permissions p = Permissions();
    RestClientDio client = await DioClient.instance.client;
    var response = await client.get(Endpoints.rpgtrackerCorePermissionsGet);
    if (response.statusCode == 200) {
      p.hasCocSheet = response.data['hasCocSheet'];
      p.isCocDm = response.data['cocDm'];
    }
    return p;
  }

  void signOut() {
    _prefs.removeTokens();
    _streamController.add(SessionState.signedOut);
  }

  Future<String?> _refreshToken(refresh) async {
    String? token;
    Dio dio = Dio();
    var response = await dio.post(
        '${Endpoints.keycloakBaseUrl}${Endpoints.keycloakTokenEndpoint}',
        data: {
          'grant_type': 'refresh_token',
          'client_id': 'rpgtracker',
          'refresh_token': refresh,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
    if (response.statusCode == 200) {
      token = response.data['access_token'];
      refresh = response.data['refresh_token'];
      _prefs.setAccessToken(token!);
      _prefs.setRefreshToken(refresh!);
    }
    return token;
  }
}
