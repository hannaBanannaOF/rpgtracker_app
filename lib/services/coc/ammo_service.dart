import 'package:rpgtracker_app/constants/endpoints.dart';
import 'package:rpgtracker_app/data/details/coc/ammo.dart';
import 'package:rpgtracker_app/data/rest_result.dart';
import 'package:rpgtracker_app/extensions/response.dart';
import 'package:rpgtracker_app/managers/dio_helper.dart';

class CoCAmmoService {
  static Future<RestResult<CoCAmmoDTO>?> getAllAmmo(int page) async {
    RestResult<CoCAmmoDTO>? result;
    var client = await DioClient.instance.client;
    var url = StringBuffer(Endpoints.rpgtrackerCoCAmmoListGet);
    if (page > 0) {
      url.write('?page=$page');
    }
    try {
      var response = await client.get(url.toString());
      if (response.isOk) {
        result = RestResult<CoCAmmoDTO>.fromJson(response.data,
            (data) => CoCAmmoDTO.fromJson(data as Map<String, dynamic>));
      }
    } catch (_) {}
    return result;
  }

  static Future<CoCAmmoDTO?> getOne(String id) async {
    CoCAmmoDTO? result;
    var client = await DioClient.instance.client;
    try {
      var response = await client
          .get(Endpoints.rpgtrackerCoCAmmoDelete.replaceAll('{ammoId}', id));
      if (response.isOk) {
        result = CoCAmmoDTO.fromJson(response.data);
      }
    } catch (_) {}
    return result;
  }

  static Future<bool> deleteAmmo(String id) async {
    var client = await DioClient.instance.client;
    try {
      var response = await client
          .delete(Endpoints.rpgtrackerCoCAmmoDelete.replaceAll('{ammoId}', id));
      return response.isOk;
    } catch (_) {}
    return false;
  }
}
