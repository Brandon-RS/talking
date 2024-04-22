import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talking/src/user/domain/entities/profile_pic_entity.dart';
import 'package:talking/src/user/domain/usecases/upload_profile_pic_usecase.dart';

part 'change_profile_pic_event.dart';
part 'change_profile_pic_state.dart';

class ChangeProfilePicBloc extends Bloc<ChangeProfilePicEvent, ChangeProfilePicState> {
  ChangeProfilePicBloc({
    required UploadProfilePicUsecase uploadProfilePicUsecase,
  })  : _uploadProfilePicUsecase = uploadProfilePicUsecase,
        super(const ChangeProfilePicState()) {
    on<SelectProfilePic>(_onSelectProfilePic);
    on<UploadProfilePic>(_onUploadProfilePic);
  }

  final UploadProfilePicUsecase _uploadProfilePicUsecase;

  void _onSelectProfilePic(
    SelectProfilePic event,
    Emitter<ChangeProfilePicState> emit,
  ) {
    emit(state.copyWith(image: File(event.path)));
  }

  void _onUploadProfilePic(
    UploadProfilePic event,
    Emitter<ChangeProfilePicState> emit,
  ) async {
    if (state.image == null) return;

    emit(state.copyWith(status: ChangeProfilePicStatus.loading));

    final result = await _uploadProfilePicUsecase((state.image!.path, event.userUid));

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: ChangeProfilePicStatus.error,
          error: failure.message,
        ));
      },
      (profilePic) {
        emit(state.copyWith(
          status: ChangeProfilePicStatus.success,
          profilePic: profilePic,
        ));
      },
    );

    emit(state.deleteImage());
  }
}
