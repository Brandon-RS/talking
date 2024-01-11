import '../../../../core/utils/typedefs.dart';
import '../../data/models/user_model.dart';

abstract class UserRepo {
  ResultFuture<UserModel> register({
    required String name,
    required String email,
    required String password,
  });
}
