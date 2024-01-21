import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object?> get props => [];
}

class UsersInitial extends UsersState {
  const UsersInitial();
}

class UsersLoading extends UsersState {
  const UsersLoading();
}

class UsersLoaded extends UsersState {
  const UsersLoaded({
    required this.users,
  });

  final List<User> users;

  @override
  List<Object?> get props => [users];
}

class UsersError extends UsersState {
  const UsersError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
