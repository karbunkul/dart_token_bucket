/// A class representing the state of tokens in a token bucket.
class TokenState {
  /// Indicates whether tokens have been consumed or not.
  final bool consumed;

  /// The number of tokens remaining to refill.
  final int remainToRefill;

  /// Constructs a token state with the provided parameters.
  const TokenState({
    required this.consumed,
    required this.remainToRefill,
  });

  @override
  String toString() {
    // Returns a string representation of the token state.
    return 'consumed=$consumed, remainToRefill=$remainToRefill';
  }
}
