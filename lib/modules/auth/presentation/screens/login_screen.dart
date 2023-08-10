import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frd/core/constants.dart';
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseWidgetState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                    S.of(context).welcome_to,
                    color: AppColors.bgDarkColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                  const SizedBox(height: AppSize.edgeSpacing * 2),
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
                  GestureDetector(
                    onTap: (() {}),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: FrdText(
                          S.of(context).forgot_password,
                          color: AppColors.primaryTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSize.edgeSpacing * 2),
                  FrdButton(
                    onPressed: () {},
                    labelColor: AppColors.bgLightColor,
                    label: S.of(context).login,
                  ),
                  const SizedBox(height: AppSize.edgeSpacing * 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: _renderDivider(
                          Alignment.centerRight,
                          Alignment.centerLeft,
                        ),
                      ),
                      const SizedBox(width: AppSize.edgeSpacing),
                      Text(
                        S.of(context).orContinueWith,
                        style: const TextStyle(
                          color: AppColors.dividerColor,
                        ),
                      ),
                      const SizedBox(width: AppSize.edgeSpacing),
                      Expanded(
                        flex: 2,
                        child: _renderDivider(
                          Alignment.centerLeft,
                          Alignment.centerRight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.edgeSpacing * 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: _renderSocialLoginItem(
                          'assets/icons/ic_google.png',
                          () {},
                        ),
                      ),
                      const SizedBox(width: AppSize.edgeSpacing * 1.5),
                      if (Platform.isIOS) ...[
                        Expanded(
                          child: _renderSocialLoginItem(
                            'assets/icons/ic_apple.png',
                            () {},
                          ),
                        ),
                        const SizedBox(width: AppSize.edgeSpacing * 1.5),
                      ],
                      Expanded(
                        child: _renderSocialLoginItem(
                          'assets/icons/ic_facebook.png',
                          () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.edgeSpacing * 2),
                  RichText(
                    text: TextSpan(
                      text: S.of(context).new_on_platform,
                      style: const TextStyle(
                        color: AppColors.dividerColor,
                        fontFamily: 'lexend',
                      ),
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: GestureDetector(
                            onTap: () => navService.navigateTo(signupRoute),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: FrdText(
                                ' ${S.of(context).register}',
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
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.edgeSpacing * 2,
              ),
              child: Icon(
                Icons.language_outlined,
                color: AppColors.primaryColor,
              ),
            ),
          )
        ],
      );

  Widget _renderDivider(Alignment begin, Alignment end) => Container(
        height: 2.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            colors: const [
              AppColors.dividerColor,
              AppColors.bgLightColor,
            ],
          ),
        ),
      );

  Widget _renderSocialLoginItem(String iconAsset, Function() onTap) =>
      Container(
        padding: const EdgeInsets.all(AppSize.edgeSpacing),
        decoration: BoxDecoration(
          color: AppColors.bgLightColor,
          border: Border.all(
            color: AppColors.cardLightColor,
            width: 2.0,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(AppSize.borderRadiusField),
          ),
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Image.asset(
            iconAsset,
            height: 32.0,
            width: 32.0,
          ),
        ),
      );
}
