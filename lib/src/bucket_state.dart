import 'dart:convert';
import 'dart:typed_data';

import 'package:meta/meta.dart';

@internal
@immutable
final class BucketState {
  final int count;
  final int timestamp;

  const BucketState({required this.count, required this.timestamp});

  Uint8List get bytes {
    return utf8.encode('$timestamp|$count');
  }

  BucketState consume(int coast) {
    return BucketState(count: count + coast, timestamp: timestamp);
  }

  factory BucketState.initState({int count = 1}) {
    return BucketState(
      count: count,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }

  factory BucketState.fromBytes(Uint8List bytes) {
    final parts = utf8.decode(bytes).split('|');
    return BucketState(
      count: int.parse(parts.last),
      timestamp: int.parse(parts.first),
    );
  }
}
