import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../configs/di/injector.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/register_user_usecase.dart';
import 'logged_user_state.dart';

part 'logged_user_provider.g.dart';

@Riverpod(keepAlive: true)
class LoggedUser extends _$LoggedUser {
  @override
  LoggedUserState build() {
    _registerUserUsecase = sl<RegisterUserUsecase>();

    return const LoggedUserInitial();
  }

  late RegisterUserUsecase _registerUserUsecase;

  void init({required String token, required User user}) {
    state = LoggedUserLoaded(
      user: user,
      token: token,
    );
  }

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const LoggedUserLoading();

    final response = await _registerUserUsecase(
      (name, email, password),
    );

    response.fold(
      (failure) => state = LoggedUserError(failure.message),
      (model) => state = LoggedUserLoaded(
        user: model.user,
        token: model.token,
      ),
    );
  }

  void reset() {
    state = const LoggedUserInitial();
  }
}
