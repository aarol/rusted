import 'package:rusted/rusted.dart';
import 'package:test/test.dart';

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
      var res = Result.from(() {
        return '';
      });
      expect(res.isOk, true);
      var res2 = Result.from(() {
        var list = [1, 2, 3]..removeAt(7);
        return list;
      });
      expect(res2.isErr, true);
    });
  });

  group('either', () {
    test('fold', () {
      var res = left('hi');
      var temp = res.fold((l) {
        return 'left';
      }, (r) {
        return 'right';
      });
      expect(temp, 'left');
    });
  });
  group('time', () {
    test('int', () {
      expect(5.minutes, Duration(minutes: 5));
      expect(5.seconds, Duration(seconds: 5));
    });
    test('double', () {
      expect(1.5.minutes, Duration(minutes: 1, seconds: 30));
      expect(0.5.seconds, Duration(milliseconds: 500));
    });
  });
}
