import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frd/core/services/firebase/firebase_fcm.dart';
import 'package:frd/core/styles/app_colors.dart';
import 'package:frd/core/styles/app_size.dart';
import 'package:frd/core/ui/base_widget_state.dart';
import 'package:frd/di/injector_setup.dart';
import 'package:frd/modules/auth/blocs/authentication.dart';
import 'package:frd/modules/auth/domain/usecases/auth_usecase.dart';
import 'package:frd/modules/auth/screens/forms/signin_form.dart';
import 'package:frd/modules/auth/screens/forms/signup_form.dart';

List<Widget> forms = [
  SigninForm(),
  SignupForm(),
];

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends BaseWidgetState<AuthScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _initFirebaseFCM();
    _tabController = TabController(
      initialIndex: 0,
      length: forms.length,
      vsync: this,
    );
  }

  void _initFirebaseFCM() {
    // FirebaseFCM().registerNotification();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding:
                const EdgeInsets.symmetric(vertical: AppSize.fieldSpacingL),
            color: AppColors.backgroundLightColor,
            child: BlocProvider(
              create: (_) => AuthBloc(injector<AuthUseCase>()),
              child: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is OnTabChangedState) {
                    _tabController.animateTo(state.tabIndex);
                  }
                },
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: forms,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: kToolbarHeight,
          right: kToolbarHeight / 2,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.language_outlined,
              color: AppColors.primaryColor,
            ),
          ),
        )
      ],
    );
  }

  @override
  PreferredSizeWidget? buildAppBar() => null;
}
