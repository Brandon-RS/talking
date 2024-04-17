import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:talking/src/auth/domain/usecases/renew_token.usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required RenewTokenUsecase renewTokenUsecase,
  })  : _renewTokenUsecase = renewTokenUsecase,
        super(const AuthState.unknown()) {
    on<AuthStatusChanged>(_onAuthStatusChanged);
    on<RenewToken>(_onRenewToken);
  }

  final RenewTokenUsecase _renewTokenUsecase;

  Future<void> _onAuthStatusChanged(
    AuthStatusChanged event,
    Emitter<AuthState> emit,
  ) async {
    switch (event.status) {
      case AuthStatus.unauthenticated:
        return emit(const AuthState.unauthenticated());
      case AuthStatus.authenticated:
        return emit(const AuthState.authenticated());
      default:
        return emit(const AuthState.unknown());
    }
  }

  void _onRenewToken(
    RenewToken event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.authenticating());

    final result = await _renewTokenUsecase();

    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (model) => emit(const AuthState.authenticated()),
    );
  }
}
