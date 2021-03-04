import 'package:rusted/rusted.dart';

void main() {
  final res = getResult();

  res.fold((ok) {
    print('ok!');
  }, (err) {
    print('err!');
  });

  var value = res.whenOk((ok) {
    return 'when Ok';
  });
}

Result<String, Exception> getResult() {
  return Result.from(() {
    throw Exception('this exception will be caught');
  });
}
