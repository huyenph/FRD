library app_bloc;

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:upm/domain/models/language_model.dart';
import 'package:upm/domain/usecases/app_usecase.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(this._appUseCase) : super(OnInitialState()) {
    on<OnAppConfigEvent>(_onAppConfigEvent);
    on<OnGetLanguageEvent>(_onGetLanguageEvent);
  }

  final AppUseCase _appUseCase;

  void _onAppConfigEvent(
    OnAppConfigEvent event,
    Emitter<AppState> emitter,
  ) async {
    switch (event.type) {
      case AppConfigType.all:
        await _appUseCase.updateAppConfig(AppConfigType.all);
        return emitter(const OnAppConfigChangeState.all());

      case AppConfigType.theme:
        _appUseCase.updateAppConfig(
          AppConfigType.theme,
          theme: event.theme,
        );
        return emitter(const OnAppConfigChangeState.theme());
      case AppConfigType.locale:
        _appUseCase.updateAppConfig(
          AppConfigType.locale,
          language: event.language,
        );
        return emitter(const OnAppConfigChangeState.locale());
    }
  }

  void _onGetLanguageEvent(
    OnGetLanguageEvent event,
    Emitter<AppState> emitter,
  ) async {
    final data = await rootBundle.loadString('assets/json/languages.json');
    final languages = jsonDecode(data);
    return emitter(OnGetLanguageState(languages));
  }
}
