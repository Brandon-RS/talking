abstract class Api {
  static const String baseURL = 'https://talkingserver-production.up.railway.app/api';

  static const String chat = '$baseURL/chats';

  static const String auth = '/auth';

  static const String renewToken = '/renew-token';

  static const String users = '/users';

  static String chats(String targetUserId) => '$users/chats/$targetUserId';

  static String changePassword(String id) => '$users/$id/change-password';

  static String deleteAccount(String id) => '$users/$id';

  static String changeProfilePic(String id) => '$users/$id/change-profile-pic';
}
