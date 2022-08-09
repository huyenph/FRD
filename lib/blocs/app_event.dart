part of app_bloc;

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class OnAppConfigEvent extends AppEvent {}

class OnThemeChangeEvent extends AppEvent {
  const OnThemeChangeEvent(this.theme);

  final String theme;

  @override
  List<Object?> get props => [theme];
}

class OnLanguageChangeEvent extends AppEvent {
  const OnLanguageChangeEvent(this.language);

  final String language;

  @override
  List<Object?> get props => [language];
}
