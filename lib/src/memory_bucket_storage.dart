import 'dart:async';
import 'dart:typed_data';

import 'package:token_bucket/src/bucket_storage.dart';

final class MemoryBucketStorage extends BucketStorage {
  MemoryBucketStorage();

  final _storage = <String, Uint8List>{};

  @override
  FutureOr<Uint8List?> fetch(String bucketId) {
    return _storage.containsKey(bucketId) ? _storage[bucketId] : null;
  }

  @override
  FutureOr<void> save(String bucketId, Uint8List state) {
    _storage[bucketId] = state;
  }

  void reset() => _storage.clear();
}
