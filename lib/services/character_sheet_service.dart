import 'package:rpgtracker_app/constants/endpoints.dart';
import 'package:rpgtracker_app/data/listings/character_sheet.dart';
import 'package:rpgtracker_app/data/rest_result.dart';
import 'package:rpgtracker_app/extensions/response.dart';
import 'package:rpgtracker_app/managers/dio_helper.dart';

class CharacterSheetService {
  static Future<RestResult<CharacterSheetListing>?> getMyCharacterSheets(
      int page) async {
    var client = await DioClient.instance.client;
    RestResult<CharacterSheetListing>? result;
    try {
      var response =
          await client.get(Endpoints.rpgtrackerCoreCharacterSheetGet);
      if (response.isOk) {
        result = RestResult<CharacterSheetListing>.fromJson(
            response.data,
            (data) =>
                CharacterSheetListing.fromJson(data as Map<String, dynamic>));
      }
    } catch (_) {}
    return result;
  }
}
