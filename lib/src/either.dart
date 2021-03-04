abstract class Either<L, R> {
  const Either();
  B fold<B>(B Function(L l) left, B Function(R r) right);

  bool get isLeft;
  bool get isRight;
}

class Left<L, R> extends Either<L, R> {
  const Left(this.val);
  final L val;

  @override
  B fold<B>(B Function(L l) left, B Function(R r) right) => left(val);

  @override
  bool get isLeft => true;

  @override
  bool get isRight => false;

  @override
  String toString() => 'Left($val)';
}

class Right<L, R> extends Either<L, R> {
  Right(this.val);
  final R val;

  @override
  B fold<B>(B Function(L l) left, B Function(R r) right) => right(val);

  @override
  bool get isLeft => false;

  @override
  bool get isRight => true;

  @override
  String toString() => 'Right($val)';
}

Either<L, R> left<L, R>(L val) => Left(val);
Either<L, R> right<L, R>(R val) => Right(val);
