// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_pic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfilePicModel _$ProfilePicModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ProfilePicModel',
      json,
      ($checkedConvert) {
        final val = ProfilePicModel(
          publicId: $checkedConvert('public_id', (v) => v as String),
          secureUrl: $checkedConvert('secure_url', (v) => v as String),
          originalFilename:
              $checkedConvert('original_filename', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'publicId': 'public_id',
        'secureUrl': 'secure_url',
        'originalFilename': 'original_filename'
      },
    );
