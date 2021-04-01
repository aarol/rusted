# Rusted
### Rust-inspired Result class in Dart
### + Utilities for easier devopment

## Usage

A simple usage example:

```dart
import 'package:rusted/rusted.dart';

void main() {
  var result = Ok('hi');
  result.fold(
    (ok) => print(ok),
    (err) => print(err),
  );
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
