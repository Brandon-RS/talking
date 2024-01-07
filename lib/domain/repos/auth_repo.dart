import '../../data/models/login_response.model.dart';

abstract class AuthRepo {
  const AuthRepo();

  Future<LoginModel> login({
    required String email,
    required String password,
  });
}
