import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:talking/configs/api/api.dart';
import 'package:talking/configs/storage/storage_manager.dart';
import 'package:talking/src/chat/data/models/message_model.dart';
import 'package:talking/src/chat/domain/entities/message_entity.dart';
import 'package:talking/src/chat/domain/usecases/get_last_chats_usecase.dart';
import 'package:talking/src/user/domain/entities/user_entity.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({
    required GetLastChatsUsecase getLastChatsUsecase,
    required StorageManager storageManager,
  })  : _getLastChatsUsecase = getLastChatsUsecase,
        _storageManager = storageManager,
        super(const ChatState()) {
    on<Connect>(_onConnect);
    on<ConnectClient>(_onConnectSocket);
    on<GetSelectedContactChats>(_onGetSelectedContactChats);
    on<GetSelectedContactChatsIfNeed>(_onGetSelectedContactChatsIdNeed);
    on<SendMessage>(_onSendMessage);
    on<MessageReceived>(_onMessageReceived);
    on<StopChat>(_onStopChat);
    on<ErrorReceived>(_onErrorReceived);
    on<SetRecipient>(_onSetTarget);
    on<Disconnect>(_onDisconnect);
  }

  final GetLastChatsUsecase _getLastChatsUsecase;
  final StorageManager _storageManager;
  late Socket _socket;

  void _onConnectSocket(
    ConnectClient event,
    Emitter<ChatState> emit,
  ) {
    emit(const ChatState(
      messages: [],
      recipient: User.empty,
      status: ChatStatus.online,
    ));
  }

  void _onGetSelectedContactChats(
    GetSelectedContactChats event,
    Emitter<ChatState> emit,
  ) async {
    final result = await _getLastChatsUsecase(state.recipient.uid);
    result.fold(
      (error) {
        emit(state.copyWith(
          status: ChatStatus.error,
          error: error.message,
        ));
      },
      (messages) {
        emit(state.copyWith(
          messages: messages,
          status: ChatStatus.loaded,
        ));
      },
    );
  }

  void _onGetSelectedContactChatsIdNeed(
    GetSelectedContactChatsIfNeed event,
    Emitter<ChatState> emit,
  ) {
    if (state.isOnline && state.messages.isEmpty) {
      add(const GetSelectedContactChats());
    }
  }

  void _onSendMessage(
    SendMessage event,
    Emitter<ChatState> emit,
  ) {
    final message = event.message.toModel();
    _socket.emit('personal-message', message.toJson());
    _addMessage(emit, event.message);
  }

  void _onMessageReceived(
    MessageReceived event,
    Emitter<ChatState> emit,
  ) {
    if (!state.isOnline) {
      return;
    }

    final response = MessageModel.fromJson(event.message);
    final message = Message.fromModel(response);

    _addMessage(emit, message);
  }

  void _onErrorReceived(
    ErrorReceived event,
    Emitter<ChatState> emit,
  ) {
    emit(state.copyWith(
      status: ChatStatus.error,
      error: event.error,
    ));
  }

  void _onStopChat(
    StopChat event,
    Emitter<ChatState> emit,
  ) {
    _socket.off('personal-message');
    if (state.isOnline) {
      emit(state.copyWith(messages: [], recipient: User.empty));
    }
  }

  void _onDisconnect(
    Disconnect event,
    Emitter<ChatState> emit,
  ) {
    _socket.disconnect();
    emit(const ChatState(status: ChatStatus.disconnected));
  }

  void _onSetTarget(
    SetRecipient event,
    Emitter<ChatState> emit,
  ) {
    // TODO(BRANDOM): Add a way to store messages for all clients (maybe hive or sqlite)
    if (event.recipient != state.recipient) {
      emit(state.copyWith(recipient: event.recipient, messages: []));
    }
  }

  /// Connects to the chat socket
  void _onConnect(
    Connect event,
    Emitter<ChatState> emit,
  ) {
    emit(const ChatState(status: ChatStatus.loading));
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
    )
      ..onConnect((_) => add(const ConnectClient()))
      ..on('personal-message', (data) => add(MessageReceived(data)))
      ..onError((data) => add(ErrorReceived(data.toString())))
      ..onDisconnect((_) => add(const Disconnect()));
  }

  void _addMessage(Emitter<ChatState> emit, Message message) {
    if (state.isOnline) {
      final messages = state.messages;
      emit(state.copyWith(messages: [message, ...messages]));
    }
  }
}
