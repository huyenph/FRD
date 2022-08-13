library app_bloc;

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upm/common/constants.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:upm/domain/models/config_model.dart';
import 'package:upm/domain/models/language_model.dart';
import 'package:upm/domain/usecases/app_usecase.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(this._appUseCase) : super(OnInitialState()) {
    // configModel = ConfigModel(
    //   theme: lightTheme,
    //   language: LanguageModel(
    //     name: 'English',
    //     locale: 'en',
    //     subName: 'English',
    //   ),
    // );
    on<OnAppConfigEvent>(_onAppConfigEvent);
    on<OnGetLanguageEvent>(_onGetLanguageEvent);
  }

  final AppUseCase _appUseCase;
  // late ConfigModel configModel;

  void _onAppConfigEvent(
    OnAppConfigEvent event,
    Emitter<AppState> emitter,
  ) async {
    switch (event.type) {
      case AppConfigType.all:
        await _appUseCase.updateAppConfig(AppConfigType.all);
        break;
      // return emitter(OnAppConfigChangeState.all(configModel));

      case AppConfigType.theme:
        // configModel.theme = event.theme!;
        _appUseCase.updateAppConfig(
          AppConfigType.theme,
          theme: event.theme,
        );
        break;
      // return emitter(OnAppConfigChangeState.theme(ConfigModel(
      //   theme: configModel.theme,
      //   language: configModel.language,
      // )));
      case AppConfigType.locale:
        // configModel.language = event.language!;
        _appUseCase.updateAppConfig(
          AppConfigType.locale,
          language: event.language,
        );
        break;
      // return emitter(OnAppConfigChangeState.locale(ConfigModel(
      //   theme: configModel.theme,
      //   language: configModel.language,
      // )));
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
