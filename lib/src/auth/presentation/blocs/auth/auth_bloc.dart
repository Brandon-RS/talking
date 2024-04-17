import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:talking/src/auth/domain/usecases/renew_token.usecase.dart';
import 'package:talking/src/user/domain/entities/user_entity.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required RenewTokenUsecase renewTokenUsecase,
  })  : _renewTokenUsecase = renewTokenUsecase,
        super(const AuthState()) {
    on<AuthStatusChanged>(_onAuthStatusChanged);
    on<RenewToken>(_onRenewToken);
  }

  final RenewTokenUsecase _renewTokenUsecase;

  void _onAuthStatusChanged(
    AuthStatusChanged event,
    Emitter<AuthState> emit,
  ) {
    switch (event.status) {
      case AuthStatus.unauthenticated:
        return emit(state.copyWith(status: AuthStatus.unauthenticated));
      case AuthStatus.authenticated:
        // TODO(BRANDOM): Check this (user logic)
        return emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: event.user,
        ));
      default:
        return emit(state.copyWith(status: AuthStatus.unknown));
    }
  }

  void _onRenewToken(
    RenewToken event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.authenticating));

    final result = await _renewTokenUsecase();

    result.fold(
      (failure) => emit(state.copyWith(
        status: AuthStatus.unauthenticated,
        error: failure.message,
      )),
      (model) => emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: model.user,
      )),
    );
  }
}
