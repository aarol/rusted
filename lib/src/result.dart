Result<String, Exception> eval() {
  return Err(Exception('the message'));
  // return Ok('hello');
}

abstract class Result<O, E> {
  const Result();
  B fold<B>(B Function(O ok) ok, B Function(E err) err);

  O unwrap([reason]);

  B? whenOk<B>(B Function(O ok) callback);
  B? whenErr<B>(B Function(E err) callback);

  factory Result.from(O Function() function) {
    try {
      final result = function();
      return Ok(result);
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
