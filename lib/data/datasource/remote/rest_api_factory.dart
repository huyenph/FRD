import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/src/adapters/io_adapter.dart';
import 'package:flutter/services.dart';
import 'package:upm/configs/app_configs.dart';
import 'package:upm/data/datasource/local/shared_preferences_manager.dart';
import 'package:upm/modules/auth/data/auth_service.dart';

abstract class RestApiFactoryListener {
  void onResponse(Response response);

  void onError(DioError error);
}

class RestApiFactory {
  static const int timeOut = 5000;
  static Dio? _dio;

  final SharedPreferencesManager _prefsManager;
  final RestApiFactoryListener _listener;

  const RestApiFactory(this._prefsManager, this._listener);

  Dio _createDioClient() {
    if (_dio == null) {
      _dio = Dio();
      _dio!
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (
              RequestOptions options,
              RequestInterceptorHandler handler,
            ) async {
              return await requestInterceptor(options);
            },
            onResponse: (
              Response response,
              ResponseInterceptorHandler handler,
            ) async {
              return _listener.onResponse(response);
            },
            onError: (
              DioError error,
              ErrorInterceptorHandler handler,
            ) async {
              return _listener.onError(error);
            },
          ),
        )
        ..interceptors.add(LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
        ));
      if (AppConfig.instance!.flavor == Flavor.prod ||
          AppConfig.instance!.flavor == Flavor.stag) {
        (_dio!.httpClientAdapter as DefaultHttpClientAdapter)
            .onHttpClientCreate = _createHttpClient() as OnHttpClientCreate?;
      }
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

  dynamic requestInterceptor(RequestOptions options) async {
    final token = await _prefsManager.token;
    Map<String, String> headers;
    if (token.isNotEmpty) {
      headers = {
        'Content-type': 'Authorization/json',
        'Authorization': 'Bearer $token',
        'Accept': '*/*',
      };
    } else {
      headers = {
        'Content-type': 'Authorization/json',
        'Accept': '*/*',
      };
    }

    options.baseUrl = AppConfig.instance!.rootUrl;
    options.headers.addAll(headers);
    options.connectTimeout = timeOut as Duration?;
    options.receiveTimeout = timeOut as Duration?;
    return options;
  }

  AuthService provideAuthService() => AuthService(_createDioClient());
}
