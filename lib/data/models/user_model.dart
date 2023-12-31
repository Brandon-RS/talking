import 'package:uuid/uuid.dart';

class UserModel {
  const UserModel({
    required this.online,
    required this.name,
    required this.email,
    required this.uid,
  });

  final bool online;
  final String name;
  final String email;
  final String uid;

  UserModel copyWith({
    bool? online,
    String? name,
    String? email,
    String? uid,
  }) {
    return UserModel(
      online: online ?? this.online,
      name: name ?? this.name,
      email: email ?? this.email,
      uid: uid ?? this.uid,
    );
  }

  // TODO(BRANDOM): Remove this, is just for testing
  static List<UserModel> get dummyUsers => [
        UserModel(online: true, name: 'Test 1', email: 'test_1@test.com', uid: const Uuid().v4()),
        UserModel(online: false, name: 'Test 2', email: 'test_2@test.com', uid: const Uuid().v4()),
        UserModel(online: false, name: 'Test 3', email: 'test_3@test.com', uid: const Uuid().v4()),
        UserModel(online: true, name: 'Test 4', email: 'test_4@test.com', uid: const Uuid().v4()),
        UserModel(online: false, name: 'Test 5', email: 'test_5@test.com', uid: const Uuid().v4()),
        UserModel(online: true, name: 'Test 6', email: 'test_6@test.com', uid: const Uuid().v4()),
      ];
}
