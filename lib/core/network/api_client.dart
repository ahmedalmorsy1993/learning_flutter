import 'package:dio/dio.dart';
import 'package:first_app/core/network/app_exception.dart';
import 'package:flutter/foundation.dart';

/// Thin wrapper around Dio.
///
/// It *has* a Dio instead of *being* a Dio (composition over inheritance):
/// the rest of the app only sees the few methods it needs, and every
/// [DioException] is converted to an [AppException] in one place.
class ApiClient {
  ApiClient({
    Dio? dio,
    String baseUrl = 'https://jsonplaceholder.typicode.com',
  }) : _dio =
           dio ??
           Dio(
             BaseOptions(
               baseUrl: baseUrl,
               connectTimeout: const Duration(seconds: 10),
               receiveTimeout: const Duration(seconds: 10),
             ),
           ) {
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(logPrint: (line) => debugPrint(line.toString())),
      );
    }
  }

  final Dio _dio;

  Future<T> get<T>(String path, {Map<String, dynamic>? query}) =>
      _send(() => _dio.get<T>(path, queryParameters: query));

  Future<T> post<T>(String path, {Object? body}) =>
      _send(() => _dio.post<T>(path, data: body));

  Future<T> _send<T>(Future<Response<T>> Function() request) async {
    try {
      final data = (await request()).data;
      if (data == null) throw const UnknownException('Empty response.');
      return data;
    } on DioException catch (e) {
      throw AppException.fromDio(e);
    }
  }
}
