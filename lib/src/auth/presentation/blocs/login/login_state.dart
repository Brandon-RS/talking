part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.username = '',
    this.password = '',
    this.isValid = false,
  });

  final LoginStatus status;
  final String username;
  final String password;
  final bool isValid;

  LoginState copyWith({
    LoginStatus? status,
    String? username,
    String? password,
    bool? isValid,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [status, username, password];
}
