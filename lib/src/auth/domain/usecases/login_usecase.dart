import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedefs.dart';
import '../entities/login_entity.dart';
import '../repos/auth_repo.dart';

@injectable
class LoginUseCase implements Usecase<Login, (String, String)> {
  LoginUseCase(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<Login> call((String, String) data) async {
    try {
      final (email, password) = data;

      final result = await _repo.login(email: email, password: password);

      return result.fold(
        (failure) => Left(failure),
        (model) => Right(Login.formModel(model)),
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
