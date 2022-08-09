part of app_bloc;

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object?> get props => [];
}

class OnInitialState extends AppState {}

class OnAppConfigState extends AppState {
  const OnAppConfigState(this.theme, this.language);

  final ThemeData theme;
  final String language;

  @override
  List<Object?> get props => [theme, language];
}

class OnThemeChangeState extends AppState {
  const OnThemeChangeState(this.theme);

  final ThemeData theme;

  @override
  List<Object?> get props => [theme];
}

class OnLanguageChangeState extends AppState {
  const OnLanguageChangeState(this.language);

  final String language;

  @override
  List<Object?> get props => [language];
}
