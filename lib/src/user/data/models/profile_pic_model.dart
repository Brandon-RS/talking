// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'profile_pic_model.g.dart';

@JsonSerializable(
  checked: true,
  createToJson: false,
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class ProfilePicModel {
  const ProfilePicModel({
    required this.publicId,
    required this.secureUrl,
    required this.originalFilename,
  });

  factory ProfilePicModel.fromJson(Map<String, dynamic> json) => _$ProfilePicModelFromJson(json);

  final String publicId;
  final String secureUrl;
  final String originalFilename;
}
