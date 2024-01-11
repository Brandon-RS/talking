import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedefs.dart';
import '../repos/auth_repo.dart';

@injectable
class LogoutUsecase implements UsecaseNoParams<bool> {
  const LogoutUsecase(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<bool> call() async {
    try {
      return _repo.logout();
    } catch (e) {
      return const Left(
        AppFailure(
          'Error while trying to logout.',
        ),
      );
    }
  }
}
