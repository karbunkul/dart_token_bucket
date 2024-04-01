import 'dart:async';
import 'dart:typed_data';

import 'package:meta/meta.dart';

@immutable
abstract base class BucketStorage {
  const BucketStorage();

  FutureOr<Uint8List?> fetch(String bucketId);
  FutureOr<void> save(String bucketId, Uint8List state);
}
