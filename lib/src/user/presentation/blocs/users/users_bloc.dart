import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:talking/src/user/domain/entities/user_entity.dart';
import 'package:talking/src/user/domain/usecases/get_all_users_usecase.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc({
    required GetAllUsersUsecase getAllUsersUsecase,
  })  : _getAllUsersUsecase = getAllUsersUsecase,
        super(const UsersState()) {
    on<GetUsers>(_onGetUsers);
    on<GetUsersIfNeed>(_onGetUsersIfNeed);

    /// Fetch users when users view is opened
    add(const GetUsersIfNeed());
  }

  final GetAllUsersUsecase _getAllUsersUsecase;

  void _onGetUsers(
    GetUsers event,
    Emitter<UsersState> emit,
  ) async {
    emit(state.copyWith(status: UsersStatus.pending, users: []));

    try {
      final response = await _getAllUsersUsecase();

      response.fold(
        (failure) => emit(state.copyWith(
          status: UsersStatus.failure,
          error: failure.message,
        )),
        (users) => emit(state.copyWith(
          status: UsersStatus.loaded,
          users: users,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
        status: UsersStatus.failure,
        error: e.toString(),
      ));
    }
  }

  void _onGetUsersIfNeed(
    GetUsersIfNeed event,
    Emitter<UsersState> emit,
  ) async {
    if (state.status != UsersStatus.loaded && state.users.isEmpty) {
      add(const GetUsers());
    }
  }
}
