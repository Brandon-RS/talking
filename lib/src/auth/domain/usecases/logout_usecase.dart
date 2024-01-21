import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../configs/storage/storage_manager.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedefs.dart';
import '../repos/auth_repo.dart';

@injectable
class LogoutUsecase implements UsecaseNoParams<bool> {
  const LogoutUsecase(this._repo, this._storageManager);

  final AuthRepo _repo;
  final StorageManager _storageManager;

  @override
  ResultFuture<bool> call() async {
    try {
      final response = await _repo.logout();
      await _storageManager.clear();

      return response.fold(
        (failure) => Left(failure),
        (value) => Right(value),
      );
    } catch (e) {
      return const Left(
        AppFailure(
          'Error while trying to logout.',
        ),
      );
    }
  }
}
