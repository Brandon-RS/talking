part of 'upload_profile_pic_bloc.dart';

sealed class UploadProfilePicEvent extends Equatable {
  const UploadProfilePicEvent();

  @override
  List<Object> get props => [];
}

class UploadProfilePic extends UploadProfilePicEvent {
  const UploadProfilePic(this.path, this.userUid);

  final String path;
  final String userUid;

  @override
  List<Object> get props => [path, userUid];
}
