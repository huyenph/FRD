import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:upm/presentation/base/base_ui.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key, this.message}) : super(key: key);

  final RemoteMessage? message;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends BaseState<SettingScreen> {
  late RemoteNotification? notification;

  @override
  void initState() {
    super.initState();
    notification = widget.message?.notification;
  }

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Text('settings ${notification?.title ?? 'no message'}'),
    );
  }
}
