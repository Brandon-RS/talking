import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import '../../../../core/errors/dio_error_handler.dart';
import '../../../../core/utils/typedefs.dart';
import '../../domain/repos/auth_repo.dart';
import '../datasources/auth_remote_data_src.dart';
import '../models/login_model.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl(this._src);

  final AuthRemoteDataSrc _src;
  // TODO(BRANDOM): Implement the logger as a shared instance
  final Logger _logger = Logger('AuthRepoImpl');

  @override
  ResultFuture<LoginModel> login({required String email, required String password}) async {
    try {
      final result = await _src.login(email: email, password: password);
      return Right(result);
    } catch (e, s) {
      _logger.severe('Error on login', e, s);

      return Left(
        ErrorHandler.handle(e, defaultMessage: 'Error on login'),
      );
    }
  }
}
