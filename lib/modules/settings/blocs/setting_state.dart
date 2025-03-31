part of 'setting_bloc.dart';

abstract class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object?> get props => [];
}

class InititalState extends SettingState {}

class OnGetLanguageState extends SettingState {
  const OnGetLanguageState(this.languages);

  final List<dynamic> languages;

  @override
  List<Object?> get props => [languages];
}
