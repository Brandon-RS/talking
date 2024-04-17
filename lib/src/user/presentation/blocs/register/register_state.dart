part of 'register_bloc.dart';

final class RegisterState extends Equatable {
  const RegisterState({
    this.status = FormzSubmissionStatus.initial,
    this.name = '',
    this.email = const EmailModel.pure(),
    this.password = const PasswordModel.pure(),
    this.isValid = false,
    this.user = User.empty,
    this.error = '',
  });

  final FormzSubmissionStatus status;
  final String name;
  final EmailModel email;
  final PasswordModel password;
  final bool isValid;
  final User user;
  final String error;

  RegisterState copyWith({
    FormzSubmissionStatus? status,
    String? name,
    EmailModel? email,
    PasswordModel? password,
    bool? isValid,
    User? user,
    String? error,
  }) {
    return RegisterState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, name, email, password, isValid, error];
}
