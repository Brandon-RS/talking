import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(
    this.message, {
    this.statusCode,
  });

  final String message;
  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class AppFailure extends Failure {
  const AppFailure(super.message, {super.statusCode});
}

class ApiFailure extends Failure {
  const ApiFailure(super.message, {super.statusCode});
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {super.statusCode});
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message, {super.statusCode});
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure(super.message, {super.statusCode});
}
