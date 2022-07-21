import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upm/common/app_colors.dart';
import 'package:upm/common/app_size.dart';
import 'package:upm/core/services/firebases/firebase_fcm.dart';
import 'package:upm/di/injector_setup.dart';
import 'package:upm/modules/auth/blocs/authentication.dart';
import 'package:upm/modules/auth/domain/usecases/auth_usecase.dart';
import 'package:upm/modules/auth/screens/forms/signin_form.dart';
import 'package:upm/modules/auth/screens/forms/signup_form.dart';
import 'package:upm/presentation/base/base_ui.dart';
import 'package:upm/presentation/components/molecules/upm_app_bar.dart';

List<Widget> forms = [
  SigninForm(),
  SignupForm(),
];

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends BaseState<AuthScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  int _formIndex = 0;

  @override
  void initState() {
    super.initState();
    _initFirebaseFCM();
    _tabController = TabController(
      initialIndex: _formIndex,
      length: forms.length,
      vsync: this,
    );
  }

  void _initFirebaseFCM() {
    FirebaseFCM().registerNotification();
  }

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        padding: const EdgeInsets.symmetric(vertical: AppSize.fieldSpacingL),
        color: AppColors.backgroundLightColor,
        child: BlocProvider(
          create: (_) => AuthBloc(injector<AuthUseCase>()),
          child: TabBarView(
            controller: _tabController,
            children: forms,
          ),
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar() => UpmAppBar(
        title: '',
        backgroundColor: AppColors.backgroundLightColor,
        elevation: 0.0,
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(AppSize.fieldSpacingM),
              child: Icon(
                Icons.language_outlined,
                color: AppColors.primaryColor,
              ),
            ),
          )
        ],
      );
}
