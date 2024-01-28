import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../configs/di/injector.dart';
import '../../domain/usecases/change_password_usecase.dart';
import 'users_state.dart';

part 'change_password_provider.g.dart';

@riverpod
class ChangePassword extends _$ChangePassword {
  @override
  UsersState build() {
    _changePassword = sl<ChangePasswordUsecase>();

    return const UsersInitial();
  }

  late ChangePasswordUsecase _changePassword;

  Future<void> changePassword({
    required String currentPassword,
    required String password,
  }) async {
    state = const UsersLoading();

    final response = await _changePassword((
      currentPassword,
      password,
    ));

    response.fold(
      (failure) => state = UsersError(failure.message),
      (user) => state = const UsersLoaded(users: []),
    );
  }
}
