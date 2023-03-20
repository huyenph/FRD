import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hpcompose/blocs/app_bloc.dart';
import 'package:hpcompose/common/constants.dart';
import 'package:hpcompose/core/navigation/navigation_service.dart';
import 'package:hpcompose/data/datasource/local/boxes.dart';
import 'package:hpcompose/di/injector_setup.dart';
import 'package:hpcompose/domain/models/config_model.dart';
import 'package:hpcompose/generated/l10n.dart';
import 'package:hpcompose/presentation/base/base_ui.dart';
import 'package:hpcompose/presentation/components/option_field.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key, this.message}) : super(key: key);

  final RemoteMessage? message;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends BaseState<SettingScreen> {
  late RemoteNotification? notification;
  ConfigModel? _config;

  @override
  void initState() {
    super.initState();
    notification = widget.message?.notification;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Boxes.getConfig().values.isNotEmpty) {
      _config = Boxes.getConfig().values.last;
    }
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('settings ${notification?.title ?? 'no message'}'),
        OptionField(
          onTap: () => injector<NavigationService>().navigateTo('/language'),
          icon: Icons.language_outlined,
          label: S.of(context).language,
          value: _config != null ? _config!.language.name : '',
        ),
        OptionField(
          icon: Icons.nights_stay_outlined,
          label: S.of(context).darkMode,
          value: _config != null ? _config!.theme == darkTheme : false,
          onChanged: (value) {
            context.read<AppBloc>().add(
                  OnAppConfigEvent(
                    AppConfigType.theme,
                    theme: value ? darkTheme : lightTheme,
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
