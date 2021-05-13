import 'dart:async';

import 'package:rusted/rusted.dart';
import 'package:test/test.dart';

void main() {
  final tOk = 'testOk';
  final tErr = 'testErr';

  group('Future', () {
    Future<Result<String, String>> futureOk() async {
      return ok(tOk);
    }

    Future<Result<String, String>> futureErr() async {
      return err(tErr);
    }

    test('should return value when ok', () async {
      final result = await futureOk().thenFold((ok) => ok, (err) => err);
      expect(result, tOk);
    });

    test('should return value when err', () async {
      final result = await futureErr().thenFold((ok) => ok, (err) => err);
      expect(result, tErr);
    });
  });

  group('FutureOr', () {
    FutureOr<Result<String, String>> futureOrOk() async {
      return ok(tOk);
    }

    FutureOr<Result<String, String>> futureOrErr() async {
      return err(tErr);
    }

    test('should return value when ok', () async {
      final result = await futureOrOk().thenFold((ok) => ok, (err) => err);
      expect(result, tOk);
    });

    test('should return value when err', () async {
      final result = await futureOrErr().thenFold((ok) => ok, (err) => err);
      expect(result, tErr);
    });
  });
}
