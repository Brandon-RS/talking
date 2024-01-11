import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';

abstract class LoggedUserState extends Equatable {
  const LoggedUserState();

  @override
  List<Object?> get props => [];
}

class LoggedUserInitial extends LoggedUserState {
  const LoggedUserInitial();
}

class LoggedUserLoading extends LoggedUserState {
  const LoggedUserLoading();
}

class LoggedUserLoaded extends LoggedUserState {
  const LoggedUserLoaded({
    required this.user,
    required this.token,
  });

  final User user;
  final String token;

  @override
  List<Object?> get props => [user, token];
}

class LoggedUserError extends LoggedUserState {
  const LoggedUserError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
