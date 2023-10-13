class Endpoints {
  // Keycloak
  static const String keycloakBaseUrl = 'http://10.0.2.2:8083/realms/HBsites';
  static const String keycloakAuthUrl = '/protocol/openid-connect/auth';
  static const String keycloakTokenEndpoint = '/protocol/openid-connect/token';

  // Rpgtracker
  static const String rpgtrackerBaseUrl = 'http://10.0.2.2:8080';
  static const String rpgtrackerCorePermissionsGet = '/core/api/v1/user-config';
  static const String rpgtrackerCoreCharacterSheetGet =
      '/core/api/v1/my-character-sheets';
  static const String rpgtrackerCoreMyDmedSessionsGet =
      '/core/api/v1/my-dm-sessions';

  // RPGTracker - Call of Cthulhu
  static const String rpgtrackerCoCCharacterSheetGet =
      '/coc/api/v1/character-sheets/{sheetId}';
  static const String rpgtrackerCoCSessionGet =
      '/coc/api/v1/sessions/{sessionId}';

  // RPGTracker - Core - WS
  static const String rpgtrackerCoreWsUrl = 'ws://10.0.2.2:8080/core/ws';
  static const String rpgtrackerCoreWsUsers = '/topic/{userId}/users';

  // RPGTracker - Call of Cthulhu - WS
  static const String rpgtrackerCoCWsUrl = 'ws://10.0.2.2:8080/coc/ws';
  static const String rpgtrackerCoCWsCharacterInfo =
      '/topic/{userId}/character-sheet/{sheetId}/infos';
  static const String rpgtrackerCoCWsSessionDetails =
      '/topic/{userId}/sessions/{sessionId}';
}
