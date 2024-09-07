class AppException implements Exception {
  final String message;
  final String? prefix;
  final Exception? originalException;

  AppException(this.message, {this.prefix, this.originalException});

  @override
  String toString() {
    return '${prefix ?? "Error"}: $message';
  }
}

class ServerException extends AppException {
  ServerException([String? message])
      : super(message ?? "Server Error", prefix: "Server Error");
}

class UnexpectedException extends AppException {
  UnexpectedException([String? message])
      : super(message ?? "Unexpected Error Occurred",
            prefix: "Unexpected Error");
}
