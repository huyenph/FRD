import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:frd/configs/flavor_config.dart';
import 'package:frd/core/exceptions.dart';
import 'package:frd/core/extensions.dart';
import 'package:frd/domain/models/bad_response_model.dart';

class RestApiFactory {
  static const int timeOut = 5000;
  static Dio? _dio;

  Dio createDioClient() {
    if (_dio == null) {
      _dio = Dio(
        BaseOptions(
          baseUrl: FlavorConfig.instance!.rootUrl,
        ),
      );
      _dio!
        ..interceptors.add(ApiInterceptors())
        ..interceptors.add(LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
        ));
      // if (FlavorConfig.instance!.flavor == Flavor.prod ||
      //     FlavorConfig.instance!.flavor == Flavor.stag) {
      //   (_dio!.httpClientAdapter as IOHttpClientAdapter)
      //       .onHttpClientCreate = _createHttpClient() as OnHttpClientCreate?;
      // }
    }
    return _dio!;
  }

  Future<HttpClient?> _createHttpClient() async {
    var scContext = SecurityContext.defaultContext;
    String data = await rootBundle.loadString("assets/cert.crt");
    List bytes = utf8.encode(data);
    scContext.setTrustedCertificatesBytes(bytes as List<int>);
    return HttpClient(context: scContext);
  }
}

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // final token = Boxes.getUserSession()?.idToken;
    // if (token != null && token.isNotEmpty) {
    //   options.headers = <String, dynamic>{
    //     'Authorization': 'Bearer $token',
    //   };
    // }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.isNoConnectionError) {
      throw ConnectionException();
    }
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        throw ManuallyException(
            message: 'Server not response, please try again.');
      case DioExceptionType.cancel:
        throw ManuallyException(message: 'The request is cancelled');
      case DioExceptionType.badResponse:
        final statusCode = err.response!.statusCode;
        if (statusCode == 401) {
          throw UnauthorizedException(
            err.response?.data != null
                ? BadResponseModel.fromJson(err.response?.data)
                : BadResponseModel(
                    statusCode: 401,
                    success: false,
                    errorMessage: 'Invalid credentials!',
                  ),
          );
        }
        if (statusCode == 403) {
          throw ForbiddenException(
            403,
            "You don't have permission to access this.",
          );
        }
        throw ManuallyException(
          data: err.response?.data != null
              ? BadResponseModel.fromJson(err.response?.data)
              : BadResponseModel(
                  statusCode: 500,
                  success: false,
                  errorMessage: 'Oops! Error occurred, please try again.',
                ),
        );
      case DioExceptionType.unknown:
      default:
        throw ManuallyException(
          message: 'Oops! Error occurred, please try again.',
        );
    }
  }
}
