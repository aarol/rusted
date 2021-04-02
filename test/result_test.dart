import 'dart:async';

import 'package:test/test.dart';

import 'package:rusted/rusted.dart';

void main() {
  final tOk = 'testOk';
  final tErr = 'testErr';

  Result<String, String> getOk() {
    return ok(tOk);
  }

  Result<String, String> getErr() {
    return err(tErr);
  }

  dynamic foldResult(Result result) {
    return result.fold((ok) => ok, (err) => err);
  }

  group('fold', () {
    test('should return ok when gets an ok', () {
      final result = getOk();
      final value = foldResult(result);

      expect(value, tOk);
    });
    test('should return err when gets an err', () {
      final result = getErr();
      final value = foldResult(result);

      expect(value, tErr);
    });
  });

  group('isOk', () {
    test('should return true when ok', () {
      final result = getOk();
      expect(result.isOk, true);
    });

    test('should return false when err', () {
      final result = getErr();
      expect(result.isOk, false);
    });
  });

  group('isErr', () {
    test('should return true when err', () {
      final result = getErr();
      expect(result.isErr, true);
    });

    test('should return false when ok', () {
      final result = getErr();
      expect(result.isOk, false);
    });
  });

  group('whenOk', () {
    test('should return value when is ok', () {
      final result = getOk();
      final value = result.whenOk((ok) => ok);
      expect(value != null, true);
    });

    test('should return null when is err', () {
      final result = getErr();
      final value = result.whenOk((ok) => ok);
      expect(value != null, false);
    });
  });
  group('whenErr', () {
    test('should return value when is err', () {
      final result = getErr();
      final value = result.whenErr((err) => err);
      expect(value != null, true);
    });

    test('should return null when is ok', () {
      final result = getOk();
      final value = result.whenErr((err) => err);
      expect(value != null, false);
    });
  });

  group('of', () {
    test('should return ok when is ok', () {
      final result = Result.of(() {
        return tOk;
      });
      expect(result.isOk, true);
    });

    test('should return err when is err', () {
      final result = Result.of(() {
        throw Exception();
      });
      expect(result.isOk, false);
    });

    test('should only catch defined type', () {
      Result<String, Exception> result() {
        return Result<String, Exception>.of(() => [][1]);
      }

      expect(() => result(), throwsA(isRangeError));
    });

    test('should throw when error type is Null', () {
      Result<String, Null> result() {
        return Result<String, Null>.of(() => tOk);
      }

      expect(() => result(), throwsA(isA<AssertionError>()));
    });
  });

  group('ofAsync', () {
    test('should return ok when is ok', () async {
      final result = await Result.ofAsync(() {
        return tOk;
      });
      expect(result.isOk, true);
    });

    test('should return err when is err', () async {
      final result = await Result.ofAsync(() {
        throw Exception();
      });
      expect(result.isOk, false);
    });

    test('should only catch defined type', () {
      FutureOr<Result<String, Exception>> result() {
        return Result.ofAsync(() => [][1]);
      }

      expect(() => result(), throwsA(isRangeError));
    });

    test('should throw when error type is Null', () {
      FutureOr<Result<String, Null>> result() {
        return Result.ofAsync(() => tOk);
      }

      expect(() => result(), throwsA(isA<AssertionError>()));
    });
  });

  group('unwrap', () {
    final tReason = 'testReason';
    test('should return value when is ok', () {
      final result = getOk();
      final value = result.unwrap();
      expect(value, tOk);
    });
    test('should throw reason when is err', () {
      final result = getErr();
      final call = result.unwrap;
      expect(() => call(tReason), throwsA(isA<String>()));
    });
  });

  group('map', () {
    test('', () {
      final result = getErr();
      var value = result.map(
        ok: (ok) => 1,
      );
      print(value);
    });
  });
}
