import 'package:rusted/rusted.dart';

class FakeResponse {
  FakeResponse(this.statusCode, this.body);
  final int statusCode;
  final String body;
}

void main() async {
  var data = await transformData();

  //  .fold() exposes the possible values
  data.fold((data) {
    //Display data
    print(data);
  }, (statusCode) {
    //Display something about the error
    print(statusCode);
  });
}

Future<Either<String, int>> transformData() async {
  var data = await fetchData();
  return data.toEither(
    ok: (response) => response.body,
    err: (err) => 404,
  );
}

Future<Result<FakeResponse, Exception>> fetchData() async {
  await Future.delayed(2.seconds);
  return Result<FakeResponse, Exception>.from(() {
    var response = FakeResponse(200, 'Success');
    return response;
  });
}
