// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  const MessageModel({
    required this.from,
    required this.to,
    required this.text,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);

  final String from;
  final String to;
  final String text;

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
