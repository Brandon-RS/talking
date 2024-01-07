import 'package:dio/dio.dart';

import '../../configs/di/injector.dart';
import '../../configs/logger/app_logger.dart';
import '../networking/response_codes.dart';
import 'failure.dart';

class ErrorHandler implements Exception {
  /// `defaultMessage` is used when the error is not a [DioException]
  static Failure handle(dynamic error, {String? defaultMessage}) {
    late Failure failure;

    if (error is DioException) {
      failure = _handleDioError(error);
    } else {
      final message = ResponseCode.unknown.failure.message;
      final statusCode = ResponseCode.unknown.failure.statusCode;

      failure = UnknownFailure(defaultMessage ?? message, statusCode: statusCode);

      sl<AppLogger>().e(error, failure.message);
    }

    return failure;
  }

  static Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ResponseCode.connectTimeout.failure;
      case DioExceptionType.sendTimeout:
        return ResponseCode.sendTimeout.failure;
      case DioExceptionType.receiveTimeout:
        return ResponseCode.recieveTimeout.failure;
      case DioExceptionType.badResponse:
        return _handleBadResponse(error);
      case DioExceptionType.cancel:
        return ResponseCode.cancel.failure;
      default:
        return ResponseCode.unknown.failure;
    }
  }

  static Failure _handleBadResponse(DioException error) {
    switch (error.response?.statusCode) {
      case 400:
        return ResponseCode.badRequest.failure;
      case 401:
        return ResponseCode.unauthorized.failure;
      case 403:
        return ResponseCode.forbidden.failure;
      case 404:
        return ResponseCode.notFound.failure;
      case 500:
        return ResponseCode.internalServerError.failure;
      default:
        return ResponseCode.unknown.failure;
    }
  }
}
