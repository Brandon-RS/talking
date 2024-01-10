import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../configs/di/injector.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_state.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  @override
  AuthState build() {
    _login = sl<LoginUseCase>();
    return const AuthInitial();
  }

  late LoginUseCase _login;

  Future<void> login({required String email, required String password}) async {
    state = const AuthLoading();

    final result = await _login((email, password));

    result.fold(
      (failure) {
        final errorCode = failure.statusCode;
        if (errorCode != null && errorCode >= 400 && errorCode < 500) {
          state = const AuthError('Email or password is not correct');
          return;
        }

        state = AuthError(failure.message);
      },
      (model) => state = LoggedIn(
        user: model.user,
        token: model.token,
      ),
    );
  }
}
