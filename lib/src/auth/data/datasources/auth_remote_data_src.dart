import 'package:dio/dio.dart';

import '../../../../core/global/environment.dart';
import '../models/login_model.dart';

abstract class AuthRemoteDataSrc {
  const AuthRemoteDataSrc();

  Future<LoginModel> login({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSrcImpl implements AuthRemoteDataSrc {
  // TODO(BRANDOM): Create a dio helper (to avoid repeating the headers and other configs)
  final Dio _dio = Dio();

  @override
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final authData = {
      'email': email,
      'password': password,
    };

    final response = await _dio.post(
      Environment.auth,
      data: authData,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      return LoginModel.fromJson(response.data);
    } else {
      throw Exception('Error on login');
    }
  }
}
