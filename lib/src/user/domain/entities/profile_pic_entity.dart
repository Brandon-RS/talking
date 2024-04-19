import 'package:equatable/equatable.dart';
import 'package:talking/src/user/data/models/profile_pic_model.dart';

class ProfilePicEntity extends Equatable {
  const ProfilePicEntity({
    required this.publicId,
    required this.secureUrl,
    required this.originalFilename,
  });

  final String publicId;
  final String secureUrl;
  final String originalFilename;

  static const empty = ProfilePicEntity(
    publicId: '',
    secureUrl: '',
    originalFilename: '',
  );

  factory ProfilePicEntity.fromModel(ProfilePicModel model) {
    return ProfilePicEntity(
      publicId: model.publicId,
      secureUrl: model.secureUrl,
      originalFilename: model.originalFilename,
    );
  }

  @override
  List<Object?> get props => [publicId, secureUrl, originalFilename];
}
