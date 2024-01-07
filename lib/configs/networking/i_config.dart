// ignore_for_file: constant_identifier_names

import 'package:injectable/injectable.dart';

import '../api/api.dart';

// TODO(BRANDOM): Make this configurable (read from storage)
const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String AUTHORIZATION = "authorization";
const String TOKEN = ""; // Set the stored token here

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
        CONTENT_TYPE: APPLICATION_JSON,
        AUTHORIZATION: TOKEN,
      };
}
