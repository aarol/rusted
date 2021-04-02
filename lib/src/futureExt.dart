import 'dart:async';

import '../rusted.dart';

extension FutureResultExt<O, E> on Future<Result<O, E>> {
  Future<B> foldAsync<B>(B Function(O ok) ok, B Function(E err) err) async {
    final result = await this;
    return result.fold((value) => ok(value), (error) => err(error));
  }
}

extension FutureOrResultExt<O, E> on FutureOr<Result<O, E>> {
  Future<B> foldAsync<B>(B Function(O ok) ok, B Function(E err) err) async {
    final result = await this;
    return result.fold((value) => ok(value), (error) => err(error));
  }
}
