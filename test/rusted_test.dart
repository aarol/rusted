import 'package:rusted/rusted.dart';
import 'package:test/test.dart';
import 'package:rusted/src/futureExt.dart';

void main() {
  group('result', () {
    test('fold', () {
      var res = Ok('test');

      var temp = res.fold((ok) => 'success', (err) => 'error');
      expect(temp, 'success');
    });

    test('is*', () {
      var res = Ok('test');
      expect(res.isOk, true);
      expect(res.isErr, false);
      var ok = res.whenOk((ok) => 'OK');
      expect(ok, 'OK');
      var err = res.whenErr((err) => 'err');
      expect(err, null);
    });

    test('from', () {
      var res = Result.of(() {
        return '';
      });
      expect(res.isOk, true);
      var res2 = Result.of(() {
        var list = [1, 2, 3]..removeAt(7);
        return list;
      });
      expect(res2.isErr, true);
    });

    test('from should not accept null as error type', () {
      var res = () {
        Result<String, Null>.of(() => 'val');
      };

      expect(() => res(), throwsA(isA<AssertionError>()));
    });

    test('should be able to fold future', () async {
      var future = Future<Result<String, dynamic>>.value(Ok('a'));
      final result = await future.foldAsync((ok) {
        return 'ok';
      }, (err) {
        return 'err';
      });

      expect(result, 'ok');
    });
  });

  group('time', () {
    test('int', () {
      expect(5.minutes, Duration(minutes: 5));
      expect(5.seconds, Duration(seconds: 5));
      expect(5.milliseconds, Duration(milliseconds: 5));
    });
    test('double', () {
      expect(1.5.minutes, Duration(minutes: 1, seconds: 30));
      expect(0.5.seconds, Duration(milliseconds: 500));
      expect(
          500.5.milliseconds, Duration(milliseconds: 500, microseconds: 500));
    });
  });
}
