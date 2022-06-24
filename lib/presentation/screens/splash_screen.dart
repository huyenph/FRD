import 'package:flutter/material.dart';
import 'package:upm/presentation/base/base_ui.dart';
import 'package:upm/presentation/components/atoms/upm_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, '/auth'),
    );
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
