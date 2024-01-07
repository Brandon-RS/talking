import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'i_config.dart';

@module
abstract class DioProvider {
  @singleton
  Dio dio(IConfig config) {
    Dio dio = Dio();

    dio.options.headers = config.headers;
    dio.options.baseUrl = config.baseUrl;

    if (!kReleaseMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
          responseHeader: true,
        ),
      );
    }

    return dio;
  }
}
