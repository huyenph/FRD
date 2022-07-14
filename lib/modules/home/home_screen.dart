import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:upm/presentation/base/base_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.message}) : super(key: key);

  final RemoteMessage? message;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen> {
  late RemoteNotification? notification;

  @override
  void initState() {
    super.initState();
    notification = widget.message?.notification;
  }

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Text('home ${notification?.title ?? 'no message'}'),
    );
  }
}
