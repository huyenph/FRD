library app_bloc;

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:frd/data/datasource/local/entities/language_entity.dart';
import 'package:frd/domain/usecases/app_usecase.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(this._appUseCase) : super(OnInitialState()) {
    on<OnAppConfigChangeRequested>(_onAppConfigChangeRequested);
    on<OnGetLanguageRequested>(_onGetLanguageRequested);
  }

  final AppUseCase _appUseCase;

  void _onAppConfigChangeRequested(
    OnAppConfigChangeRequested event,
    Emitter<AppState> emit,
  ) async {
    switch (event.type) {
      case AppConfigType.all:
        await _appUseCase.updateAppConfig(AppConfigType.all);
        return emit(const OnAppConfigChangeState.all());

      case AppConfigType.theme:
        _appUseCase.updateAppConfig(
          AppConfigType.theme,
          theme: event.theme,
        );
        return emit(const OnAppConfigChangeState.theme());
      case AppConfigType.locale:
        _appUseCase.updateAppConfig(
          AppConfigType.locale,
          language: event.language,
        );
        return emit(const OnAppConfigChangeState.locale());
    }
  }

  void _onGetLanguageRequested(
    OnGetLanguageRequested event,
    Emitter<AppState> emit,
  ) async {
    final data = await rootBundle.loadString('assets/json/languages.json');
    final languages = jsonDecode(data);
    return emit(OnGetLanguageState(languages));
  }
}
