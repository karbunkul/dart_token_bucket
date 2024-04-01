import 'package:test/test.dart';
import 'package:token_bucket/token_bucket.dart';

void main() {
  final storage = MemoryBucketStorage();
  final tokenBucket = TokenBucket(
    capacity: 20,
    frequency: RefillFrequency.second,
    storage: storage,
  );

  tearDown(() {
    storage.reset();
  });

  test('Coast greater then capacity throw error', () {
    expect(
      () => tokenBucket.consume(bucketId: 'bucketId', coast: -1),
      throwsArgumentError,
    );

    expect(
      () => tokenBucket.consume(bucketId: 'bucketId', coast: 0),
      throwsArgumentError,
    );

    expect(
      () => tokenBucket.consume(bucketId: 'bucketId', coast: 21),
      throwsArgumentError,
    );
  });

  group('Consume', () {
    test('Capacity is full', () async {
      await _consumeTest(tokenBucket: tokenBucket, coast: 10, consumed: true);
      await _consumeTest(tokenBucket: tokenBucket, coast: 10, consumed: true);
      await _consumeTest(tokenBucket: tokenBucket, coast: 3, consumed: false);
    });

    test('Not consumed if coast not consumed', () async {
      await _consumeTest(tokenBucket: tokenBucket, coast: 10, consumed: true);
      await _consumeTest(tokenBucket: tokenBucket, coast: 15, consumed: false);
      await _consumeTest(tokenBucket: tokenBucket, coast: 3, consumed: true);
    });

    test('Consumed after refill', () async {
      await _consumeTest(tokenBucket: tokenBucket, coast: 10, consumed: true);
      await _consumeTest(tokenBucket: tokenBucket, coast: 10, consumed: true);
      await _consumeTest(
        tokenBucket: tokenBucket,
        coast: 10,
        consumed: true,
        delay: const Duration(milliseconds: 1000),
      );
    });
  });
}

Future<void> _consumeTest({
  required TokenBucket tokenBucket,
  required int coast,
  required bool consumed,
  Duration delay = Duration.zero,
}) async {
  if (delay.inMilliseconds > 0) {
    await Future.delayed(delay);
  }
  final state = await tokenBucket.consume(bucketId: 'bucketId', coast: coast);
  expect(state.consumed, equals(consumed));
}
