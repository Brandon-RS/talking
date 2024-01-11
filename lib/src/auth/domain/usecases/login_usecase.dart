import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedefs.dart';
import '../entities/login_entity.dart';
import '../repos/auth_repo.dart';

@injectable
class LoginUsecase implements Usecase<Login, (String, String)> {
  LoginUsecase(this._repo);

  final AuthRepo _repo;

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
        (failure) => Left(failure),
        (model) => Right(Login.fromModel(model)),
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
