import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../../configs/api/api.dart';
import 'chat_state.dart';

part 'chat_provider.g.dart';

enum ServerStatus {
  online,
  offline,
  connecting,
}

@riverpod
class Chat extends _$Chat {
  @override
  ChatState build() {
    _init();
    return const ChatInitial();
  }

  late Socket _socket;
  ServerStatus serverStatus = ServerStatus.connecting;

  void _init() {
    _socket = io(
      Api.baseURL,
      OptionBuilder().setTransports(['websocket']).enableAutoConnect().build(),
    );

    _socket.onConnect((_) {
      serverStatus = ServerStatus.online;
      state = const ChatLoaded(messages: []);
    });

    _socket.onError(
      (data) => state = ChatError(data.toString()),
    );

    _socket.onDisconnect((_) {
      serverStatus = ServerStatus.offline;
      state = const ChatDisconnected();
    });
  }
}
