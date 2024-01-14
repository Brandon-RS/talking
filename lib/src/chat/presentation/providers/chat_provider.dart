import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../../configs/api/api.dart';
import 'chat_state.dart';

part 'chat_provider.g.dart';

@Riverpod(keepAlive: true)
class Chat extends _$Chat {
  @override
  ChatState build() => const ChatInitial();

  late Socket _socket;

  void connect() {
    _socket = io(
      Api.chat,
      OptionBuilder().setTransports(['websocket']).enableAutoConnect().enableForceNew().build(),
    );

    _socket.onConnect((_) {
      state = const ChatLoaded(
        // TODO(BRANDOM): Load messages here
        messages: [],
      );
    });

    _socket.onError(
      (data) {
        state = ChatError(data.toString());
      },
    );

    _socket.onDisconnect((_) {
      state = const ChatDisconnected();
    });
  }

  void disconnect() {
    _socket.disconnect();
  }
}
