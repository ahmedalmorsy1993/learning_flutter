import 'package:dio/dio.dart';
import 'package:first_app/core/network/app_exception.dart';
import 'package:first_app/core/ui/app_messenger.dart';

/// Shows a SnackBar for every request, so screens don't have to:
/// - errors: always, unless the request is `silent`
/// - success: only for requests that pass a `successMessage`
///   (or when the server returns a `message` field on a non-GET request)
class MessageInterceptor extends Interceptor {
  static const silent = 'silent';
  static const successMessage = 'successMessage';

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final options = response.requestOptions;
    if (options.extra[silent] != true) {
      final serverMessage = options.method != 'GET'
          ? _messageFrom(response.data)
          : null;
      final message = options.extra[successMessage] ?? serverMessage;
      if (message is String) AppMessenger.success(message);
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.requestOptions.extra[silent] != true) {
      AppMessenger.error(
        _messageFrom(err.response?.data) ?? AppException.fromDio(err).message,
      );
    }
    handler.next(err);
  }

  static String? _messageFrom(Object? data) =>
      data is Map && data['message'] is String ? data['message'] : null;
}
