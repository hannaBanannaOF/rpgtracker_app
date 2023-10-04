import 'dart:convert';

import 'package:rpgtracker_app/constants/endpoints.dart';
import 'package:rpgtracker_app/data/listings/session.dart';
import 'package:rpgtracker_app/managers/get_it_helper.dart';
import 'package:rpgtracker_app/managers/session_manager.dart';
import 'package:rpgtracker_app/providers/base_provider.dart';
import 'package:rpgtracker_app/services/session_service.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class SessionProvider extends BaseProvider<SessionListing> {
  StompClient stompClient = StompClient(
    config: StompConfig(
      url: Endpoints.rpgtrackerCoreWsUrl,
      onConnect: onConnectcallback,
      onWebSocketError: (e) => print(e.toString()),
      onStompError: (d) => print('error stomp'),
      onDisconnect: (f) => print('disconnected'),
    ),
  );

  static void onConnectcallback(StompFrame connectFrame) {
    print("i think i work");
  }

  @override
  Future getData({bool loadMore = false}) async {
    await super.load(SessionService.getMyDmedSessions, loadMore);
    stompClient.subscribe(
        destination: Endpoints.rpgtrackerCoreWsUsers
            .replaceAll('{idUser}', getIt<SessionManager>().currentUser!.uuid),
        callback: (StompFrame connectFrame) {
          List<dynamic> result = json.decode(connectFrame.body ?? '[]');
          print(connectFrame.body);
          print(result);
          print('it worked');
        });
  }
}
