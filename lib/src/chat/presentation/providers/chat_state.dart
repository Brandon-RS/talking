// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:talking/src/user/domain/entities/user_entity.dart';

import '../../domain/entities/message_entity.dart';

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
    required this.targetUser,
  }) : super(ServerStatus.online);

  final List<Message> messages;
  final User targetUser;

  @override
  List<Object?> get props => [messages, serverStatus];

  ChatLoaded copyWith({
    List<Message>? messages,
    User? targetUser,
  }) {
    return ChatLoaded(
      messages: messages ?? this.messages,
      targetUser: targetUser ?? this.targetUser,
    );
  }
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
