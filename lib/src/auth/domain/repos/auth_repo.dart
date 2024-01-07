import '../../../../core/utils/typedefs.dart';
import '../../data/models/login_model.dart';

abstract class AuthRepo {
  const AuthRepo();

  ResultFuture<LoginModel> login({
    required String email,
    required String password,
  });
}
