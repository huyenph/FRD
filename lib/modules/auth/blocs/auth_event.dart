part of authentication;

enum SocialSignInEventOptions { google, facebook, apple }

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class OnSignInEvent extends AuthEvent {
  const OnSignInEvent();
}

class OnSocialSignInEvent extends AuthEvent {
  const OnSocialSignInEvent(this.options);

  final SocialSignInEventOptions options;

  @override
  List<Object?> get props => [options];
}

class OnTabChangeEvent extends AuthEvent {
  const OnTabChangeEvent(this.tabIndex);

  final int tabIndex;

  @override
  List<Object?> get props => [tabIndex];
}
