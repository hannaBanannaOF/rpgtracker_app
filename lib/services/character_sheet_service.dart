import 'package:rpgtracker_app/constants/endpoints.dart';
import 'package:rpgtracker_app/data/details/coc/coc_character_sheet.dart';
import 'package:rpgtracker_app/data/listings/character_sheet.dart';
import 'package:rpgtracker_app/data/rest_result.dart';
import 'package:rpgtracker_app/extensions/response.dart';
import 'package:rpgtracker_app/managers/dio_helper.dart';

class CharacterSheetService {
  static Future<RestResult<CharacterSheetListing>?> getMyCharacterSheets(
      int page) async {
    var client = await DioClient.instance.client;
    RestResult<CharacterSheetListing>? result;
    var url = StringBuffer(Endpoints.rpgtrackerCoreCharacterSheetGet);
    if (page > 0) {
      url.write('?page=$page');
    }
    try {
      var response = await client.get(url.toString());
      if (response.isOk) {
        result = RestResult<CharacterSheetListing>.fromJson(
            response.data,
            (data) =>
                CharacterSheetListing.fromJson(data as Map<String, dynamic>));
      }
    } catch (_) {}
    return result;
  }

  static Future<CoCCharacterSheet?> getCoCCharacterSheet(String uuid) async {
    var client = await DioClient.instance.client;
    CoCCharacterSheet? result;
    try {
      var response = await client.get(Endpoints.rpgtrackerCoCCharacterSheetGet
          .replaceAll('{sheetId}', uuid));
      if (response.isOk) {
        result = CoCCharacterSheet.fromJson(response.data);
      }
    } catch (_) {}
    return result;
  }
}
