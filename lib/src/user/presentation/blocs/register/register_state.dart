part of 'register_bloc.dart';

enum RegisterStatus { initial, submitting, success, failure }

final class RegisterState extends Equatable {
  const RegisterState({
    this.status = RegisterStatus.initial,
    this.name = '',
    this.email = '',
    this.password = '',
    this.isValid = false,
    this.error = '',
  });

  final RegisterStatus status;
  final String name;
  final String email;
  final String password;
  final bool isValid;
  final String error;

  RegisterState copyWith({
    RegisterStatus? status,
    String? name,
    String? email,
    String? password,
    bool? isValid,
    String? error,
  }) {
    return RegisterState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, name, email, password, isValid, error];
}

final class RegisterInitial extends RegisterState {}
