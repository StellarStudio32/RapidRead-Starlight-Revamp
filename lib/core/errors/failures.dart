/// Defines a standardized structure for handling errors and failures.
/// In Clean Architecture, the domain layer defines business logic and is
/// independent of other layers. By creating a base `Failure` class, we can
/// represent domain-level errors that use-cases can return without coupling
/// them to specific UI or data-layer exceptions.
abstract class Failure {
  final String message;

  const Failure(this.message);
}

/// Represents a failure from a local data source (e.g., Isar database).
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Represents a failure from a remote data source (e.g., an API).
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}
