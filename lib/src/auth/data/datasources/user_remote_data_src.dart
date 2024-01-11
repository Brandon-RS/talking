import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../configs/api/api.dart';
import '../../../user/data/models/user_model.dart';
import '../models/login_model.dart';

abstract class UserRemoteDataSrc {
  Future<LoginModel> register(UserModel user);
}

@injectable
class UserRemoteDataSrcImpl implements UserRemoteDataSrc {
  const UserRemoteDataSrcImpl(this._dio);

  final Dio _dio;

  @override
  Future<LoginModel> register(UserModel user) async {
    final response = await _dio.post(
      Api.users,
      data: user.toJson(),
    );

    if (response.statusCode == 200) {
      return LoginModel.fromJson(response.data);
    } else {
      throw Exception('Error registering user');
    }
  }
}
