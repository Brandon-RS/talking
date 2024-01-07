import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:talking/data/models/login_response.model.dart';
import 'package:talking/data/models/user_model.dart';

import '../../../core/global/environment.dart';

// ! This is a provider example to test the local backend
// TODO(BRANDOM): Pending to migrate to riverpod or block
// Also create usecases, repositories, and usecases to follow DDD
// Replace models with entities
class AuthProvider with ChangeNotifier {
  final _dio = Dio();

  UserModel? user;

  Future<void> login({required String email, required String password}) async {
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
      final loginResponse = LoginModel.fromJson(response.data);
      user = loginResponse.user;
    } else {
      throw Exception('Error on login');
    }
  }
}
