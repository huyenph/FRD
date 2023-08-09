import 'package:frd/domain/models/bad_response_model.dart';

class HandledHttpException implements Exception {
  HandledHttpException(this.errorCode, this.errorMessage);

  final int errorCode;
  final String errorMessage;
}

class ConnectionException implements Exception {
  ConnectionException();

  final String message =
      'No Internet connection. Make sure Wifi or Cellular Data is turned on, then try again.';

  @override
  String toString() => "FormatException: $message";
}

class ManuallyException implements Exception {
  ManuallyException({this.message, this.data});

  final String? message;
  final BadResponseModel? data;

  @override
  String toString() => "FormatException: $message";
}

class UnauthorizedException implements Exception {
  UnauthorizedException(this.data);

  final BadResponseModel data;
}

class ForbiddenException implements Exception {
  ForbiddenException(this.statusCode, this.message);

  final int statusCode;
  final String message;
}

class HaveNoPermissionException implements Exception {
  HaveNoPermissionException();
}
