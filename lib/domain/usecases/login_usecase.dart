import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../../core/usecases/usecase.dart';
import '../../core/utils/typedefs.dart';
import '../../data/models/login_response.model.dart';
import '../repos/auth_repo.dart';

class LoginUseCase implements Usecase<LoginModel, (String, String)> {
  const LoginUseCase({required AuthRepo repo}) : _repo = repo;

  final AuthRepo _repo;

  @override
  ResultFuture<LoginModel> call((String, String) data) async {
    try {
      final (email, password) = data;

      return await _repo.login(email: email, password: password);
    } catch (e) {
      return const Left(
        ServerFailure(
          'Error while trying to login. Please, try again later.',
        ),
      );
    }
  }
}
