import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../configs/api/api.dart';
import '../../../../configs/storage/storage_manager.dart';
import '../models/login_model.dart';

abstract class AuthRemoteDataSrc {
  const AuthRemoteDataSrc();

  Future<LoginModel> login({
    required String email,
    required String password,
  });

  Future<LoginModel> renewToken();

  Future<bool> logout();
}

@Injectable(as: AuthRemoteDataSrc)
class AuthRemoteDataSrcImpl implements AuthRemoteDataSrc {
  const AuthRemoteDataSrcImpl(this._dio);

  final Dio _dio;

  @override
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final authData = {
      'email': email,
      'password': password,
    };

    final response = await _dio.post(Api.auth, data: authData);

    if (response.statusCode == 200) {
      final model = LoginModel.fromJson(response.data);
      _setToken(model.token);
      return model;
    } else {
      throw Exception('Error on login');
    }
  }

  @override
  Future<LoginModel> renewToken() async {
    final response = await _dio.get(Api.renewToken);

    if (response.statusCode == 200) {
      final model = LoginModel.fromJson(response.data);
      _setToken(model.token);
      return model;
    } else {
      throw Exception('Error on login');
    }
  }

  @override
  Future<bool> logout() async {
    // TODO(BRANDOM): Pending backend implementation
    await Future.delayed(const Duration(milliseconds: 600));
    _dio.options.headers.remove(StorageManager.xToken);
    return true;
  }

  void _setToken(String token) {
    _dio.options.headers[StorageManager.xToken] = token;
  }
}
