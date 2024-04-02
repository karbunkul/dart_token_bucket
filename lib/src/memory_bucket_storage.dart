import 'dart:async';
import 'dart:typed_data';

import 'package:token_bucket/src/bucket_storage.dart';

/// A concrete implementation of [BucketStorage] that stores data in memory.
class MemoryBucketStorage extends BucketStorage {
  MemoryBucketStorage();

  /// Internal storage for bucket data.
  final _storage = <String, Uint8List>{};

  @override
  FutureOr<Uint8List?> fetch(String bucketId) {
    // Returns the data associated with the provided [bucketId] if it exists, otherwise returns null.
    return _storage.containsKey(bucketId) ? _storage[bucketId] : null;
  }

  @override
  FutureOr<void> save(String bucketId, Uint8List state) {
    // Saves the provided [state] associated with the given [bucketId] in the storage.
    _storage[bucketId] = state;
  }

  /// Clears all data stored in the memory storage.
  void reset() => _storage.clear();
}
