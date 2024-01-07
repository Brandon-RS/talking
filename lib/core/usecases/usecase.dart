import '../utils/typedefs.dart';

abstract class Usecase<Type, Params> {
  const Usecase();

  ResultFuture<Type> call(Params params);
}

abstract class UsecaseNoParams<Type> {
  const UsecaseNoParams();

  ResultFuture<Type> call();
}
