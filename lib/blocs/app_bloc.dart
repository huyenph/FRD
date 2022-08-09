library app_bloc;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upm/configs/theme/app_theme.dart';
import 'package:upm/data/datasource/local/shared_preferences_manager.dart';
import 'package:upm/di/injector_setup.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(OnInitialState()) {
    on<OnAppConfigEvent>(_onAppConfigEvent);
    on<OnThemeChangeEvent>(_onThemeChangeEvent);
    on<OnLanguageChangeEvent>(_onLanguageChangeEvent);
  }

  final SharedPreferencesManager _prefs = injector<SharedPreferencesManager>();
  ThemeData appTheme = AppTheme.light;

  void _onAppConfigEvent(
    OnAppConfigEvent event,
    Emitter<AppState> emitter,
  ) async {
    final theme = await _prefs.theme;
    appTheme = theme;
    return emitter(OnAppConfigState(theme, 'en'));
  }

  void _onThemeChangeEvent(
    OnThemeChangeEvent event,
    Emitter<AppState> emitter,
  ) async {
    await _prefs.setTheme(event.theme);
    final theme = await _prefs.theme;
    appTheme = theme;
    return emitter(OnThemeChangeState(theme));
  }

  void _onLanguageChangeEvent(
    OnLanguageChangeEvent event,
    Emitter<AppState> emitter,
  ) {}

  bool isDarkMode() => appTheme.brightness == AppTheme.dark.brightness;
}
