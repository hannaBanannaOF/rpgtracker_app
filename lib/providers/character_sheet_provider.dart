import 'package:rpgtracker_app/data/listings/character_sheet.dart';
import 'package:rpgtracker_app/providers/base_provider.dart';
import 'package:rpgtracker_app/services/character_sheet_service.dart';

class CharacterSheetProvider extends BaseProvider<CharacterSheetListing> {
  @override
  Future getData({bool loadMore = false}) async {
    await super.load(CharacterSheetService.getMyCharacterSheets, loadMore);
  }
}
