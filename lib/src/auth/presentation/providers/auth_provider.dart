import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../configs/di/injector.dart';
import '../../../../configs/storage/storage_manager.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'auth_state.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  @override
  AuthState build() {
    _login = sl<LoginUsecase>();
    _logout = sl<LogoutUsecase>();
    _storageManager = sl<StorageManager>();
    return const AuthInitial();
  }

  late LoginUsecase _login;
  late LogoutUsecase _logout;
  late StorageManager _storageManager;

  Future<void> login({required String email, required String password}) async {
    state = const AuthLoading();

    final result = await _login((email, password));

    result.fold(
      (failure) {
        state = AuthError(failure.message);
        _storageManager.clear();
      },
      (model) async {
        state = LoggedIn(
          user: model.user,
          token: model.token,
        );

        await _storageManager.setString(StorageManager.xToken, model.token);
      },
    );
  }

  Future<void> logout() async {
    state = const AuthLoading();

    final result = await _logout();

    result.fold(
      (failure) => state = AuthError(failure.message),
      (model) => state = const LoggedOut(),
    );

    _storageManager.clear();
  }
}