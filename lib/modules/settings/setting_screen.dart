import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upm/blocs/app_bloc.dart';
import 'package:upm/common/constants.dart';
import 'package:upm/core/navigation/navigation_service.dart';
import 'package:upm/di/injector_setup.dart';
import 'package:upm/generated/l10n.dart';
import 'package:upm/presentation/base/base_ui.dart';
import 'package:upm/presentation/components/option_field.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key, this.message}) : super(key: key);

  final RemoteMessage? message;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends BaseState<SettingScreen> {
  late RemoteNotification? notification;
  // ThemeData _appTheme = AppTheme.light;

  @override
  void initState() {
    super.initState();
    notification = widget.message?.notification;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _appTheme = context.read<AppBloc>().appTheme;
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('settings ${notification?.title ?? 'no message'}'),
        OptionField(
          icon: Icons.language_outlined,
          label: S.of(context).language,
          value: context.read<AppBloc>().appLocale.toUpperCase(),
        ),
        OptionField(
          icon: Icons.nights_stay_outlined,
          label: S.of(context).darkMode,
          value: context.read<AppBloc>().isDarkMode(),
          onChanged: (value) {
            context.read<AppBloc>().add(
                  OnThemeChangeEvent(
                    context.read<AppBloc>().isDarkMode()
                        ? lightTheme
                        : darkTheme,
                  ),
                );
          },
        ),
        OptionField(
          onTap: () => injector<NavigationService>().removeUntil('/auth'),
          label: S.of(context).logout,
          icon: Icons.logout_outlined,
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget? buildAppBar() => null;
}
