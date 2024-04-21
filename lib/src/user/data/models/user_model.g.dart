// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => $checkedCreate(
      'UserModel',
      json,
      ($checkedConvert) {
        final val = UserModel(
          online: $checkedConvert('online', (v) => v as bool),
          name: $checkedConvert('name', (v) => v as String),
          email: $checkedConvert('email', (v) => v as String),
          uid: $checkedConvert('uid', (v) => v as String),
          profileImage: $checkedConvert('profileImage', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) {
  final val = <String, dynamic>{
    'online': instance.online,
    'name': instance.name,
    'email': instance.email,
    'uid': instance.uid,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('profileImage', instance.profileImage);
  return val;
}
