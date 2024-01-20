import '../../../../core/utils/typedefs.dart';
import '../../../auth/data/models/login_model.dart';
import '../../data/models/user_model.dart';

abstract class UserRepo {
  ResultFuture<LoginModel> register({
    required String name,
    required String email,
    required String password,
  });

  ResultFuture<List<UserModel>> getUsers();
}
