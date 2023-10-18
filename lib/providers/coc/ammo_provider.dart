import 'package:rpgtracker_app/data/details/coc/ammo.dart';
import 'package:rpgtracker_app/providers/base_provider.dart';
import 'package:rpgtracker_app/services/coc/ammo_service.dart';

class CoCAmmoProvider extends BaseProvider<CoCAmmoDTO> {
  @override
  Future getData({bool loadMore = false}) async {
    await super.load(CoCAmmoService.getAllAmmo, loadMore);
  }
}
