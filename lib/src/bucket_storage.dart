import 'dart:async';
import 'dart:typed_data';

/// An abstract base class for bucket storage, defining methods for fetching and saving data.
abstract class BucketStorage {
  const BucketStorage();

  /// Fetches the data associated with the provided [bucketId].
  /// Returns a [Uint8List] representing the fetched data, or null if the data doesn't exist.
  FutureOr<Uint8List?> fetch(String bucketId);

  /// Saves the provided [state] associated with the given [bucketId].
  /// Throws an error if saving fails.
  FutureOr<void> save(String bucketId, Uint8List state);
}
