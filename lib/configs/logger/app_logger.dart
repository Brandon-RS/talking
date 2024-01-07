import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@singleton
class AppLogger {
  late Logger _logger;

  @factoryMethod
  AppLogger() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 8,
        levelEmojis: {
          Level.trace: '🔍',
          Level.debug: '🐛',
          Level.info: '📝',
          Level.warning: '⚠️',
          Level.error: '❌',
          Level.fatal: '💀',
        },
      ),
    );
  }

  void i(dynamic message, [Object? e, StackTrace? s]) {
    _logger.i(message, error: e, stackTrace: s);
  }

  void d(dynamic message, [Object? e, StackTrace? s]) {
    _logger.d(message, error: e, stackTrace: s);
  }

  void w(dynamic message, [Object? e, StackTrace? s]) {
    _logger.w(message, error: e, stackTrace: s);
  }

  void e(dynamic message, [Object? e, StackTrace? s]) {
    _logger.e(message, error: e, stackTrace: s);
  }
}
