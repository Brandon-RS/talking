import 'package:equatable/equatable.dart';

enum ServerStatus {
  online,
  offline,
  connecting,
}

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {
  const ChatInitial();

  final ServerStatus serverStatus = ServerStatus.offline;
}

class ChatLoading extends ChatState {
  const ChatLoading();

  final ServerStatus serverStatus = ServerStatus.connecting;
}

class ChatLoaded extends ChatState {
  const ChatLoaded({
    required this.messages,
  });

  final List<String> messages;
  final ServerStatus serverStatus = ServerStatus.online;

  @override
  List<Object?> get props => [messages, serverStatus];
}

class ChatDisconnected extends ChatState {
  const ChatDisconnected();

  final ServerStatus serverStatus = ServerStatus.offline;
}

class ChatError extends ChatState {
  const ChatError(this.message);

  final String message;
  final ServerStatus serverStatus = ServerStatus.offline;

  @override
  List<Object?> get props => [message, serverStatus];
}
