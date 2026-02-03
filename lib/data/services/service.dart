/// Defines a contract for services that interact with external systems.
/// Similar to the repository pattern, having a base service interface
/// abstracts the implementation details away from the business logic.
/// This is crucial for components like AI services or file parsers,
/// allowing them to be mocked for testing or replaced if the underlying
/// technology changes, promoting loose coupling and maintainability.
abstract class IService {
  /// Initializes the service. This can be used for setup tasks like
  /// authenticating with an API or loading necessary resources.
  Future<void> initialize();
}
