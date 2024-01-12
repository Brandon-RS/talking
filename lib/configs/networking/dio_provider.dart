import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../logger/app_logger.dart';
import 'i_config.dart';

@module
abstract class DioProvider {
  @lazySingleton
  Dio dio(IConfig config, AppLogger logger) {
    Dio dio = Dio();

    dio.options.headers = config.headers;
    dio.options.baseUrl = config.baseUrl;

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          logger.e(error.response, error.message);
          handler.next(error);
        },
      ),
    );

    return dio;
  }
}
