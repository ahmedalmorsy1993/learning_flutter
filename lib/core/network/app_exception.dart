import 'package:dio/dio.dart';

/// Every error the data layer throws. The UI only ever sees these,
/// never Dio types, so swapping Dio out later doesn't touch any screen.
///
/// `sealed` means the compiler knows every subtype, so a `switch` over
/// an [AppException] must handle all of them.
sealed class AppException implements Exception {
  const AppException(this.message);

  /// Text that is safe to show to the user.
  final String message;

  factory AppException.fromDio(DioException e) => switch (e.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout => const RequestTimeoutException(),
    DioExceptionType.connectionError => const NetworkException(),
    DioExceptionType.badResponse => ServerException(e.response?.statusCode),
    DioExceptionType.cancel => const CancelledException(),
    _ => UnknownException(e.message ?? 'Something went wrong.'),
  };

  @override
  String toString() => '$runtimeType: $message';
}

final class NetworkException extends AppException {
  const NetworkException()
    : super('No internet connection. Check your network and try again.');
}

final class RequestTimeoutException extends AppException {
  const RequestTimeoutException()
    : super('The server took too long to respond. Try again.');
}

final class ServerException extends AppException {
  ServerException(this.statusCode)
    : super('The server returned an error (${statusCode ?? 'unknown'}).');

  final int? statusCode;
}

final class CancelledException extends AppException {
  const CancelledException() : super('The request was cancelled.');
}

final class UnknownException extends AppException {
  const UnknownException(super.message);
}
