import 'dart:async';
import 'package:rusted/rusted.dart';

class FakeResponse {
  const FakeResponse(this.statusCode, this.body);
  final int statusCode;
  final String body;

  @override
  String toString() => 'FakeResponse($statusCode, $body)';
}

void main() async {
  var data = await fetchData();
  //  .fold() exposes the possible values
  var output = data.fold((data) {
    return data;
  }, (error) {
    return 'error: $error';
  });
  print(output);
}

Future<Result<FakeResponse, Exception>> fetchData() async {
  // .of() or .ofAsync() is an easy way to create a result.
  return Result.ofAsync(() async {
    await Future.delayed(1.seconds);
    var response = FakeResponse(200, 'Success');
    return response;
  });
}

// -------------------------------------------------------------
//    The above code is functionally the same as the one below
// -------------------------------------------------------------

Future<Result<FakeResponse, Exception>> fetchData2() async {
  try {
    await Future.delayed(2.seconds);
    var response = FakeResponse(200, 'Success');
    return Ok(response);
  } on Exception catch (e) {
    return Err(e);
  }
}
