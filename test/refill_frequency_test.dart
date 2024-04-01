import 'package:test/test.dart';
import 'package:token_bucket/src/refill_frequency.dart';

void main() {
  group('Check RefillFrequency values', () {
    // one second in milliseconds
    _checkValues(frequency: RefillFrequency.second, actual: 1000);
    // one minute in milliseconds
    _checkValues(frequency: RefillFrequency.minute, actual: 60 * 1000);
    // one hour in milliseconds
    _checkValues(frequency: RefillFrequency.hour, actual: 60 * 60 * 1000);
    // one day in milliseconds
    _checkValues(frequency: RefillFrequency.day, actual: 24 * 60 * 60 * 1000);
  });
}

void _checkValues({required RefillFrequency frequency, required int actual}) {
  test('$frequency must be equals $actual milliseconds', () {
    expect(frequency.frequency, equals(actual));
  });
}
