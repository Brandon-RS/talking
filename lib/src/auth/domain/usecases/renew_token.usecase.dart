import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../configs/storage/storage_manager.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedefs.dart';
import '../entities/login_entity.dart';
import '../repos/auth_repo.dart';

@injectable
class RenewTokenUsecase implements UsecaseNoParams<Login> {
  const RenewTokenUsecase(this._repo, this._storageManager);

  final AuthRepo _repo;
  final StorageManager _storageManager;

  @override
  ResultFuture<Login> call() async {
    try {
      final result = await _repo.renewToken();

      return result.fold(
        (failure) async {
          await _storageManager.clear();
          return Left(failure);
        },
        (model) async {
          await _storageManager.setToken(model.token);
          return Right(Login.fromModel(model));
        },
      );
    } catch (e) {
      return const Left(
        AppFailure(
          'Error while trying to start session. Please try again.',
        ),
      );
    }
  }
}
