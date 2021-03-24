abstract class Result<O, E> {
  const Result();
  B fold<B>(B Function(O ok) ok, B Function(E err) err);

  O unwrap([reason]);

  B? whenOk<B>(B Function(O ok) callback);
  B? whenErr<B>(B Function(E err) callback);

  Result<B, E> map<B>(Result<B, E> Function(O ok) ok);

  factory Result.of(O Function() function) {
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

  @override
  String toString() => fold((ok) => 'Ok($ok)', (err) => 'Err($err)');
}

/// See also:
/// * `ok(..)` for returing a `Result` when you can't return `Ok` itself.
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
  Result<B, E> map<B>(Result<B, E> Function(O ok) ok) {
    return ok(val);
  }

  @override
  bool operator ==(other) => other is Ok && other.val == val;

  @override
  bool get isOk => true;

  @override
  bool get isErr => false;
}

/// See also:
/// * `err(..)` for returing a `Result` when you can't return `Err` itself.
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
  Result<B, E> map<B>(Result<B, E> Function(O ok) ok) => Err(val);

  @override
  bool operator ==(other) => other is Err && other.val == val;

  @override
  bool get isOk => false;

  @override
  bool get isErr => true;
}

/// Use when you need to return a type of `Result`,
/// but can't specify the return type.
Result<O, E> ok<O, E>(O val) => Ok(val);

/// Use when you need to return a type of `Result`,
/// but can't specify the return type.
Result<O, E> err<O, E>(E val) => Err(val);
