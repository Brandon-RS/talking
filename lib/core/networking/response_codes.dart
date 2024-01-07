import '../errors/failure.dart';
import 'error_codes.dart';

enum ResponseCode {
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  recieveTimeout,
  sendTimeout,
  noInternetConnection,
  unknown
}

extension DataSourceExtension on ResponseCode {
  Failure get failure {
    const noConnectionDefaultMessage = 'Check your internet connection and try again.';

    switch (this) {
      case ResponseCode.noContent:
        return const ApiFailure(
          'There is no content to show.',
          statusCode: ErrorCodes.noContent,
        );
      case ResponseCode.badRequest:
        return const ApiFailure(
          'Something went wrong. Please, try again later.',
          statusCode: ErrorCodes.badRequest,
        );
      case ResponseCode.forbidden:
        return const ApiFailure(
          'You are not allowed to do this.',
          statusCode: ErrorCodes.forbidden,
        );
      case ResponseCode.unauthorized:
        return const ApiFailure(
          'You are not logged in.',
          statusCode: ErrorCodes.unauthorized,
        );
      case ResponseCode.notFound:
        return const ApiFailure(
          'The resource you are looking for was not found.',
          statusCode: ErrorCodes.notFound,
        );
      case ResponseCode.internalServerError:
        return const ApiFailure(
          'Fatal error. Please, try again later. If the problem persists, contact the support team.',
          statusCode: ErrorCodes.internalServerError,
        );
      case ResponseCode.cancel:
        return const NetworkFailure(
          'Action canceled.',
          statusCode: ErrorCodes.cancel,
        );

      // Network failures
      case ResponseCode.connectTimeout:
        return const NetworkFailure(noConnectionDefaultMessage, statusCode: ErrorCodes.connectTimeout);
      case ResponseCode.recieveTimeout:
        return const NetworkFailure(noConnectionDefaultMessage, statusCode: ErrorCodes.recieveTimeout);
      case ResponseCode.sendTimeout:
        return const NetworkFailure(noConnectionDefaultMessage, statusCode: ErrorCodes.sendTimeout);
      case ResponseCode.noInternetConnection:
        return const NetworkFailure(noConnectionDefaultMessage, statusCode: ErrorCodes.noInternetConnection);

      // Default errors
      case ResponseCode.unknown:
        return const UnknownFailure(
          '',
          statusCode: ErrorCodes.unknown,
        );
    }
  }
}
