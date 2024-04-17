import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:talking/src/auth/presentation/models/models.dart';
import 'package:talking/src/user/domain/usecases/change_password_usecase.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc({
    required ChangePasswordUsecase changePasswordUsecase,
  })  : _changePasswordUsecase = changePasswordUsecase,
        super(const ChangePasswordState()) {
    on<CurrentPasswordChanged>(_onCurrentPasswordChanged);
    on<NewPasswordChanged>(_onNewPasswordChanged);
    on<VerifyPasswordChanged>(_onVerifyPasswordChanged);
    on<ChangePasswordSubmitted>(_onChangePasswordSubmitted);
  }

  final ChangePasswordUsecase _changePasswordUsecase;

  void _onCurrentPasswordChanged(
    CurrentPasswordChanged event,
    Emitter<ChangePasswordState> emit,
  ) {
    final currentPassword = PasswordModel.dirty(event.password);
    emit(
      state.copyWith(
        currentPassword: currentPassword,
        isValid: Formz.validate([currentPassword]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onNewPasswordChanged(
    NewPasswordChanged event,
    Emitter<ChangePasswordState> emit,
  ) {
    final newPassword = PasswordModel.dirty(event.password);
    emit(
      state.copyWith(
        newPassword: newPassword,
        isValid: Formz.validate([newPassword]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onVerifyPasswordChanged(
    VerifyPasswordChanged event,
    Emitter<ChangePasswordState> emit,
  ) {
    final verifyPassword = PasswordModel.dirty(event.password);
    emit(
      state.copyWith(
        verifyPassword: verifyPassword,
        isValid: Formz.validate([verifyPassword]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onChangePasswordSubmitted(
    ChangePasswordSubmitted event,
    Emitter<ChangePasswordState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      final result = await _changePasswordUsecase((
        state.currentPassword.value,
        state.newPassword.value,
      ));

      result.fold(
        (failure) => emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          error: failure.message,
        )),
        (_) => emit(state.copyWith(
          status: FormzSubmissionStatus.success,
        )),
      );
    }
  }
}
