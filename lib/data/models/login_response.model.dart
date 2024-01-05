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
class LoginResponseModel {
  const LoginResponseModel({
    this.token,
    this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);

  final String? token;
  final UserModel? user;

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);

  @override
  String toString() => 'LoginResponseModel(token: $token, user: $user)';
}
