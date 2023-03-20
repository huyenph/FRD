import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hpcompose/presentation/base/base_ui.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key, this.message}) : super(key: key);

  final RemoteMessage? message;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends BaseState<TaskScreen> {
  late RemoteNotification? notification;

  @override
  void initState() {
    super.initState();
    notification = widget.message?.notification;
  }

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Text('task ${notification?.title ?? 'no message'}'),
    );
  }
}
