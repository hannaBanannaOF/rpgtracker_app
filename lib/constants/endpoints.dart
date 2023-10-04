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

  // RPGTracker - WS
  static const String rpgtrackerCoreWsUrl = 'ws://10.0.2.2:8080/core/ws';
  static const String rpgtrackerCoreWsUsers = '/topic/{userId}/users';
}
