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

class ApiFailure extends Failure {
  const ApiFailure(super.message, {super.statusCode});
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.statusCode});
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message, {super.statusCode});
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure(super.message, {super.statusCode});
}

class NoInternetFailure extends Failure {
  const NoInternetFailure(super.message, {super.statusCode});
}

class NoPermissionFailure extends Failure {
  const NoPermissionFailure(super.message, {super.statusCode});
}
