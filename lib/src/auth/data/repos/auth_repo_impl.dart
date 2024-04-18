import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/dio_error_handler.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedefs.dart';
import '../../domain/repos/auth_repo.dart';
import '../datasources/auth_remote_data_src.dart';
import '../models/login_model.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl(this._src);

  final AuthRemoteDataSrc _src;

  @override
  ResultFuture<LoginModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _src.login(email: email, password: password);
      return Right(result);
    } catch (e) {
      final failure = ErrorHandler.handle(e, defaultMessage: 'Error on login');

      if (failure.statusCode != null && failure.statusCode == 400) {
        return const Left(
          ApiFailure('Email or password is not correct'),
        );
      }
      return Left(failure);
    }
  }

  @override
  ResultFuture<LoginModel> renewToken() async {
    try {
      final result = await _src.renewToken();
      return Right(result);
    } catch (e) {
      final failure = ErrorHandler.handle(e, defaultMessage: 'Error renewing token');

      return Left(failure);
    }
  }

  @override
  ResultFuture<bool> logout() async {
    try {
      final result = await _src.logout();
      return Right(result);
    } catch (e) {
      return Left(
        ErrorHandler.handle(e, defaultMessage: 'Error on logout'),
      );
    }
  }
}
