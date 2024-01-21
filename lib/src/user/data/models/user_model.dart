// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(
  checked: true,
  explicitToJson: true,
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class UserModel {
  const UserModel({
    required this.online,
    required this.name,
    required this.email,
    required this.uid,
  });

  final bool online;
  final String name;
  final String email;
  final String uid;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return 'UserModel(online: $online, name: $name, email: $email, uid: $uid)';
  }
}
