part of authentication;

enum SocialSignInStatus { unknown, unauthenticated, authenticated }

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInititalState extends AuthState {
  const AuthInititalState();
}

class OnSocialSignInState extends AuthState {
  const OnSocialSignInState._({
    this.status = SocialSignInStatus.unknown,
    this.userCredential,
  });

  const OnSocialSignInState.unknown() : this._();

  const OnSocialSignInState.unauthenticated()
      : this._(
          status: SocialSignInStatus.unauthenticated,
        );

  const OnSocialSignInState.authenticated(UserCredential userCredential)
      : this._(
          status: SocialSignInStatus.authenticated,
          userCredential: userCredential,
        );

  final SocialSignInStatus status;
  final UserCredential? userCredential;

  @override
  List<Object?> get props => [status, userCredential];
}

class OnTabChangedState extends AuthState {
  const OnTabChangedState(this.tabIndex);

  final int tabIndex;

  @override
  List<Object?> get props => [tabIndex];
}
