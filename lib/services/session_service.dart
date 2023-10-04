import 'package:rpgtracker_app/constants/endpoints.dart';
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
}
