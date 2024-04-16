import 'package:formz/formz.dart';

enum PasswordValidationError { invalid, empty }

class PasswordModel extends FormzInput<String, PasswordValidationError> {
  const PasswordModel.pure() : super.pure('');
  const PasswordModel.dirty([super.value = '']) : super.dirty();

  static final _passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    } else if (!_passwordRegex.hasMatch(value)) {
      return PasswordValidationError.invalid;
    }

    return null;
  }
}

extension PasswordValidationErrorX on PasswordValidationError {
  String get text {
    switch (this) {
      case PasswordValidationError.invalid:
        return 'Password must be at least 6 characters and contain at least one letter and number';
      case PasswordValidationError.empty:
        return 'Please enter a password';
    }
  }
}
