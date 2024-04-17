part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthStatusChanged extends AuthEvent {
  const AuthStatusChanged(this.status, this.user);

  final AuthStatus status;
  final User? user;

  @override
  List<Object> get props => [status];
}

final class RenewToken extends AuthEvent {
  const RenewToken();
}

final class Logout extends AuthEvent {
  const Logout();
}

final class DeleteAccount extends AuthEvent {
  const DeleteAccount();
}
