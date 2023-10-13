import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rpgtracker_app/constants/endpoints.dart';
import 'package:rpgtracker_app/data/details/coc/coc_character_sheet.dart';
import 'package:rpgtracker_app/data/listings/character_sheet.dart';
import 'package:rpgtracker_app/data/ws/character_infos.dart';
import 'package:rpgtracker_app/data/ws/user_ws_response.dart';
import 'package:rpgtracker_app/managers/get_it_helper.dart';
import 'package:rpgtracker_app/managers/session_manager.dart';
import 'package:rpgtracker_app/providers/base_provider.dart';
import 'package:rpgtracker_app/services/character_sheet_service.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class CharacterSheetProvider extends BaseProvider<CharacterSheetListing> {
  String? _selectedCharacterName;
  String? get selectedCharacterName => _selectedCharacterName;

  String? _selectedCharacterPlayerName;
  String? get selectedCharacterPlayerName => _selectedCharacterPlayerName;

  StompClient? _stompClient;

  void resetProvider() {
    _stompClient!.deactivate();
    _selectedCharacterName = null;
    _selectedCharacterPlayerName = null;
  }

  void subscribe(String uuid) {
    var dest = Endpoints.rpgtrackerCoCWsCharacterInfo
        .replaceAll('{userId}', getIt<SessionManager>().currentUser!.uuid)
        .replaceAll('{sheetId}', uuid);
    debugPrint('Subscribing to WS: $dest');
    _stompClient!.subscribe(
      destination: dest,
      callback: (StompFrame connectFrame) {
        debugPrint("Received WS message: ${connectFrame.body}");
        if (connectFrame.body?.contains('users') ?? false) {
          var users =
              UserWSResponse.fromJson(json.decode(connectFrame.body ?? '{}'));
          _selectedCharacterPlayerName = users.users.firstOrNull?.displayName;
          notifyListeners();
        }
        if (connectFrame.body?.contains('infos') ?? false) {
          var infos =
              CharacterInfos.fromJson(json.decode(connectFrame.body ?? '{}'));
          _selectedCharacterName = infos.infos.firstOrNull?.characterName;
          notifyListeners();
        }
      },
    );
  }

  @override
  Future getData({bool loadMore = false}) async {
    await super.load(CharacterSheetService.getMyCharacterSheets, loadMore);
  }

  Future<CoCCharacterSheet?> loadCoCSheet(String uuid) async {
    _stompClient = StompClient(
      config: StompConfig(
        url: Endpoints.rpgtrackerCoCWsUrl,
        onConnect: (d) {
          if (d.command == 'CONNECTED') {
            debugPrint('Connected to WS: ${Endpoints.rpgtrackerCoCWsUrl}');
            subscribe(uuid);
          }
        },
        onWebSocketError: (e) => debugPrint(e.toString()),
        onStompError: (d) {
          debugPrint(d.body);
        },
        onDisconnect: (f) =>
            debugPrint('Disconnected from WS: ${Endpoints.rpgtrackerCoCWsUrl}'),
      ),
    );
    _stompClient!.activate();
    return await CharacterSheetService.getCoCCharacterSheet(uuid);
  }
}
