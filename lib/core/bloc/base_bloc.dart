import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frd/core/exceptions.dart';
import 'package:frd/domain/models/base_response_model.dart';
import 'package:rxdart/subjects.dart';

enum SuccessType { changePassword, sendVerificationLink, changeAvatar }

abstract class RestApiListener {
  void onSuccess(SuccessType type);
  void onError(Exception e);
}

abstract class BaseBloc<E, S> extends Bloc<E, S> {
  BaseBloc(this._listener, this.initialState) : super(initialState);

  final RestApiListener _listener;

  final S initialState;

  final BehaviorSubject<bool> _loadingSubject = BehaviorSubject();

  Stream<bool> get loadingStream => _loadingSubject.stream.distinct();

  @protected
  Future<BaseResponseModel> call(
    Future<dynamic> requestFuture,
  ) async {
    try {
      final data = await requestFuture;
      return BaseResponseModel(success: true, data: data);
    } on Exception catch (e) {
      _listener.onError(e);
      String? message = '';
      if (e is DioException) {
        final dioError = e.error;
        if (dioError is UnauthorizedException) {
          message = dioError.data.errorMessage;
        }
      }
      return BaseResponseModel(
        success: false,
        message: message,
      );
    }
  }

  Future<void> onRefresh() async {}
}
