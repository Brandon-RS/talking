import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/dio_error_handler.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedefs.dart';
import '../../../auth/data/models/login_model.dart';
import '../../domain/repos/user_repo.dart';
import '../datasources/user_remote_data_src.dart';
import '../models/user_model.dart';

@Injectable(as: UserRepo)
class UserRepoImpl implements UserRepo {
  UserRepoImpl(this._src);

  final UserRemoteDataSrc _src;

  @override
  ResultFuture<LoginModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final result = await _src.register(
        name: name,
        email: email,
        password: password,
      );

      return Right(result);
    } catch (e) {
      final failure = ErrorHandler.handle(e, defaultMessage: 'Error registering user');

      if (failure.statusCode == 400) {
        final message = (e as DioException).response?.data['msg'] as String?;
        return Left(
          ApiFailure(message ?? 'Be sure to fill all the fields'),
        );
      }
      return Left(failure);
    }
  }

  @override
  ResultFuture<UserModel> changePassword({
    required String id,
    required String currentPassword,
    required String password,
  }) async {
    try {
      final result = await _src.changePassword(
        id: id,
        currentPassword: currentPassword,
        password: password,
      );

      return Right(result);
    } catch (e) {
      final failure = ErrorHandler.handle(e, defaultMessage: 'Error changing password');

      if (failure.statusCode == 400) {
        final message = (e as DioException).response?.data['msg'] as String?;
        return Left(
          ApiFailure(message ?? 'Seems like you entered a wrong password'),
        );
      }

      return Left(failure);
    }
  }

  @override
  ResultFuture<List<UserModel>> getUsers() async {
    try {
      final result = await _src.getUsers();

      return Right(result);
    } catch (e) {
      return Left(
        ErrorHandler.handle(e, defaultMessage: 'Error getting users'),
      );
    }
  }

  @override
  ResultFuture<UserModel> deleteAccount({required String id}) async {
    try {
      final result = await _src.deleteAccount(id: id);

      return Right(result);
    } catch (e) {
      return Left(
        ErrorHandler.handle(e, defaultMessage: 'Error deleting account'),
      );
    }
  }
}
