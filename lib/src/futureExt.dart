import 'dart:async';

import '../rusted.dart';

extension FutureResultExt<O, E> on Future<Result<O, E>> {
  /// used to fold a `Result` from a `Future`.
  ///
  /// It is the same as `.then()` except it folds the returned value.
  ///
  /// Example:
  /// ```dart
  ///Future<Result<String, Error>> getData() async {
  ///   await Future.delayed(500.milliseconds);
  ///   return Ok('hi');
  ///}
  ///getData().foldAsync(
  ///   (ok) => print(ok),
  ///   (err) => print(err),
  ///);
  /// ```
  Future<B> thenFold<B>(B Function(O ok) ok, B Function(E err) err) async {
    final result = await this;
    return result.fold((value) => ok(value), (error) => err(error));
  }
}

extension FutureOrResultExt<O, E> on FutureOr<Result<O, E>> {
  /// used to fold a `Result` from a `Future`.
  ///
  /// It is the same as `.then()` except it folds the returned value.
  ///
  /// Example:
  /// ```dart
  ///FutureOr<Result<String, Error>> getData() async {
  ///   await Future.delayed(500.milliseconds);
  ///   return Ok('hi');
  ///}
  ///getData().foldAsync(
  ///   (ok) => print(ok),
  ///   (err) => print(err),
  ///);
  /// ```
  FutureOr<B> thenFold<B>(B Function(O ok) ok, B Function(E err) err) async {
    final result = await this;
    return result.fold((value) => ok(value), (error) => err(error));
  }
}
