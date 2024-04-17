part of 'users_bloc.dart';

sealed class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

final class UsersInitial extends UsersEvent {
  const UsersInitial();
}

final class GetUsers extends UsersEvent {
  const GetUsers();
}

final class GetUsersIfNeed extends UsersEvent {
  const GetUsersIfNeed();
}
