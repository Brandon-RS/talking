part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

final class Connect extends ChatEvent {
  const Connect();
}

final class Disconnect extends ChatEvent {
  const Disconnect();
}

final class GetSelectedContactChats extends ChatEvent {
  const GetSelectedContactChats();
}

final class GetSelectedContactChatsIfNeed extends ChatEvent {
  const GetSelectedContactChatsIfNeed();
}

final class SendMessage extends ChatEvent {
  const SendMessage(this.message);

  final Message message;

  @override
  List<Object> get props => [message];
}

final class MessageReceived extends ChatEvent {
  const MessageReceived(this.message);

  final dynamic message;

  @override
  List<Object> get props => [message];
}

final class ErrorReceived extends ChatEvent {
  const ErrorReceived(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

final class StopChat extends ChatEvent {
  const StopChat();
}

final class SetRecipient extends ChatEvent {
  const SetRecipient(this.recipient);

  final User recipient;

  @override
  List<Object> get props => [recipient];
}
