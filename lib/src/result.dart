import 'dart:async';

/// A Result is an object which can hold two possible values,
/// an `Ok` or an `Err`.
///
/// Example:
/// ```dart
/// Result<String, Exception> getData() {
///   return Ok('value');
/// }
/// void main() {
///   final result = getData();
///   result.fold(
///     (ok) => print(ok),
///     (err) => print(err),
///   );
/// }
/// ```
///
/// Example 2: using Result inside of a Cubit
/// ```dart
/// class MyCubit extends Cubit<MyState> {
///  MyCubit(): super(MyInitialState());
///
///   void login(String username, String password) async {
///     final result = await myRepository.login(username, password);
///     result.fold(
///       (ok) => emit(MyLoggedInState(ok));
///       (err) => emit(MyFailedLoginState(err));
///     );
///   }
/// }
/// ```
abstract class Result<O, E> {
  const Result();

  /// Creates a Result from a synchronous callback
  /// Can be used to simplify the creation of a result
  /// when the error type is known.
  ///
  /// Catches only the error defined by the type.
  /// The type of `Err` cannot be null.
  /// Setting `Err` type to `dynamic` catches all errors.
  factory Result.ofSync(O Function() function) {
    assert(E != Null);
    try {
      final result = function();
      return Ok(result);
      // ignore: nullable_type_in_catch_clause
    } on E catch (e) {
      return Err(e);
    }
  }

  /// Creates a Result from an asynchronous callback
  /// Can be used to simplify the creation of a result
  /// when the error type is known.
  ///
  /// Catches only the error defined by the type.
  /// The type of `Err` cannot be null.
  /// Setting `Err` type to `dynamic` catches all errors.
  static Future<Result<O, E>> of<O, E>(FutureOr<O> Function() function) async {
    assert(E != Null);
    try {
      final result = await function();
      return Ok(result);
      // ignore: nullable_type_in_catch_clause
    } on E catch (e) {
      return Err(e);
    }
  }

  /// Breaks the result into `Ok` or `Err`.
  ///
  /// The values are exposed in the callback parameter.
  ///
  /// Returns a single value from both of the callbacks.
  ///
  /// Example:
  /// ```dart
  /// final result = ok<String, Exception>('hi');
  ///
  /// result.fold(
  ///   (ok) => print(ok),
  ///   (err) => print(err),
  /// );
  /// ```
  B fold<B>(B Function(O ok) ok, B Function(E err) err);

  /// Unwrap the result to get the `Ok` value.
  ///
  /// Should be used cautiously, as unwrapping an error will throw `reason`.
  O unwrap([reason]);

  /// Returns the `Ok` value as nullable.
  O? ok();

  /// Returns the `Err` value as nullable.
  E? err();

  /// Take the current `Result` and transform it's values to a new `Result`.
  ///
  /// Example:
  /// ```dart
  ///   final result = ok<String, Exception>('hi');
  ///
  ///   Result<int, Error> newResult = result.map(
  ///     ok: (ok) => 1,
  ///     err: (err) => Error(),
  ///   );
  /// ```
  Result<A, B> map<A, B>({A Function(O ok)? ok, B Function(E err)? err});

  /// returns whether the result is `Ok` without exposing the value.
  bool get isOk;

  /// returns whether the result is `Err` without exposing the value.
  bool get isErr;

  @override
  String toString() => fold((ok) => 'Ok($ok)', (err) => 'Err($err)');
}

/// Creates the `Ok` value of a `Result`
///
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
  O? ok() => val;

  @override
  E? err() => null;

  @override
  bool get isOk => true;

  @override
  bool get isErr => false;

  @override
  Result<A, B> map<A, B>({A Function(O ok)? ok, B Function(E err)? err}) {
    if (ok != null) {
      return Ok(ok(val));
    } else {
      return Ok(val as A);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Ok && runtimeType == other.runtimeType && val == other.val;

  @override
  int get hashCode => val.hashCode;
}

/// Creates the `Ok` value of a `Result`
///
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
  O? ok() => null;

  @override
  E? err() => val;

  @override
  Result<A, B> map<A, B>({A Function(O ok)? ok, B Function(E err)? err}) {
    if (err != null) {
      return Err(err(val));
    } else {
      return Err(val as B);
    }
  }

  @override
  bool get isOk => false;

  @override
  bool get isErr => true;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Err && runtimeType == other.runtimeType && val == other.val;

  @override
  int get hashCode => val.hashCode;
}

/// Use when you need to return a type of `Result`,
/// but can't specify the return type.
Result<O, E> ok<O, E>(O val) => Ok(val);

/// Use when you need to return a type of `Result`,
/// but can't specify the return type.
Result<O, E> err<O, E>(E val) => Err(val);
