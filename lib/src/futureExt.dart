import 'dart:async';

import '../rusted.dart';

extension ResultExt<O, E> on Future<Result<O, E>> {
  Future<B> foldAsync<B>(B Function(O ok) ok, B Function(E err) err) async {
    final result = await this;
    return result.fold((okay) => ok(okay), (error) => err(error));
  }
}
