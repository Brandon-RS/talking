import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/dio_error_handler.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/typedefs.dart';
import '../../../user/data/models/user_model.dart';
import '../../domain/repos/user_repo.dart';
import '../datasources/user_remote_data_src.dart';

@Injectable(as: UserRepo)
class UserRepoImpl implements UserRepo {
  UserRepoImpl(this._src);

  final UserRemoteDataSrc _src;

  @override
  ResultFuture<UserModel> register({
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

      return Right(result.user);
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
}
