abstract class Either<L, R> {
  const Either();
  B fold<B>(B Function(L l) left, B Function(R r) right);
}

class Left<L, R> extends Either<L, R> {
  const Left(this.val);
  final L val;

  @override
  B fold<B>(B Function(L l) left, B Function(R r) right) => left(val);
}

class Right<L, R> extends Either<L, R> {
  Right(this.val);
  final R val;

  @override
  B fold<B>(B Function(L l) left, B Function(R r) right) => right(val);
}

Either<L, R> left<L, R>(L val) => Left(val);
Either<L, R> right<L, R>(R val) => Right(val);
