// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hi!`
  String get hi {
    return Intl.message(
      'Hi!',
      name: 'hi',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signin {
    return Intl.message(
      'Sign in',
      name: 'signin',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signup {
    return Intl.message(
      'Sign up',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get text_continue {
    return Intl.message(
      'Continue',
      name: 'text_continue',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Facebook`
  String get countinue_with_facebook {
    return Intl.message(
      'Continue with Facebook',
      name: 'countinue_with_facebook',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get countinue_with_google {
    return Intl.message(
      'Continue with Google',
      name: 'countinue_with_google',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Apple`
  String get countinue_with_apple {
    return Intl.message(
      'Continue with Apple',
      name: 'countinue_with_apple',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dont_have_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgot_password {
    return Intl.message(
      'Forgot your password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get or {
    return Intl.message(
      'Or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Looks like you don't have an account. Let's create a new account for`
  String get signup_title {
    return Intl.message(
      'Looks like you don\'t have an account. Let\'s create a new account for',
      name: 'signup_title',
      desc: '',
      args: [],
    );
  }

  /// `By selecting Agree and continue below,`
  String get signup_policy {
    return Intl.message(
      'By selecting Agree and continue below,',
      name: 'signup_policy',
      desc: '',
      args: [],
    );
  }

  /// `I agree to`
  String get i_agree_to {
    return Intl.message(
      'I agree to',
      name: 'i_agree_to',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service and Privacy Policy`
  String get term_of_service_and_privacy {
    return Intl.message(
      'Terms of Service and Privacy Policy',
      name: 'term_of_service_and_privacy',
      desc: '',
      args: [],
    );
  }

  /// `Agree and continue`
  String get agree_and_continue {
    return Intl.message(
      'Agree and continue',
      name: 'agree_and_continue',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
