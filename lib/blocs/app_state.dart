part of 'app_bloc.dart';

enum AppConfigType { all, theme, locale }

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object?> get props => [];
}

class OnInitialState extends AppState {}

class OnGetLanguageState extends AppState {
  const OnGetLanguageState(this.languages);

  final List<dynamic> languages;

  @override
  List<Object?> get props => [languages];
}

class OnAppConfigChangeState extends AppState {
  const OnAppConfigChangeState._({this.type = AppConfigType.all});

  const OnAppConfigChangeState.all() : this._(type: AppConfigType.all);

  const OnAppConfigChangeState.theme() : this._(type: AppConfigType.theme);

  const OnAppConfigChangeState.locale() : this._(type: AppConfigType.locale);

  final AppConfigType type;

  @override
  List<Object?> get props => [type];
}
