import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rpgtracker_app/constants/endpoints.dart';
import 'package:rpgtracker_app/data/details/coc/coc_session_base.dart';
import 'package:rpgtracker_app/data/listings/session.dart';
import 'package:rpgtracker_app/data/ws/session_infos.dart';
import 'package:rpgtracker_app/data/ws/user_ws_response.dart';
import 'package:rpgtracker_app/managers/get_it_helper.dart';
import 'package:rpgtracker_app/managers/session_manager.dart';
import 'package:rpgtracker_app/providers/base_provider.dart';
import 'package:rpgtracker_app/services/session_service.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class SessionProvider extends BaseProvider<SessionListing> {
  final List<UserWSResponse> _users = [];
  List<UserWSResponse> get users => _users;

  final List<SessionSheets> _sessionSheets = [];
  List<SessionSheets> get sesionSheets => _sessionSheets;

  StompClient? _stompClient;

  void subscribe() {
    var dest = Endpoints.rpgtrackerCoreWsUsers
        .replaceAll('{userId}', getIt<SessionManager>().currentUser!.uuid);
    debugPrint('Subscribing to WS: $dest');
    _stompClient!.subscribe(
      destination: dest,
      callback: (StompFrame connectFrame) {
        debugPrint("Received WS message: ${connectFrame.body}");
        if (connectFrame.body?.contains('users') ?? false) {
          UserWSResponse result =
              UserWSResponse.fromJson(json.decode(connectFrame.body ?? '{}'));
          users.add(result);
          notifyListeners();
        }
      },
    );
  }

  void subscribeCoC(String uuid) {
    var dest = Endpoints.rpgtrackerCoCWsSessionDetails
        .replaceAll('{userId}', getIt<SessionManager>().currentUser!.uuid)
        .replaceAll('{sessionId}', uuid);
    debugPrint('Subscribing to WS: $dest');
    _stompClient!.subscribe(
      destination: dest,
      callback: (StompFrame connectFrame) {
        debugPrint("Received WS message: ${connectFrame.body}");
        if (connectFrame.body?.contains('infos') ?? false) {
          var infos =
              SessionInfos.fromJson(json.decode(connectFrame.body ?? '{}'));
          _sessionSheets.addAll(infos.infos.firstOrNull?.sessionSheets ?? []);
          notifyListeners();
        }
      },
    );
  }

  void resetListing() {
    _stompClient!.deactivate();
    _stompClient = null;
    _users.clear();
    super.reset();
  }

  void resetDetailCoC() {
    _initStompCore();
    _sessionSheets.clear();
  }

  void _initStompCore() {
    if (_stompClient != null && _stompClient!.isActive) {
      _stompClient!.deactivate();
    }
    _stompClient = StompClient(
      config: StompConfig(
        url: Endpoints.rpgtrackerCoreWsUrl,
        onConnect: (d) {
          if (d.command == 'CONNECTED') {
            debugPrint('Connected to WS: ${Endpoints.rpgtrackerCoreWsUrl}');
            subscribe();
          }
        },
        onWebSocketError: (e) => debugPrint(e.toString()),
        onStompError: (d) {
          debugPrint(d.body);
        },
        onDisconnect: (f) => debugPrint(
            'Disconnected from WS: ${Endpoints.rpgtrackerCoreWsUrl}'),
      ),
    );
    _stompClient!.activate();
  }

  void _initStompCoC(String uuid) {
    if (_stompClient != null && _stompClient!.isActive) {
      _stompClient!.deactivate();
    }
    _stompClient = StompClient(
      config: StompConfig(
        url: Endpoints.rpgtrackerCoCWsUrl,
        onConnect: (d) {
          if (d.command == 'CONNECTED') {
            debugPrint('Connected to WS: ${Endpoints.rpgtrackerCoCWsUrl}');
            subscribeCoC(uuid);
          }
        },
        onWebSocketError: (e) => debugPrint(e.toString()),
        onStompError: (d) {
          debugPrint(d.body);
        },
        onDisconnect: (f) =>
            debugPrint('Disconnected to WS: ${Endpoints.rpgtrackerCoCWsUrl}'),
      ),
    );
    _stompClient!.activate();
  }

  @override
  Future getData({bool loadMore = false}) async {
    _initStompCore();
    await super.load(SessionService.getMyDmedSessions, loadMore);
  }

  Future<CoCSessionBase?> getSessionDetails(String uuid) async {
    _initStompCoC(uuid);
    return await SessionService.getCoCSeesionDetails(uuid);
  }
}
