part of app_bloc;

enum AppConfigType { all, theme, locale }

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

class OnGetLanguageState extends AppState {
  const OnGetLanguageState(this.languages);

  final List<dynamic> languages;

  @override
  List<Object?> get props => [languages];
}

class OnAppConfigChangeState extends AppState {
  const OnAppConfigChangeState._({
    this.type = AppConfigType.all,
    this.configModel,
  });

  const OnAppConfigChangeState.all(ConfigModel configModel)
      : this._(
          type: AppConfigType.all,
          configModel: configModel,
        );

  const OnAppConfigChangeState.theme(ConfigModel configModel)
      : this._(
          type: AppConfigType.theme,
          configModel: configModel,
        );

  const OnAppConfigChangeState.locale(ConfigModel configModel)
      : this._(
          type: AppConfigType.locale,
          configModel: configModel,
        );

  final AppConfigType type;
  final ConfigModel? configModel;

  @override
  List<Object?> get props => [type, configModel];
}
