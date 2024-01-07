import 'package:equatable/equatable.dart';

import '../../../user/domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class LoggedIn extends AuthState {
  const LoggedIn({
    required this.user,
    required this.token,
  });

  final User user;
  final String token;
}

class AuthError extends AuthState {
  const AuthError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
