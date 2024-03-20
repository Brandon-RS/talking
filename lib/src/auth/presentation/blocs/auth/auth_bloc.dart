import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../user/domain/entities/user_entity.dart';
import 'auth_status.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.unknown()) {
    on<AuthStatusChanged>(_onAuthStatusChanged);
  }

  Future<void> _onAuthStatusChanged(
    AuthStatusChanged event,
    Emitter<AuthState> emit,
  ) async {
    switch (event.status) {
      case AuthStatus.unauthenticated:
        return emit(const AuthState.unauthenticated());
      case AuthStatus.authenticated:
        return emit(AuthState.authenticated(state.user));
      default:
        return emit(const AuthState.unknown());
    }
  }
}
