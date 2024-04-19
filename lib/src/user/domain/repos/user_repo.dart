import 'package:talking/core/utils/typedefs.dart';
import 'package:talking/src/auth/data/models/login_model.dart';
import 'package:talking/src/user/data/models/profile_pic_model.dart';
import 'package:talking/src/user/data/models/user_model.dart';

abstract class UserRepo {
  ResultFuture<LoginModel> register({
    required String name,
    required String email,
    required String password,
  });

  ResultFuture<UserModel> changePassword({
    required String id,
    required String currentPassword,
    required String password,
  });

  ResultFuture<List<UserModel>> getUsers();

  ResultFuture<ProfilePicModel> uploadProfilePic({
    required String path,
    required String userUid,
  });

  ResultFuture<UserModel> deleteAccount({
    required String id,
  });
}
