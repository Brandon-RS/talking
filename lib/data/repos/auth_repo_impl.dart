import 'package:flutter/foundation.dart';

import '../../domain/repos/auth_repo.dart';
import '../datasources/auth_remote_data_src.dart';
import '../models/login_response.model.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl({AuthRemoteDataSrc? src}) : _src = src ?? AuthRemoteDataSrcImpl();

  final AuthRemoteDataSrc _src;

  @override
  Future<LoginModel> login({required String email, required String password}) async {
    try {
      return await _src.login(email: email, password: password);
    } catch (e, s) {
      // TODO(BRANDOM): Create a logger helper, and a Failure class
      if (kDebugMode) {
        print('❌ $e $s');
      }
      rethrow;
    }
  }
}
