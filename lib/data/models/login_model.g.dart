// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => $checkedCreate(
      'LoginModel',
      json,
      ($checkedConvert) {
        final val = LoginModel(
          token: $checkedConvert('token', (v) => v as String),
          user: $checkedConvert(
              'user', (v) => UserModel.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user.toJson(),
    };
