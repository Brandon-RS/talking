part of 'upload_profile_pic_bloc.dart';

enum UploadProfilePicStatus { initial, loading, success, error }

final class UploadProfilePicState extends Equatable {
  const UploadProfilePicState({
    this.status = UploadProfilePicStatus.initial,
    this.profilePic = ProfilePicEntity.empty,
    this.error = '',
  });

  final UploadProfilePicStatus status;
  final ProfilePicEntity profilePic;
  final String error;

  UploadProfilePicState copyWith({
    UploadProfilePicStatus? status,
    ProfilePicEntity? profilePic,
    String? error,
  }) {
    return UploadProfilePicState(
      status: status ?? this.status,
      profilePic: profilePic ?? this.profilePic,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, profilePic, error];
}
