import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../configs/api/api.dart';
import '../../../auth/data/models/login_model.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSrc {
  Future<LoginModel> register({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> changePassword({
    required String id,
    required String currentPassword,
    required String password,
  });

  Future<List<UserModel>> getUsers();

  Future<UserModel> deleteAccount({
    required String id,
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

  @override
  Future<UserModel> changePassword({
    required String id,
    required String currentPassword,
    required String password,
  }) async {
    final response = await _dio.put(
      Api.changePassword(id),
      data: {
        'current_password': currentPassword,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception('Error changing password');
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await _dio.get(Api.users);

    if (response.statusCode == 200) {
      final users = response.data as List;
      return users.map((user) => UserModel.fromJson(user)).toList();
    } else {
      throw Exception('Error getting users');
    }
  }

  @override
  Future<UserModel> deleteAccount({required String id}) async {
    final response = await _dio.delete(
      Api.users,
      queryParameters: {'id': id},
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception('Error deleting user account');
    }
  }
}
