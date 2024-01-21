import 'package:injectable/injectable.dart';

import '../api/api.dart';
import '../storage/storage_manager.dart';

const String applicationJSON = "application/json";
const String contentType = "content-type";

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
        StorageManager.xToken: _storageManager.currentToken,
      };
}
