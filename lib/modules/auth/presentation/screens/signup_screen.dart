import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frd/core/styles/app_colors.dart';
import 'package:frd/core/styles/app_size.dart';
import 'package:frd/core/ui/base_widget_state.dart';
import 'package:frd/di/injector_setup.dart';
import 'package:frd/generated/l10n.dart';
import 'package:frd/modules/auth/blocs/authentication.dart';
import 'package:frd/modules/auth/domain/usecases/auth_usecase.dart';
import 'package:frd/presentation/components/frd_app_bar.dart';
import 'package:frd/presentation/components/frd_button.dart';
import 'package:frd/presentation/components/frd_text.dart';
import 'package:frd/presentation/components/frd_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends BaseWidgetState<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(injector<AuthUseCase>()),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            height: MediaQuery.sizeOf(context).height,
            alignment: AlignmentDirectional.bottomCenter,
            padding: const EdgeInsets.all(AppSize.edgeSpacing * 2),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FrdText(
                    S.of(context).welcomeTo,
                    color: AppColors.bgDarkColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                  const SizedBox(height: AppSize.edgeSpacing * 2),
                  FrdTextField(
                    controller: _usernameController,
                    hintText: S.of(context).username,
                    fillColor: AppColors.cardLightColor,
                    textInputType: TextInputType.name,
                    isVisibleSuffix: true,
                    isRequired: true,
                  ),
                  const SizedBox(height: AppSize.edgeSpacing),
                  FrdTextField(
                    controller: _emailController,
                    hintText: S.of(context).email,
                    fillColor: AppColors.cardLightColor,
                    textInputType: TextInputType.emailAddress,
                    isVisibleSuffix: true,
                    isRequired: true,
                  ),
                  const SizedBox(height: AppSize.edgeSpacing),
                  FrdTextField(
                    controller: _passwordController,
                    hintText: S.of(context).password,
                    fillColor: AppColors.cardLightColor,
                    textInputType: TextInputType.visiblePassword,
                    isVisiblePassword: true,
                    isVisibleSuffix: true,
                    isRequired: true,
                  ),
                  const SizedBox(height: AppSize.edgeSpacing),
                  FrdTextField(
                    controller: _confirmPassController,
                    hintText: S.of(context).confirmPassword,
                    fillColor: AppColors.cardLightColor,
                    textInputType: TextInputType.visiblePassword,
                    isVisiblePassword: true,
                    isVisibleSuffix: true,
                    isRequired: true,
                  ),
                  const SizedBox(height: AppSize.edgeSpacing),
                  GestureDetector(
                    onTap: (() {
                      print('pressed');
                    }),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSize.edgeSpacing / 2,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: FrdText(
                          S.of(context).forgotPassword,
                          color: AppColors.textColor.withOpacity(0.5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSize.edgeSpacing * 2),
                  FrdButton(
                    onPressed: () {},
                    labelColor: AppColors.bgLightColor,
                    label: S.of(context).register,
                    backgroundColor: Colors.red,
                  ),
                  const SizedBox(height: AppSize.edgeSpacing * 2),
                  RichText(
                    text: TextSpan(
                      text: S.of(context).aldreadyHaveAccount,
                      style: const TextStyle(
                        color: AppColors.dividerColor,
                        fontFamily: 'lexend',
                      ),
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: GestureDetector(
                            onTap: () => navService.goBack(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: FrdText(
                                ' ${S.of(context).login}',
                                color: AppColors.primaryTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar() => FrdAppBar(
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSize.edgeSpacing * 2,
              ),
              child: Icon(
                Icons.language_outlined,
                color: AppColors.textColor.withOpacity(0.5),
              ),
            ),
          )
        ],
      );
}
