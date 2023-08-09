import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:frd/core/ui/base_widget_state.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key, this.message}) : super(key: key);

  final RemoteMessage? message;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends BaseWidgetState<TaskScreen> {
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
