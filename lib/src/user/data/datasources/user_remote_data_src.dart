import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:talking/configs/api/api.dart';
import 'package:talking/configs/storage/storage_manager.dart';
import 'package:talking/src/auth/data/models/login_model.dart';
import 'package:talking/src/user/data/models/profile_pic_model.dart';
import 'package:talking/src/user/data/models/user_model.dart';

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

  Future<ProfilePicModel> uploadProfilePic({
    required String path,
    required String userUid,
  });

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
      final model = LoginModel.fromJson(response.data);
      _setToken(model.token);
      return model;
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
  Future<ProfilePicModel> uploadProfilePic({
    required String path,
    required String userUid,
  }) async {
    final response = await _dio.post(
      Api.uploadImage,
      data: FormData.fromMap(
        {'file': await MultipartFile.fromFile(path)},
      ),
      queryParameters: {
        'upload_preset': 'profile-pics',
        'public_id': userUid,
      },
    );

    if (response.statusCode == 200) {
      return ProfilePicModel.fromJson(response.data);
    } else {
      throw Exception('Error uploading profile pic');
    }
  }

  @override
  Future<UserModel> deleteAccount({required String id}) async {
    final response = await _dio.delete(
      Api.deleteAccount(id),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception('Error deleting user account');
    }
  }

  void _setToken(String token) {
    _dio.options.headers[StorageManager.xToken] = token;
  }
}
