import 'package:equatable/equatable.dart';

enum ServerStatus {
  online,
  offline,
  connecting,
}

abstract class ChatState extends Equatable {
  const ChatState(this.serverStatus);

  final ServerStatus serverStatus;

  bool get isOnline => serverStatus == ServerStatus.online;

  bool get isOffline => serverStatus == ServerStatus.offline;

  bool get isConnecting => serverStatus == ServerStatus.connecting;

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {
  const ChatInitial() : super(ServerStatus.offline);
}

class ChatLoading extends ChatState {
  const ChatLoading() : super(ServerStatus.connecting);
}

class ChatLoaded extends ChatState {
  const ChatLoaded({
    required this.messages,
  }) : super(ServerStatus.online);

  final List<String> messages;

  @override
  List<Object?> get props => [messages, serverStatus];
}

class ChatDisconnected extends ChatState {
  const ChatDisconnected() : super(ServerStatus.offline);
}

class ChatError extends ChatState {
  const ChatError(
    this.message,
  ) : super(ServerStatus.offline);

  final String message;

  @override
  List<Object?> get props => [message, serverStatus];
}
