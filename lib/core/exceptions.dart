class HandledHttpException implements Exception {
  HandledHttpException(this.errorCode, this.errorBody);

  int errorCode;
  Object errorBody;
}

class ConnectionException implements Exception {
  ConnectionException();

  final String message =
      'No Internet connection. Make sure Wifi or Cellular Data is turned on, then try again.';

  @override
  String toString() => "FormatException: $message";
}

class ManuallyException implements Exception {
  ManuallyException(this.message, {this.code});

  final int? code;
  final String message;

  @override
  String toString() => "FormatException: $message";
}

class TokenExpiredException implements Exception {
  TokenExpiredException();
}

class HaveNoPermissionException implements Exception {
  HaveNoPermissionException();
}
