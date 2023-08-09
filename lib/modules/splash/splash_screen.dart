import 'package:flutter/material.dart';
import 'package:frd/core/ui/base_widget_state.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseWidgetState<SplashScreen> {
  @override
  void initState() {
    _requestPermission();
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, '/auth'),
    );
  }

  _requestPermission() async {
    await Permission.notification.request();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset(
          'assets/images/flutter_bird.png',
          height: 120.0,
          width: 120.0,
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar() => null;
}
