import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../domain/usecases/login_usecase.dart';
import '../../models/models.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required LoginUsecase loginUsecase,
  })  : _loginUsecase = loginUsecase,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final LoginUsecase _loginUsecase;

  void _onEmailChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final email = EmailModel.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([state.password, email]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = PasswordModel.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.email]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      try {
        final result = await _loginUsecase((
          state.email.value,
          state.password.value,
        ));

        result.fold(
          (failure) => emit(
            state.copyWith(
              status: FormzSubmissionStatus.failure,
              error: failure.message,
            ),
          ),
          (_) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
        );
      } catch (_) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          error: 'An unexpected error occurred, please try again.',
        ));
      }
    }
  }
}
