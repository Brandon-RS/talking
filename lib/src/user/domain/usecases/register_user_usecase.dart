import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedefs.dart';
import '../../../auth/domain/entities/login_entity.dart';
import '../repos/user_repo.dart';

@injectable
class RegisterUserUsecase implements Usecase<Login, (String, String, String)> {
  const RegisterUserUsecase(this._repo);

  final UserRepo _repo;

  @override
  ResultFuture<Login> call((String, String, String) user) async {
    try {
      final (name, email, password) = user;

      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        return const Left(
          AppFailure(
            'Please, complete all required data.',
          ),
        );
      }

      final result = await _repo.register(name: name, email: email, password: password);

      return result.fold(
        (failure) => Left(failure),
        (model) => Right(Login.fromModel(model)),
      );
    } catch (e) {
      return const Left(
        AppFailure(
          'Error while trying to register. Please, try again.',
        ),
      );
    }
  }
}
