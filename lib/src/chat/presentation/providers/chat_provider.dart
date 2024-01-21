import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../../configs/api/api.dart';
import '../../../../configs/di/injector.dart';
import '../../../../configs/storage/storage_manager.dart';
import '../../../user/domain/entities/user_entity.dart';
import '../../data/models/message_model.dart';
import '../../domain/entities/message_entity.dart';
import 'chat_state.dart';

part 'chat_provider.g.dart';

@Riverpod(keepAlive: true)
class Chat extends _$Chat {
  @override
  ChatState build() {
    _storageManager = sl<StorageManager>();
    return const ChatInitial();
  }

  late Socket _socket;
  late StorageManager _storageManager;

  void connect() {
    _socket = io(
      Api.chat,
      OptionBuilder()
          .setTransports(['websocket'])
          .setExtraHeaders(
            {StorageManager.xToken: _storageManager.currentToken},
          )
          .enableAutoConnect()
          .enableForceNew()
          .build(),
    );

    _socket.onConnect((_) {
      state = ChatLoaded(
        // TODO(BRANDOM): Load messages here
        messages: const [],
        targetUser: User.empty(),
      );
    });

    _socket.on('personal-message', (data) {
      if (state is! ChatLoaded) {
        return;
      }

      final response = MessageModel.fromJson(data);
      final message = Message.fromModel(response);

      _addMessage(message);
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

  void setTargetUser(User user) {
    if (state is ChatLoaded) {
      state = (state as ChatLoaded).copyWith(targetUser: user);
    }
  }

  void sendMessage(Message chat) {
    final message = chat.toModel();

    _socket.emit('personal-message', message.toJson());
    _addMessage(chat);
  }

  void _addMessage(Message message) {
    if (state is ChatLoaded) {
      final messages = (state as ChatLoaded).messages;
      state = (state as ChatLoaded).copyWith(messages: [message, ...messages]);
    }
  }

  void stopChat() {
    _socket.off('personal-message');
  }

  void disconnect() {
    _socket.disconnect();
    state = const ChatDisconnected();
  }
}
