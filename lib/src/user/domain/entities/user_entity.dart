import 'package:equatable/equatable.dart';

import '../../data/models/user_model.dart';

class User extends Equatable {
  const User({
    required this.online,
    required this.name,
    required this.email,
    required this.uid,
  });

  static fromModelList(List<UserModel> models) {
    return models.map((model) => User.fromModel(model)).toList();
  }

  static empty() => const User(
        online: false,
        name: '',
        email: '',
        uid: '',
      );

  factory User.fromModel(UserModel model) {
    return User(
      online: model.online,
      name: model.name,
      email: model.email,
      uid: model.uid,
    );
  }

  UserModel toModel() {
    return UserModel(
      online: online,
      name: name,
      email: email,
      uid: uid,
    );
  }

  final bool online;
  final String name;
  final String email;
  final String uid;

  @override
  List<Object?> get props => [uid, name, email, online];

  User copyWith({
    bool? online,
    String? name,
    String? email,
    String? uid,
  }) {
    return User(
      online: online ?? this.online,
      name: name ?? this.name,
      email: email ?? this.email,
      uid: uid ?? this.uid,
    );
  }

  @override
  String toString() {
    return 'User(online: $online, name: $name, email: $email, uid: $uid)';
  }
}
