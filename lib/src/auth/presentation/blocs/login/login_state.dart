part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.username = '',
    this.password = '',
    this.isValid = false,
    this.user = User.empty,
  });

  final LoginStatus status;
  final String username;
  final String password;
  final bool isValid;
  final User user;

  LoginState copyWith({
    LoginStatus? status,
    String? username,
    String? password,
    bool? isValid,
    User? user,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [status, username, password];
}
