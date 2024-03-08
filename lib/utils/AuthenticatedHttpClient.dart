import 'dart:async';
import 'package:http/http.dart' as http;

class AuthenticatedHttpClient extends http.BaseClient {
  final String authToken;
  final http.Client _inner;

  AuthenticatedHttpClient(this.authToken, this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Authorization'] = 'Bearer $authToken';
    return _inner.send(request);
  }
}
