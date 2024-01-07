import '../../core/utils/typedefs.dart';
import '../../data/models/login_response.model.dart';

abstract class AuthRepo {
  const AuthRepo();

  ResultFuture<LoginModel> login({
    required String email,
    required String password,
  });
}
