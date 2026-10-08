import 'package:dio/dio.dart';

/// Shared client: `http.get('/posts')`.
final http = Http._();

class Http with DioMixin implements Dio {
  Http._() {
    options = BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com');
    httpClientAdapter = HttpClientAdapter();
  }
}
