import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../configs/storage/storage_manager.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedefs.dart';
import '../entities/login_entity.dart';
import '../repos/auth_repo.dart';

@injectable
class LoginUsecase implements Usecase<Login, (String, String)> {
  const LoginUsecase(this._repo, this._storageManager);

  final AuthRepo _repo;
  final StorageManager _storageManager;

  @override
  ResultFuture<Login> call((String, String) data) async {
    try {
      final (email, password) = data;

      if (email.isEmpty || password.isEmpty) {
        return const Left(
          AppFailure(
            'Email and password must not be empty.',
          ),
        );
      }

      final result = await _repo.login(email: email, password: password);

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
          'Error while trying to login. Please, try again later.',
        ),
      );
    }
  }
}
