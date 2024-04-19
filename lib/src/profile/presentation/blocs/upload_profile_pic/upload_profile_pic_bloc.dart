import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:talking/src/user/domain/entities/profile_pic_entity.dart';
import 'package:talking/src/user/domain/usecases/upload_profile_pic_usecase.dart';

part 'upload_profile_pic_event.dart';
part 'upload_profile_pic_state.dart';

class UploadProfilePicBloc extends Bloc<UploadProfilePicEvent, UploadProfilePicState> {
  UploadProfilePicBloc({
    required UploadProfilePicUsecase uploadProfilePicUsecase,
  })  : _uploadProfilePicUsecase = uploadProfilePicUsecase,
        super(const UploadProfilePicState()) {
    on<UploadProfilePic>(_onUploadProfilePic);
  }

  final UploadProfilePicUsecase _uploadProfilePicUsecase;

  void _onUploadProfilePic(UploadProfilePic event, Emitter<UploadProfilePicState> emit) async {
    emit(state.copyWith(status: UploadProfilePicStatus.loading));

    final result = await _uploadProfilePicUsecase((event.path, event.userUid));

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: UploadProfilePicStatus.error,
          error: failure.message,
        ));
      },
      (profilePic) {
        emit(state.copyWith(
          status: UploadProfilePicStatus.success,
          profilePic: profilePic,
        ));
      },
    );
  }
}
