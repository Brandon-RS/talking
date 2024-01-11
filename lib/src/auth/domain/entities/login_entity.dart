import 'package:equatable/equatable.dart';

import '../../../user/domain/entities/user_entity.dart';
import '../../data/models/login_model.dart';

class Login extends Equatable {
  const Login({
    required this.user,
    required this.token,
  });

  factory Login.fromModel(LoginModel model) {
    return Login(
      user: User.fromModel(model.user),
      token: model.token,
    );
  }

  final User user;
  final String token;

  @override
  List<Object?> get props => [user, token];

  Login copyWith({
    User? user,
    String? token,
  }) {
    return Login(
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  @override
  String toString() => 'Login(user: $user, token: $token)';
}
