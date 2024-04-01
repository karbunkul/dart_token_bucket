import 'package:token_bucket/src/bucket_state.dart';
import 'package:token_bucket/src/bucket_storage.dart';
import 'package:token_bucket/src/refill_frequency.dart';
import 'package:token_bucket/src/token_state.dart';

class TokenBucket {
  final int capacity;
  final RefillFrequency frequency;
  final BucketStorage storage;

  const TokenBucket({
    required this.capacity,
    required this.storage,
    this.frequency = RefillFrequency.minute,
  });

  Future<TokenState> consume({required String bucketId, int coast = 1}) async {
    if (coast <= 0 || coast > capacity) {
      throw ArgumentError('coast must be in range 0 to $capacity');
    }

    final state = await storage.fetch(bucketId);
    if (state == null) {
      await storage.save(bucketId, BucketState.initState(count: coast).bytes);
      return TokenState(consumed: true, remainToRefill: 0);
    }

    final bucketState = BucketState.fromBytes(state);

    if (bucketState.count + coast > capacity) {
      final now = DateTime.now().millisecondsSinceEpoch;
      final remainToRefill = bucketState.timestamp + frequency.frequency - now;

      if (remainToRefill < 0) {
        await storage.save(bucketId, BucketState.initState(count: coast).bytes);
        return TokenState(consumed: true, remainToRefill: 0);
      } else {
        return TokenState(consumed: false, remainToRefill: remainToRefill);
      }
    }
    await storage.save(bucketId, bucketState.consume(coast).bytes);
    return TokenState(consumed: true, remainToRefill: 0);
  }
}
