enum RefillFrequency {
  // one second in milliseconds
  second(1000),
  // one minute in milliseconds
  minute(60000),
  // one hour in milliseconds
  hour(3600000),
  // one day in milliseconds
  day(86400000);

  /// Refill frequency in milliseconds
  final int frequency;

  const RefillFrequency(this.frequency);
}
