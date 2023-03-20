import 'package:dio/dio.dart';
import 'package:hpcompose/core/exceptions.dart';
import 'package:hpcompose/data/datasource/remote/rest_api_factory.dart';
import 'package:hpcompose/data/datasource/remote/token_expired_handler.dart';

class HttpHandler implements RestApiFactoryListener {
  final TokenExpiredHandler _tokenExpiredHandler;

  const HttpHandler(this._tokenExpiredHandler);

  @override
  void onResponse(Response response) {}

  @override
  void onError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.receiveTimeout:
        throw ManuallyException('Server not response, please try again.');
      case DioErrorType.cancel:
        throw ManuallyException('The request is cancelled');
      case DioErrorType.badResponse:
        final statusCode = error.response!.statusCode;
        if (statusCode == 401 || statusCode == 416) {
          _tokenExpiredHandler.call(statusCode == 401
              ? TokenType.tokenExpired
              : TokenType.anotherDevice);
          throw TokenExpiredException();
        }
        if (statusCode == 403) {
          throw ManuallyException("You don't have permission to access this.");
        }
        throw ManuallyException('Oops! Error occurred, please try again.');
      case DioErrorType.unknown:
      default:
        throw ManuallyException('Oops! Error occurred, please try again.');
    }
  }

  // Future<T> call<T>(Future<Response<T>> requestFuture) async {
  //   Response<T> response = await requestFuture.timeout(
  //     const Duration(seconds: 30),
  //     onTimeout: () {
  //
  //     },
  //   );
  // }
  //
  // T _handlerResponse<T>(Response<T> response) {
  //   if(response.statusCode == 401 || response.statusCode == 416) {
  //     _tokenExpiredHandler.call(response.statusCode == 401
  //         ? TokenType.tokenExpired
  //         : TokenType.anotherDevice);
  //   }
  //   if(response.statusCode == 403) {
  //
  //   }
  // }
}
