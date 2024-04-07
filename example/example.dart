import 'package:token_bucket/src/memory_bucket_storage.dart';
import 'package:token_bucket/src/refill_frequency.dart';
import 'package:token_bucket/src/token_bucket.dart';

Future<void> main() async {
  final tokenBucket = TokenBucket(
    capacity: 20,
    frequency: RefillFrequency.second,
    storage: MemoryBucketStorage(),
  );

  await consume(tokenBucket, 10);
  await consume(tokenBucket, 10);
  await consume(tokenBucket, 3);
}

Future<void> consume(TokenBucket bucket, int coast) {
  return bucket.consume(bucketId: 'bucketId', coast: coast).then(print);
}
