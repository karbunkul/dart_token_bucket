# Token Bucket

Token Bucket is a Dart library for implementing rate limiting using the token bucket algorithm. It provides a simple and efficient way to control the rate of actions in your application.

## Features

- **Token Bucket Algorithm:** Implements the token bucket algorithm for rate limiting.
- **Flexible Configuration:** Customize token bucket capacity, refill frequency, and storage mechanism.
- **Memory and Custom Storage:** Supports memory-based storage and allows integration with custom storage solutions.
- **Async Operations:** Asynchronous token consumption for non-blocking rate limiting.

## Installation

To use Token Bucket in your Dart project, add it to your `pubspec.yaml`:

```yaml
dependencies:
  token_bucket: ^1.0.0
```

Then, run dart pub get to install the package.

## Usage

```dart
import 'package:token_bucket/token_bucket.dart';

void main() async {
  // Initialize a token bucket with a capacity of 100 tokens and a refill frequency of one minute.
  final bucket = TokenBucket(
    capacity: 100,
    frequency: RefillFrequency.minute,
    storage: MemoryBucketStorage(),
  );

  try {
    // Consume tokens from the bucket identified by 'user123'.
    final state = await bucket.consume(bucketId: 'user123', coast: 10);
    if (state.consumed) {
      print('Tokens consumed successfully!');
    } else {
      print('Tokens cannot be consumed. Remaining time to refill: ${state.remainToRefill} milliseconds.');
    }
  } catch (e) {
    print('Error: $e');
  }
}
```