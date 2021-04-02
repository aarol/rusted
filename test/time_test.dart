import 'package:test/test.dart';
import 'package:rusted/rusted.dart';

void main() {
  group('int', () {
    test('should equal durations of all types', () {
      expect(5.minutes, Duration(minutes: 5));
      expect(1.seconds, Duration(seconds: 1));
      expect(500.milliseconds, Duration(milliseconds: 500));
    });
  });
  group('double', () {
    test('should equal durations of all types', () {
      expect(1.5.minutes, Duration(minutes: 1, seconds: 30));
      expect(0.5.seconds, Duration(milliseconds: 500));
      expect(
        500.5.milliseconds,
        Duration(milliseconds: 500, microseconds: 500),
      );
    });
  });
}
