part of 'change_password_bloc.dart';

sealed class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

final class NewPasswordChanged extends ChangePasswordEvent {
  const NewPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class CurrentPasswordChanged extends ChangePasswordEvent {
  const CurrentPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class VerifyPasswordChanged extends ChangePasswordEvent {
  const VerifyPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class ChangePasswordSubmitted extends ChangePasswordEvent {
  const ChangePasswordSubmitted();
}
