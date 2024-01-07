import 'package:injectable/injectable.dart';

import '../api/api.dart';

// TODO(BRANDOM): Make this configurable (read from storage)
const String applicationJSON = "application/json";
const String contentType = "content-type";
const String xToken = "x-token";
const String jwt = ""; // Set the stored token here

abstract class IConfig {
  String get baseUrl;

  Map<String, String> get headers;
}

@Injectable(as: IConfig)
class AppConfig extends IConfig {
  @override
  String get baseUrl => Api.baseURL;

  @override
  Map<String, String> get headers => {
        contentType: applicationJSON,
        xToken: jwt,
      };
}
