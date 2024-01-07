// TODO(BRANDOM): Configure the `apiUrl` as default for all requests (create a Dio helper)
abstract class Environment {
  static const String apiUrl = 'https://talkingserver-production.up.railway.app/api';

  static const String auth = '$apiUrl/auth';
}
