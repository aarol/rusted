import 'either.dart';

abstract class Result<O, E> {
  const Result();
  B fold<B>(B Function(O ok) ok, B Function(E err) err);

  O unwrap([reason]);

  B? whenOk<B>(B Function(O ok) callback);
  B? whenErr<B>(B Function(E err) callback);

  Either<L, R> toEither<L, R>({L Function(O ok)? ok, R Function(E err)? err});

  factory Result.from(O Function() function) {
    try {
      final result = function();
      return Ok(result);
      // ignore: nullable_type_in_catch_clause
    } on E catch (e) {
      return Err(e);
    }
  }

  bool get isOk;
  bool get isErr;
}

class Ok<O, E> extends Result<O, E> {
  const Ok(this.val);
  final O val;

  @override
  B fold<B>(B Function(O ok) isOk, B Function(E err) isErr) => isOk(val);

  @override
  O unwrap([_]) => val;

  @override
  B? whenOk<B>(B Function(O ok) callback) => callback(val);

  @override
  B? whenErr<B>(B Function(E err) callback) => null;

  @override
  Either<L, R> toEither<L, R>({L Function(O ok)? ok, R Function(E err)? err}) {
    if (ok == null) return left(val as L);
    return left(ok(val));
  }

  @override
  bool operator ==(other) => other is Ok && other.val == val;

  @override
  bool get isOk => true;

  @override
  bool get isErr => false;

  @override
  String toString() => 'Ok($val)';
}

class Err<O, E> extends Result<O, E> {
  final E val;
  const Err(this.val);

  @override
  B fold<B>(B Function(O ok) isOk, B Function(E err) isErr) => isErr(val);

  @override
  O unwrap([reason]) => throw reason;

  @override
  B? whenOk<B>(B Function(O ok) callback) => null;

  @override
  B? whenErr<B>(B Function(E err) callback) => callback(val);

  @override
  Either<L, R> toEither<L, R>({L Function(O ok)? ok, R Function(E err)? err}) {
    if (err == null) return right(val as R);
    return right(err(val));
  }

  @override
  bool operator ==(other) => other is Err && other.val == val;

  @override
  bool get isOk => false;

  @override
  bool get isErr => true;

  @override
  String toString() => 'Err($val)';
}

Result<O, E> ok<O, E>(O val) => Ok(val);
Result<O, E> err<O, E>(E val) => Err(val);
