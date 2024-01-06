// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:talking/data/models/user_model.dart';

part 'login_response.model.g.dart';

@JsonSerializable(
  checked: true,
  explicitToJson: true,
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class LoginModel {
  const LoginModel({
    this.token,
    this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);

  final String? token;
  final UserModel? user;

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

  @override
  String toString() => 'LoginModel(token: $token, user: $user)';
}
