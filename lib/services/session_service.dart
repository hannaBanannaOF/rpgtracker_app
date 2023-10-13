import 'package:rpgtracker_app/constants/endpoints.dart';
import 'package:rpgtracker_app/data/details/coc/coc_session_base.dart';
import 'package:rpgtracker_app/data/listings/session.dart';
import 'package:rpgtracker_app/data/rest_result.dart';
import 'package:rpgtracker_app/extensions/response.dart';
import 'package:rpgtracker_app/managers/dio_helper.dart';

class SessionService {
  static Future<RestResult<SessionListing>?> getMyDmedSessions(int page) async {
    RestResult<SessionListing>? result;
    var client = await DioClient.instance.client;
    try {
      var response =
          await client.get(Endpoints.rpgtrackerCoreMyDmedSessionsGet);
      if (response.isOk) {
        result = RestResult<SessionListing>.fromJson(response.data,
            (data) => SessionListing.fromJson(data as Map<String, dynamic>));
      }
    } catch (_) {}
    return result;
  }

  static Future<CoCSessionBase?> getCoCSeesionDetails(String uuid) async {
    CoCSessionBase? result;
    var client = await DioClient.instance.client;
    try {
      var response = await client.get(
          Endpoints.rpgtrackerCoCSessionGet.replaceAll('{sessionId}', uuid));
      if (response.isOk) {
        result = CoCSessionBase.fromJson(response.data);
      }
    } catch (_) {}
    return result;
  }
}
