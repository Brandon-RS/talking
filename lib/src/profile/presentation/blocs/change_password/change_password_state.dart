part of 'change_password_bloc.dart';

final class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.status = FormzSubmissionStatus.initial,
    this.currentPassword = const PasswordModel.pure(),
    this.newPassword = const PasswordModel.pure(),
    this.verifyPassword = const PasswordModel.pure(),
    this.isValid = false,
    this.error = '',
  });

  final FormzSubmissionStatus status;
  final PasswordModel currentPassword;
  final PasswordModel newPassword;
  final PasswordModel verifyPassword;
  final bool isValid;
  final String error;

  ChangePasswordState copyWith({
    FormzSubmissionStatus? status,
    PasswordModel? currentPassword,
    PasswordModel? newPassword,
    PasswordModel? verifyPassword,
    bool? isValid,
    String? error,
  }) {
    return ChangePasswordState(
      status: status ?? this.status,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      verifyPassword: verifyPassword ?? this.verifyPassword,
      isValid: isValid ?? this.isValid,
      error: error ?? this.error,
    );
  }

  bool get isLoading => status == FormzSubmissionStatus.inProgress;

  @override
  List<Object> get props => [status, currentPassword, newPassword, verifyPassword, isValid, error];
}
