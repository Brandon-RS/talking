import 'package:equatable/equatable.dart';

import '../../data/models/user_model.dart';

class User extends Equatable {
  const User({
    required this.online,
    required this.name,
    required this.email,
    required this.uid,
    this.profileImage,
  });

  static const empty = User(
    online: false,
    name: '',
    email: '',
    uid: '',
    profileImage: null,
  );

  static fromModelList(List<UserModel> models) {
    return models.map((model) => User.fromModel(model)).toList();
  }

  factory User.fromModel(UserModel model) {
    return User(
      online: model.online,
      name: model.name,
      email: model.email,
      uid: model.uid,
      profileImage: model.profileImage,
    );
  }

  UserModel toModel() {
    return UserModel(
      online: online,
      name: name,
      email: email,
      uid: uid,
      profileImage: profileImage,
    );
  }

  final bool online;
  final String name;
  final String email;
  final String uid;
  final String? profileImage;

  @override
  List<Object?> get props => [uid, name, email, online];

  User copyWith({
    bool? online,
    String? name,
    String? email,
    String? uid,
    String? profileImage,
  }) {
    return User(
      online: online ?? this.online,
      name: name ?? this.name,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  @override
  String toString() {
    return 'User(online: $online, name: $name, email: $email, uid: $uid)';
  }
}
