import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/register_user_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required RegisterUserUsecase registerUserUsecase,
  })  : _registerUserUsecase = registerUserUsecase,
        super(const RegisterState()) {
    on<RegisterNameChanged>(_onNameChanged);
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterSubmitted>(_onSubmitted);
  }

  final RegisterUserUsecase _registerUserUsecase;

  void _onNameChanged(
    RegisterNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final name = event.name;
    emit(state.copyWith(
      name: name,
      isValid: name.trim().isNotEmpty,
      status: RegisterStatus.initial,
    ));
  }

  void _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    final email = event.email;
    emit(state.copyWith(
      email: email,
      isValid: email.trim().isNotEmpty,
      status: RegisterStatus.initial,
    ));
  }

  void _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final password = event.password;
    emit(
      state.copyWith(
        password: password,
        isValid: password.trim().isNotEmpty,
        status: RegisterStatus.initial,
      ),
    );
  }

  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: RegisterStatus.submitting));
      try {
        final result = await _registerUserUsecase((
          state.name,
          state.email,
          state.password,
        ));

        result.fold(
          (failure) => emit(state.copyWith(
            status: RegisterStatus.failure,
            error: failure.message,
          )),
          (_) => emit(state.copyWith(status: RegisterStatus.success)),
        );
      } catch (_) {
        emit(state.copyWith(
          status: RegisterStatus.failure,
          error: 'An unexpected error occurred, please try again!',
        ));
      }
    }
  }
}
