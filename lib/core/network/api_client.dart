import 'package:dio/dio.dart';
import 'package:first_app/core/network/app_exception.dart';
import 'package:first_app/core/network/message_interceptor.dart';
import 'package:flutter/foundation.dart';

/// Thin wrapper around Dio.
///
/// It *has* a Dio instead of *being* a Dio (composition over inheritance):
/// the rest of the app only sees the few methods it needs, and every
/// [DioException] is converted to an [AppException] in one place.
class ApiClient {
  /// [token] is called before every request; when it returns a value it's
  /// sent as `Authorization: Bearer <token>`.
  ApiClient({
    Dio? dio,
    String baseUrl = 'https://jsonplaceholder.typicode.com',
    Future<String?> Function()? token,
  }) : _dio =
           dio ??
           Dio(
             BaseOptions(
               baseUrl: baseUrl,
               connectTimeout: const Duration(seconds: 10),
               receiveTimeout: const Duration(seconds: 10),
             ),
           ) {
    if (token != null) {
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            final value = await token();
            if (value != null) {
              options.headers['Authorization'] = 'Bearer $value';
            }
            handler.next(options);
          },
        ),
      );
    }
    _dio.interceptors.add(MessageInterceptor());
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(logPrint: (line) => debugPrint(line.toString())),
      );
    }
  }

  final Dio _dio;

  /// [silent] hides the error SnackBar (e.g. the screen shows its own
  /// error UI). [successMessage] shows a green SnackBar on success.
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? query,
    bool silent = false,
    String? successMessage,
  }) => _send(
    () => _dio.get<T>(
      path,
      queryParameters: query,
      options: _options(silent, successMessage),
    ),
  );

  Future<T> post<T>(
    String path, {
    Object? body,
    bool silent = false,
    String? successMessage,
  }) => _send(
    () => _dio.post<T>(
      path,
      data: body,
      options: _options(silent, successMessage),
    ),
  );

  Options _options(bool silent, String? successMessage) => Options(
    extra: {
      MessageInterceptor.silent: silent,
      MessageInterceptor.successMessage: ?successMessage,
    },
  );

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
