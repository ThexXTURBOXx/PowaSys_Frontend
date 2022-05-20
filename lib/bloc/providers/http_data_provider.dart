import 'package:http/http.dart';

class HttpDataProvider {
  static final Client _client = Client();

  Future<String> getBody(Uri uri, {Map<String, String>? headers}) async =>
      (await get(uri, headers: headers)).body;

  Future<Response> get(Uri uri, {Map<String, String>? headers}) async =>
      _client.get(uri, headers: headers);
}
