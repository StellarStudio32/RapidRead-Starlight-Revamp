/// Defines the contract for all repositories in the application.
/// This is a core concept of Clean Architecture. By defining an abstract
/// interface, the domain layer can depend on this abstraction rather than
/// a concrete implementation. This allows the data layer to be swapped out
/// with minimal changes to the business logic (e.g., moving from Isar to
/// another database). It also facilitates testing by allowing mock repositories.
abstract class IRepository<T> {
  /// Retrieves a single item by its ID.
  Future<T?> getById(int id);

  /// Retrieves all items.
  Future<List<T>> getAll();

  /// Saves an item (creates if new, updates if exists).
  Future<void> save(T item);

  /// Deletes an item by its ID.
  Future<void> delete(int id);
}
