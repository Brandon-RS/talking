part of 'users_bloc.dart';

enum UsersStatus { initial, pending, loaded, failure }

final class UsersState extends Equatable {
  const UsersState({
    this.status = UsersStatus.initial,
    this.users = const [],
    this.error = 'Something went wrong, please refresh the page!',
  });

  final UsersStatus status;
  final List<User> users;
  final String error;

  UsersState copyWith({
    UsersStatus? status,
    List<User>? users,
    String? error,
  }) {
    return UsersState(
      status: status ?? this.status,
      users: users ?? this.users,
      error: error ?? this.error,
    );
  }

  bool get isLoading => status == UsersStatus.pending;

  @override
  List<Object> get props => [status, users, error];
}
