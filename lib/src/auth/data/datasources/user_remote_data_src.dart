import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../configs/api/api.dart';
import '../models/login_model.dart';

abstract class UserRemoteDataSrc {
  Future<LoginModel> register({
    required String name,
    required String email,
    required String password,
  });
}

@Injectable(as: UserRemoteDataSrc)
class UserRemoteDataSrcImpl implements UserRemoteDataSrc {
  const UserRemoteDataSrcImpl(this._dio);

  final Dio _dio;

  @override
  Future<LoginModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      Api.users,
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return LoginModel.fromJson(response.data);
    } else {
      throw Exception('Error registering user');
    }
  }
}
