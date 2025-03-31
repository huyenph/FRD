import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frd/blocs/app_bloc.dart';
import 'package:frd/core/constants.dart';
import 'package:frd/core/ui/base_widget_state.dart';
import 'package:frd/data/datasource/local/boxes.dart';
import 'package:frd/data/datasource/local/entities/config_entity.dart';
import 'package:frd/generated/l10n.dart';
import 'package:frd/presentation/components/option_field.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key, this.message});

  final RemoteMessage? message;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends BaseWidgetState<SettingScreen> {
  late RemoteNotification? notification;
  ConfigEntity? _config;

  @override
  void initState() {
    super.initState();
    notification = widget.message?.notification;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Boxes.getAppConfig().values.isNotEmpty) {
      _config = Boxes.getAppConfig().values.last;
    }
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('settings ${notification?.title ?? 'no message'}'),
        OptionField(
          onTap: () => navService.navigateTo('/language'),
          icon: Icons.language_outlined,
          label: S.of(context).language,
          value: _config != null ? _config!.language.title : '',
        ),
        OptionField(
          icon: Icons.nights_stay_outlined,
          label: S.of(context).darkMode,
          value: _config != null ? _config!.theme == darkTheme : false,
          onChanged: (value) {
            context.read<AppBloc>().add(
              OnAppConfigChangeRequested(
                AppConfigType.theme,
                theme: value ? darkTheme : lightTheme,
              ),
            );
          },
        ),
        OptionField(
          onTap: () => navService.removeAllUntil('/auth'),
          label: S.of(context).logout,
          icon: Icons.logout_outlined,
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget? buildAppBar() => null;
}
