import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:upm/presentation/base/base_ui.dart';
import 'package:upm/presentation/components/upm_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> {
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
      child: const Center(
        child: UpmText(
          text: 'UPM',
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar() => null;
}
