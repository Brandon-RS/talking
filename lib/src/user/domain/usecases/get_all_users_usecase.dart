import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedefs.dart';
import '../entities/user_entity.dart';
import '../repos/user_repo.dart';

@injectable
class GetAllUsersUsecase implements UsecaseNoParams<List<User>> {
  const GetAllUsersUsecase(this._repo);

  final UserRepo _repo;

  @override
  ResultFuture<List<User>> call() async {
    try {
      final result = await _repo.getUsers();

      return result.fold(
        (failure) => Left(failure),
        (users) => Right(User.fromModelList(users)),
      );
    } catch (e) {
      return const Left(
        AppFailure(
          'Error while trying to get users. Please, try again later.',
        ),
      );
    }
  }
}
