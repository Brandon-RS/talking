import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../configs/storage/storage_manager.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedefs.dart';
import '../entities/user_entity.dart';
import '../repos/user_repo.dart';

@injectable
class ChangePasswordUsecase implements Usecase<User, (String, String)> {
  const ChangePasswordUsecase(this._repo, this._storage);

  final UserRepo _repo;
  final StorageManager _storage;

  @override
  ResultFuture<User> call((String, String) user) async {
    try {
      final (currentPassword, password) = user;
      final id = _storage.userId;

      if (id == null || id.isEmpty) {
        return const Left(
          AppFailure(
            'Something went wrong with your session. Please, try to login again.',
          ),
        );
      }

      final result = await _repo.changePassword(id: id, currentPassword: currentPassword, password: password);

      return result.fold(
        (failure) => Left(failure),
        (model) => Right(User.fromModel(model)),
      );
    } catch (e) {
      return const Left(
        AppFailure(
          'Error while trying to change password. Please, try again.',
        ),
      );
    }
  }
}
