import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upm/common/app_colors.dart';
import 'package:upm/common/app_size.dart';
import 'package:upm/generated/l10n.dart';
import 'package:upm/modules/auth/screens/forms/signin_form.dart';
import 'package:upm/modules/auth/screens/forms/signup_form.dart';
import 'package:upm/modules/auth/screens/forms/welcome_form.dart';
import 'package:upm/presentation/base/base_ui.dart';
import 'package:upm/presentation/components/atoms/upm_text.dart';

List<Widget> forms = [
  WelcomeForm(),
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
  final TextEditingController _emailController = TextEditingController();
  late TabController _tabController;

  int _formIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: _formIndex,
      length: forms.length,
      vsync: this,
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        color: AppColors.backgroundDark,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: AppSize.fieldSpacingXXL),
              child: _buildHeaderOptions(),
            ),
            const Expanded(child: SizedBox()),
            Expanded(
              flex: 5,
              child: TabBarView(
                controller: _tabController,
                children: forms,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar() => null;

  Widget _buildHeaderOptions() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.fieldSpacingM),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: const Icon(
                CupertinoIcons.back,
                color: AppColors.colorWhite,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.language_outlined,
                color: AppColors.colorWhite,
              ),
            ),
          ],
        ),
      );
}
