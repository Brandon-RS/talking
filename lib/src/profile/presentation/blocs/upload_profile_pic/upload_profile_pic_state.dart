part of 'upload_profile_pic_bloc.dart';

enum UploadProfilePicStatus { initial, loading, success, error }

final class UploadProfilePicState extends Equatable {
  const UploadProfilePicState({
    this.status = UploadProfilePicStatus.initial,
    this.profilePic = ProfilePicEntity.empty,
    this.image,
    this.error = '',
  });

  final UploadProfilePicStatus status;
  final ProfilePicEntity profilePic;
  final File? image;
  final String error;

  UploadProfilePicState copyWith({
    UploadProfilePicStatus? status,
    ProfilePicEntity? profilePic,
    File? image,
    String? error,
  }) {
    return UploadProfilePicState(
      status: status ?? this.status,
      profilePic: profilePic ?? this.profilePic,
      image: image ?? this.image,
      error: error ?? this.error,
    );
  }

  // TODO(BRANDOM): Make this better
  UploadProfilePicState deleteImage() {
    return UploadProfilePicState(
      status: status,
      profilePic: profilePic,
      image: null,
      error: error,
    );
  }

  bool get isLoading => status == UploadProfilePicStatus.loading;

  bool get hasImage => profilePic.secureUrl.isNotEmpty;

  @override
  List<Object?> get props => [status, profilePic, image, error];
}
