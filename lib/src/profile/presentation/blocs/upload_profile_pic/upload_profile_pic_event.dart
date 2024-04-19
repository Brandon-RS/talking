part of 'upload_profile_pic_bloc.dart';

sealed class UploadProfilePicEvent extends Equatable {
  const UploadProfilePicEvent();

  @override
  List<Object> get props => [];
}

class SelectProfilePic extends UploadProfilePicEvent {
  const SelectProfilePic(this.path);

  final String path;

  @override
  List<Object> get props => [path];
}

class UploadProfilePic extends UploadProfilePicEvent {
  const UploadProfilePic(this.userUid);

  final String userUid;

  @override
  List<Object> get props => [userUid];
}
