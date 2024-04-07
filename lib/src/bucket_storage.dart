import 'dart:async';

/// An abstract base class for bucket storage, defining methods for fetching and saving data.
abstract class BucketStorage {
  const BucketStorage();

  /// Fetches the data associated with the provided [bucketId].
  /// Returns a [String] representing the fetched data, or null if the data doesn't exist.
  FutureOr<String?> fetch(String bucketId);

  /// Saves the provided [state] associated with the given [bucketId].
  /// Throws an error if saving fails.
  FutureOr<void> save(String bucketId, String state);
}
