part of authentication;

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authUseCase) : super(const OnSocialSignInState.unknown()) {
    on<OnSocialSignInEvent>(_onSocialSignInEvent);
  }

  final AuthUseCase _authUseCase;

  @override
  Future<void> close() {
    return super.close();
  }

  void _onSocialSignInEvent(
    OnSocialSignInEvent event,
    Emitter<AuthState> emitter,
  ) async {
    switch (event.options) {
      case SocialSignInEventOptions.google:
        await _authUseCase.signInWithGoogle();
        // return emitter(OnSocialSignInState.authenticated());
        break;
      case SocialSignInEventOptions.facebook:
        await _authUseCase.signInWithFacebook();
        break;
      default:
        break;
    }
  }
}
