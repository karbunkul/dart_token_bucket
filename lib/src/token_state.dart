final class TokenState {
  final bool consumed;
  final int remainToRefill;

  const TokenState({
    required this.consumed,
    required this.remainToRefill,
  });

  @override
  String toString() {
    return 'consumed=$consumed, remainToRefill=$remainToRefill';
  }
}
