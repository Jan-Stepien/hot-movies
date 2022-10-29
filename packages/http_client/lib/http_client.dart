library movie_client;

import 'package:http/http.dart' as http;

/// The [HttpClient] is a wrapper around the [http] package.
class HttpClient {
  /// [get] returns a [http.Response] from the [uri].
  Future<http.Response> get(Uri uri) async {
    return await http.get(uri);
  }
}
