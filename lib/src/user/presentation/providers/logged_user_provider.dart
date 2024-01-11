import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../configs/di/injector.dart';
import '../../../../configs/storage/storage_manager.dart';
import '../../domain/usecases/register_user_usecase.dart';
import 'logged_user_state.dart';

part 'logged_user_provider.g.dart';

@riverpod
class LoggedUser extends _$LoggedUser {
  @override
  LoggedUserState build() {
    _storageManager = sl<StorageManager>();
    _registerUserUsecase = sl<RegisterUserUsecase>();

    return const LoggedUserInitial();
  }

  late StorageManager _storageManager;
  late RegisterUserUsecase _registerUserUsecase;

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _registerUserUsecase((
      name,
      email,
      password,
    ));

    response.fold(
      (failure) => state = LoggedUserError(failure.message),
      (model) async {
        // TODO(BRANDOM): Create a static method like setUserToken in StorageManager
        await _storageManager.setString(StorageManager.xToken, model.token);

        state = LoggedUserLoaded(
          user: model.user,
          token: model.token,
        );
      },
    );
  }
}
