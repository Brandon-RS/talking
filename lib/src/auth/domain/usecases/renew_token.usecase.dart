import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedefs.dart';
import '../entities/login_entity.dart';
import '../repos/auth_repo.dart';

@injectable
class RenewTokenUsecase implements UsecaseNoParams<Login> {
  RenewTokenUsecase(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<Login> call() async {
    try {
      final result = await _repo.renewToken();

      return result.fold(
        (failure) => Left(failure),
        (model) => Right(Login.fromModel(model)),
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
