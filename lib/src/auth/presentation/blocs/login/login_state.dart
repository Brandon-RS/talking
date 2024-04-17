part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const EmailModel.pure(),
    this.password = const PasswordModel.pure(),
    this.isValid = false,
    this.user = User.empty,
    this.error = '',
  });

  final FormzSubmissionStatus status;
  final EmailModel email;
  final PasswordModel password;
  final bool isValid;
  final User user;
  final String error;

  LoginState copyWith({
    FormzSubmissionStatus? status,
    EmailModel? email,
    PasswordModel? password,
    bool? isValid,
    User? user,
    String? error,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, email, password];
}
