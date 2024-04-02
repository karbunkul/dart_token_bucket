import 'dart:convert';
import 'dart:typed_data';

import 'package:meta/meta.dart';

/// @internal
/// Represents the state of a bucket for rate limiting.
@immutable
class BucketState {
  /// The number of tokens in the bucket.
  final int count;

  /// The timestamp of the bucket state.
  final int timestamp;

  /// Constructs a bucket state with the provided count and timestamp.
  const BucketState({required this.count, required this.timestamp});

  /// Retrieves the bytes representing the bucket state.
  Uint8List get bytes {
    return utf8.encode('$timestamp|$count');
  }

  /// Consumes tokens from the bucket and returns the new state.
  BucketState consume(int coast) {
    return BucketState(count: count + coast, timestamp: timestamp);
  }

  /// Initializes a bucket state with the given count and current timestamp.
  factory BucketState.initState({int count = 1}) {
    return BucketState(
      count: count,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }

  /// Constructs a bucket state from the provided bytes.
  factory BucketState.fromBytes(Uint8List bytes) {
    final parts = utf8.decode(bytes).split('|');
    return BucketState(
      count: int.parse(parts.last),
      timestamp: int.parse(parts.first),
    );
  }
}
