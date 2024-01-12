import 'package:injectable/injectable.dart';

import '../api/api.dart';
import '../storage/storage_manager.dart';

// TODO(BRANDOM): Make this configurable (read from storage)
const String applicationJSON = "application/json";
const String contentType = "content-type";
const String xToken = "x-token";

abstract class IConfig {
  String get baseUrl;

  Map<String, String?> get headers;
}

@LazySingleton(as: IConfig)
class AppConfig extends IConfig {
  AppConfig(this._storageManager);

  final StorageManager _storageManager;

  @override
  String get baseUrl => Api.baseURL;

  @override
  Map<String, String?> get headers => {
        contentType: applicationJSON,
        xToken: _storageManager.currentToken,
      };
}
