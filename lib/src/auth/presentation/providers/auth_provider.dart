import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../configs/di/injector.dart';
import '../../../../configs/storage/storage_manager.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/renew_token.usecase.dart';
import 'auth_state.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  @override
  AuthState build() {
    _login = sl<LoginUsecase>();
    _renewToken = sl<RenewTokenUsecase>();
    _logout = sl<LogoutUsecase>();
    return const AuthInitial();
  }

  late LoginUsecase _login;
  late RenewTokenUsecase _renewToken;
  late LogoutUsecase _logout;

  Future<void> login({required String email, required String password}) async {
    state = const AuthLoading();

    final result = await _login((email, password));

    result.fold(
      (failure) => state = AuthError(failure.message),
      (model) => state = LoggedIn(
        user: model.user,
        token: model.token,
      ),
    );
  }

  Future<void> renewToken() async {
    if (sl<StorageManager>().currentToken != null) {
      state = const AuthLoading();

      final result = await _renewToken();

      result.fold(
        (failure) => state = AuthError(failure.message),
        (model) => state = LoggedIn(
          user: model.user,
          token: model.token,
        ),
      );
    } else {
      state = const LoggedOut();
    }
  }

  Future<void> logout() async {
    state = const AuthLoading();

    final result = await _logout();

    result.fold(
      (failure) => state = AuthError(failure.message),
      (model) => state = const LoggedOut(),
    );
  }
}
