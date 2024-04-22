part of 'change_profile_pic_bloc.dart';

sealed class ChangeProfilePicEvent extends Equatable {
  const ChangeProfilePicEvent();

  @override
  List<Object> get props => [];
}

class SelectProfilePic extends ChangeProfilePicEvent {
  const SelectProfilePic(this.path);

  final String path;

  @override
  List<Object> get props => [path];
}

class UploadProfilePic extends ChangeProfilePicEvent {
  const UploadProfilePic(this.userUid);

  final String userUid;

  @override
  List<Object> get props => [userUid];
}
