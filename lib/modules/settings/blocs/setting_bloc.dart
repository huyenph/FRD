library;

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart' show rootBundle;

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(InititalState()) {
    on<OnGetLanguageEvent>(_onGetLanguageEvent);
  }

  void _onGetLanguageEvent(
    OnGetLanguageEvent event,
    Emitter<SettingState> emitter,
  ) async {
    final data = await rootBundle.loadString('assets/json/languages.json');
    final languages = jsonDecode(data);
    return emitter(OnGetLanguageState(languages));
  }
}
