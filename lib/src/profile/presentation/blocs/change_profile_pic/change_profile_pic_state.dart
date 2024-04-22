part of 'change_profile_pic_bloc.dart';

enum ChangeProfilePicStatus { initial, loading, success, error }

final class ChangeProfilePicState extends Equatable {
  const ChangeProfilePicState({
    this.status = ChangeProfilePicStatus.initial,
    this.profilePic = ProfilePicEntity.empty,
    this.image,
    this.error = '',
  });

  final ChangeProfilePicStatus status;
  final ProfilePicEntity profilePic;
  final File? image;
  final String error;

  ChangeProfilePicState copyWith({
    ChangeProfilePicStatus? status,
    ProfilePicEntity? profilePic,
    File? image,
    String? error,
  }) {
    return ChangeProfilePicState(
      status: status ?? this.status,
      profilePic: profilePic ?? this.profilePic,
      image: image ?? this.image,
      error: error ?? this.error,
    );
  }

  // TODO(BRANDOM): Make this better
  ChangeProfilePicState deleteImage() {
    return ChangeProfilePicState(
      status: status,
      profilePic: profilePic,
      image: null,
      error: error,
    );
  }

  bool get isLoading => status == ChangeProfilePicStatus.loading;

  bool get hasImage => profilePic.secureUrl.isNotEmpty;

  @override
  List<Object?> get props => [status, profilePic, image, error];
}
