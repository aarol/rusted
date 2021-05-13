# Rusted
* Rust-inspired Result class in Dart with 2 options: `Ok` or `Err` with intuitive methods for asynchronous programming.
* Extensions for duration

# Usage

## Result

A simple usage example:

```dart
import 'package:rusted/rusted.dart';

void main() {
  Result<String, Exception> result = Ok('hi');
  result.fold(
    (ok) => print(ok),
    (err) => print(err),
  );
}
```

## Time
```dart
await Future.delayed(1.5.minutes);

await Future.delayed(5.seconds);

await Future.delayed(250.milliseconds);
```

# Motive
Since Dart doesn't provide a class similiar to Rust's Result,
this package was made to fill that purpose.

A result is especially useful in situations where catching errors isn't desirable, such as in the `mapEventToState` function of a Bloc, when it is much better to handle errors in the repository, making refactoring of the Bloc easier.

[Dartz][dartz] is a great functional programming package which uses an [Either][either] class. Unfortunately it is not documented at all and can be a bit overwhelming.

---
## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[either]: https://github.com/spebbe/dartz/blob/master/lib/src/either.dart
[dartz]: https://pub.dev/packages/dartz
[tracker]: https://github.com/aarol/rusted/issues
