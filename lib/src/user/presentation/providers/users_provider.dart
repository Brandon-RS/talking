import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../configs/di/injector.dart';
import '../../domain/usecases/change_password_usecase.dart';
import '../../domain/usecases/get_all_users_usecase.dart';
import 'users_state.dart';

part 'users_provider.g.dart';

@Riverpod(keepAlive: true)
class Users extends _$Users {
  @override
  UsersState build() {
    _getAllUsers = sl<GetAllUsersUsecase>();
    _changePassword = sl<ChangePasswordUsecase>();

    return const UsersInitial();
  }

  late GetAllUsersUsecase _getAllUsers;
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
      (user) => state = UsersLoaded(users: [user]),
    );
  }

  Future<void> getALlUsers() async {
    state = const UsersLoading();

    final response = await _getAllUsers();

    response.fold(
      (failure) => state = UsersError(failure.message),
      (users) => state = UsersLoaded(users: users),
    );
  }

  FutureOr<void> getUsersIfNeed() async {
    if (state is! UsersLoaded) {
      await getALlUsers();
    }
  }

  void reset() {
    state = const UsersInitial();
  }
}
