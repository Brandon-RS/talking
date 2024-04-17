import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:talking/src/auth/presentation/models/models.dart';
import 'package:talking/src/user/domain/entities/user_entity.dart';

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
      status: FormzSubmissionStatus.initial,
    ));
  }

  void _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    final email = EmailModel.dirty(event.email);
    emit(state.copyWith(
      email: email,
      isValid: Formz.validate([state.password, email]),
      status: FormzSubmissionStatus.initial,
    ));
  }

  void _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
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
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        final result = await _registerUserUsecase((
          state.name,
          state.email.value,
          state.password.value,
        ));

        result.fold(
          (failure) => emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            error: failure.message,
          )),
          (model) => emit(state.copyWith(
            status: FormzSubmissionStatus.success,
            user: model.user,
          )),
        );
      } catch (_) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          error: 'An unexpected error occurred, please try again!',
        ));
      }
    }
  }
}
