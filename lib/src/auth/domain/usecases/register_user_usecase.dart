import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:talking/core/errors/failure.dart';
import 'package:talking/core/usecases/usecase.dart';
import 'package:talking/core/utils/typedefs.dart';
import 'package:talking/src/user/domain/entities/user_entity.dart';

import '../repos/user_repo.dart';

@injectable
class RegisterUserUsecase implements Usecase<User, (String, String, String)> {
  const RegisterUserUsecase(this._repo);

  final UserRepo _repo;

  @override
  ResultFuture<User> call((String, String, String) user) async {
    try {
      final (name, email, password) = user;

      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        return const Left(
          AppFailure(
            'Please, fill all the fields.',
          ),
        );
      }

      final result = await _repo.register(name: name, email: email, password: password);

      return result.fold(
        (failure) => Left(failure),
        (model) => Right(User.fromModel(model)),
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
