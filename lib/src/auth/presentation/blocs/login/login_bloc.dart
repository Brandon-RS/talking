import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required LoginUsecase loginUsecase,
  })  : _loginUsecase = loginUsecase,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final LoginUsecase _loginUsecase;

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = event.username;
    emit(
      state.copyWith(
        username: username,
        isValid: username.trim().isNotEmpty,
        status: LoginStatus.initial,
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = event.password;
    emit(
      state.copyWith(
        password: password,
        isValid: password.trim().isNotEmpty,
        status: LoginStatus.initial,
      ),
    );
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: LoginStatus.loading));
      try {
        final result = await _loginUsecase((state.username, state.password));
        result.fold(
          (_) => emit(state.copyWith(status: LoginStatus.error)),
          (_) => emit(state.copyWith(status: LoginStatus.success)),
        );
      } catch (_) {
        emit(state.copyWith(status: LoginStatus.error));
      }
    }
  }
}
