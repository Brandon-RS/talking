import 'package:equatable/equatable.dart';

import '../../data/models/message_model.dart';

class Message extends Equatable {
  const Message({
    required this.from,
    required this.to,
    required this.text,
  });

  final String from;
  final String to;
  final String text;

  factory Message.fromModel(MessageModel model) {
    return Message(
      from: model.from,
      to: model.to,
      text: model.text,
    );
  }

  static fromModelList(List<MessageModel> models) {
    return models.map((e) => Message.fromModel(e)).toList();
  }

  MessageModel toModel() {
    return MessageModel(
      from: from,
      to: to,
      text: text,
    );
  }

  @override
  List<Object?> get props => [from, to, text];

  @override
  String toString() {
    return 'Chat(from: $from, to: $to, text: $text)';
  }
}
