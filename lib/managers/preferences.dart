import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Preferences? _instance;
  static late SharedPreferences _prefs;

  static Future<Preferences> get instance async {
    if (_instance == null) {
      _instance = Preferences();
      await _instance!.init();
    }
    return _instance!;
  }

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String? getAccessToken() {
    return _prefs.getString('access_token');
  }

  void setAccessToken(String value) {
    _prefs.setString('access_token', value);
  }

  String? getRefreshToken() {
    return _prefs.getString('refresh_token');
  }

  void setRefreshToken(String value) {
    _prefs.setString('refresh_token', value);
  }

  void removeTokens() {
    _prefs.remove('access_token');
    _prefs.remove('refresh_token');
  }
}
