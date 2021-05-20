# Rusted
* Rust-inspired Result class in Dart with 2 options: `Ok` or `Err` with intuitive methods for asynchronous programming.
* Extensions for duration

# Usage

## Result

A simple usage example:

```dart
import 'package:rusted/rusted.dart';
import 'package:http/http.dart';

void main() {
  Result<String, Exception> result = Ok('hi');
  result.fold(
    (ok) => print(ok),
    (err) => print(err),
  );
}
```
### Example of usage with Cubit
```dart
class MyCubit extends Cubit<MyState> {
  MyCubit(this.myRepo) : super(MyInitialState());

  final MyRepository myRepo;

  void login() async {
    final result = await myRepo.login();
    result.fold(
      (ok) => emit(MyLoggedInState(ok)),
      (err) => emit(MyFailedLoginState(err)),
    );
  }
}

class MyRepository {
  Future<Result<String, http.ClientException>> login() {
    return Result.of(() async {
      var res = http.get(URL);
      return res.body['username'];
    });
  }
}
```

## Time
```dart
Duration(seconds: 5) == 5.seconds; //true

Duration(milliseconds: 250) == 250.milliseconds; // true

Duration(minutes: 1, seconds: 30) == 1.5.minutes; // true
```
Currently autocomplete and import doesn't work on extension methods, but typing the respective classes (`IntTime` or `DoubleTime`) will import it.

# Motive
Since Dart doesn't provide a class similiar to Rust's Result,
this package was made to fill that purpose.

A result is especially useful in situations where catching errors isn't desirable, such as in the `mapEventToState` function of a Bloc, when it is much better to handle errors in the repository, making refactoring of the Bloc easier.

With `Result` it is easier to deliver errors to the UI while forcing you to handle them.

[Dartz][dartz] is a great functional programming package which uses an [Either][either] class. Unfortunately it is not documented at all and can be a bit confusing.

---

## Todo

* When [Type aliases][typealias] land in Dart, create aliases for common types, for example

  `typedef ResultEx<T> = Result<T, Exception>`

---
## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[either]: https://github.com/spebbe/dartz/blob/master/lib/src/either.dart
[dartz]: https://pub.dev/packages/dartz
[tracker]: https://github.com/aarol/rusted/issues
[typealias]: https://github.com/dart-lang/language/issues/65
