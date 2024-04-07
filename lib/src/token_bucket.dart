import 'package:token_bucket/src/bucket_state.dart';
import 'package:token_bucket/src/bucket_storage.dart';
import 'package:token_bucket/src/refill_frequency.dart';
import 'package:token_bucket/src/token_state.dart';

/// A class representing a token bucket used for rate limiting.
class TokenBucket {
  /// The maximum capacity of the token bucket.
  final int capacity;

  /// The refill frequency of the token bucket.
  final RefillFrequency frequency;

  /// The storage mechanism for the token bucket state.
  final BucketStorage storage;

  /// Constructs a token bucket with the provided parameters.
  const TokenBucket({
    required this.capacity,
    required this.storage,
    this.frequency = RefillFrequency.minute,
  });

  /// Consumes tokens from the token bucket identified by [bucketId].
  /// Returns the token state after consumption.
  Future<TokenState> consume({required String bucketId, int coast = 1}) async {
    if (coast <= 0 || coast > capacity) {
      throw ArgumentError('coast must be in range 0 to $capacity');
    }

    final state = await storage.fetch(bucketId);
    if (state == null) {
      // Initialize bucket state if it doesn't exist.
      await storage.save(bucketId, BucketState.initState(count: coast).state);
      return TokenState(consumed: true, remainToRefill: 0);
    }

    final bucketState = BucketState.fromState(state);

    if (bucketState.count + coast > capacity) {
      // Calculate remaining time to refill if the bucket is full.
      final now = DateTime.now().millisecondsSinceEpoch;
      final remainToRefill = bucketState.timestamp + frequency.frequency - now;

      if (remainToRefill < 0) {
        // Refill the bucket if the refill time has passed.
        await storage.save(bucketId, BucketState.initState(count: coast).state);
        return TokenState(consumed: true, remainToRefill: 0);
      } else {
        // Tokens cannot be consumed, return the remaining time to refill.
        return TokenState(consumed: false, remainToRefill: remainToRefill);
      }
    }
    // Consume tokens from the bucket and update its state.
    await storage.save(bucketId, bucketState.consume(coast).state);
    return TokenState(consumed: true, remainToRefill: 0);
  }
}
