import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../global/environment.dart';

// ! This is a provider example to test the local backend
// TODO(BRANDOM): Pending to migrate to riverpod or block
// Also create usecases, repositories, and usecases to follow DDD
class AuthProvider with ChangeNotifier {
  final _dio = Dio();

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

    print('❌ ${response.data}');
  }
}
