import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../configs/di/injector.dart';
import '../../domain/usecases/get_all_users_usecase.dart';
import 'users_state.dart';

part 'users_provider.g.dart';

@Riverpod(keepAlive: true)
class Users extends _$Users {
  @override
  UsersState build() {
    _getAllUsers = sl<GetAllUsersUsecase>();

    return const UsersInitial();
  }

  late GetAllUsersUsecase _getAllUsers;

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
