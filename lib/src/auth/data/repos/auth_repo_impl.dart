import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedefs.dart';
import '../../domain/repos/auth_repo.dart';
import '../datasources/auth_remote_data_src.dart';
import '../models/login_model.dart';

class AuthRepoImpl implements AuthRepo {
  /// By default, the [src] is an instance of [AuthRemoteDataSrcImpl]
  AuthRepoImpl({AuthRemoteDataSrc? src}) : _src = src ?? AuthRemoteDataSrcImpl();

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

      if (e is DioException && e.response?.statusCode == 401) {
        return const Left(
          ApiFailure('Invalid credentials', statusCode: 401),
        );
      }

      // TODO(BRANDOM): Make this better, handle server errors in a shared instance
      return const Left(
        ServerFailure('Error on login', statusCode: 500),
      );
    }
  }
}
