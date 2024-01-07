// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'user_model.g.dart';

@JsonSerializable(
  checked: true,
  explicitToJson: true,
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
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

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return 'UserModel(online: $online, name: $name, email: $email, uid: $uid)';
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
