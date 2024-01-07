// TODO(BRANDOM): Configure the `apiUrl` as default for all requests (create a Dio helper)
import 'dart:io';

abstract class Environment {
  static final String apiUrl = Platform.isAndroid ? 'http://10.0.2.2:3000/api' : 'http://localhost:3000/api';

  static final String auth = '$apiUrl/auth';
}
