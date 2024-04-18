part of 'chat_bloc.dart';

enum ChatStatus { initial, loading, online, loaded, disconnected, error }

final class ChatState extends Equatable {
  const ChatState({
    this.status = ChatStatus.initial,
    this.messages = const [],
    this.recipient = User.empty,
    this.error = '',
  });

  final ChatStatus status;
  final List<Message> messages;
  final User recipient;
  final String error;

  ChatState copyWith({
    ChatStatus? status,
    List<Message>? messages,
    User? recipient,
    String? error,
  }) {
    return ChatState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      recipient: recipient ?? this.recipient,
      error: error ?? this.error,
    );
  }

  bool get isOnline => status == ChatStatus.online || status == ChatStatus.loaded || status == ChatStatus.loading;

  @override
  List<Object> get props => [status, messages, recipient];
}
