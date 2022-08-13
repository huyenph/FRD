part of app_bloc;

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class OnAppConfigEvent extends AppEvent {
  const OnAppConfigEvent(this.type, {this.theme, this.language});

  final AppConfigType type;
  final String? theme;
  final LanguageModel? language;

  @override
  List<Object?> get props => [type, theme, language];
}

class OnGetLanguageEvent extends AppEvent {}
