import 'package:rusted/rusted.dart';

class FakeResponse {
  FakeResponse(this.statusCode, this.body);
  final int statusCode;
  final String body;
}

void main() async {
  var data = await fetchData();

  //  .fold() exposes the possible values
  var output = data.fold((data) {
    return data;
  }, (statusCode) {
    return 'error: $statusCode';
  });

  print(output);
}

Future<Result<FakeResponse, Exception>> fetchData() async {
  await Future.delayed(2.seconds);
  // .from() is an easy way to create a result.
  return Result.of(() {
    var response = FakeResponse(200, 'Success');
    return response;
  });
}

// -------------------------------------------------------------
//    The above code is functionally the same as the one below
// -------------------------------------------------------------

Future<Result<FakeResponse, Exception>> fetchData2() async {
  await Future.delayed(2.seconds);
  try {
    var response = FakeResponse(200, 'Success');
    return Ok(response);
  } on Exception catch (e) {
    return Err(e);
  }
}
