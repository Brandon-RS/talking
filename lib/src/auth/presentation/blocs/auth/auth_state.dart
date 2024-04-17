part of 'auth_bloc.dart';

enum AuthStatus { unknown, authenticating, authenticated, unauthenticated, error }

class AuthState extends Equatable {
  const AuthState._({
    this.status = AuthStatus.unknown,
    this.error = '',
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticating() : this._(status: AuthStatus.authenticating);

  const AuthState.authenticated() : this._(status: AuthStatus.authenticated);

  const AuthState.unauthenticated() : this._(status: AuthStatus.unauthenticated);

  const AuthState.error(String error) : this._(status: AuthStatus.error, error: error);

  final AuthStatus status;
  final String error;

  @override
  List<Object> get props => [status];
}
