part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class OnAppConfigChangeRequested extends AppEvent {
  const OnAppConfigChangeRequested(this.type, {this.theme, this.language});

  final AppConfigType type;
  final String? theme;
  final LanguageEntity? language;

  @override
  List<Object?> get props => [type, theme, language];
}

class OnGetLanguageRequested extends AppEvent {}
