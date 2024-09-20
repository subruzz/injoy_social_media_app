import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';

/// A base class for use cases that return a `Future` of either `Failure` or `SuccessType`.
abstract interface class UseCase<SuccessType, Params> {
  /// Executes the use case with the given parameters.
  Future<Either<Failure, SuccessType>> call(Params params);
}

/// A base class for use cases that return a `Stream` of either `Failure` or `SuccessType`.
abstract interface class StreamUseCase<SuccessType, Params> {
  /// Executes the use case and returns a `Stream`.
  Stream<Either<Failure, SuccessType>> call(Params params);
}

/// Represents the absence of parameters for a use case.
class NoParams {}
