/// An enumeration representing different refill frequencies for a token bucket.
enum RefillFrequency {
  /// Refill frequency of one second in milliseconds.
  second(1000),

  /// Refill frequency of one minute in milliseconds.
  minute(60000),

  /// Refill frequency of one hour in milliseconds.
  hour(3600000),

  /// Refill frequency of one day in milliseconds.
  day(86400000);

  /// Refill frequency in milliseconds.
  final int frequency;

  /// Constructs a refill frequency with the provided [frequency] in milliseconds.
  const RefillFrequency(this.frequency);
}
