import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upm/common/app_colors.dart';
import 'package:upm/common/app_size.dart';
import 'package:upm/core/navigation/navigation_service.dart';
import 'package:upm/di/injector_setup.dart';
import 'package:upm/generated/l10n.dart';
import 'package:upm/modules/auth/blocs/authentication.dart';
import 'package:upm/presentation/components/atoms/upm_button.dart';
import 'package:upm/presentation/components/atoms/upm_text.dart';
import 'package:upm/presentation/components/atoms/upm_text_field.dart';

const iconSize = 32.0;

class SigninForm extends StatelessWidget {
  SigninForm({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - kToolbarHeight,
            alignment: AlignmentDirectional.bottomCenter,
            margin:
                const EdgeInsets.symmetric(horizontal: AppSize.fieldSpacingL),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UpmText(
                  text: S.of(context).welcome_to,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
                const SizedBox(height: AppSize.fieldSpacingS),
                UpmText(
                  text: S.of(context).signin_title,
                  fontWeight: FontWeight.w300,
                  fontSize: 15.0,
                ),
                const SizedBox(height: AppSize.fieldSpacingXL),
                UpmTextField(
                  controller: _emailController,
                  labelText: S.of(context).email,
                  // hintText: emailEg,
                  isRequired: false,
                ),
                const SizedBox(height: AppSize.fieldSpacingS),
                UpmTextField(
                  controller: _passwordController,
                  labelText: S.of(context).password,
                  // hintText: passwordEg,
                  isRequired: true,
                ),
                const SizedBox(height: AppSize.fieldSpacingS),
                UpmButton(
                  onPressed: () {},
                  labelColor: AppColors.backgroundLightColor,
                  label: S.of(context).login,
                ),
                const SizedBox(height: AppSize.fieldSpacingM),
                GestureDetector(
                  onTap: (() {}),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: UpmText(
                        text: S.of(context).forgot_password,
                        textColor: AppColors.primaryTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.fieldSpacingL),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Expanded(
                      flex: 2,
                      child: Divider(color: AppColors.dividerColor),
                    ),
                    const SizedBox(width: AppSize.fieldSpacingM),
                    UpmText(text: S.of(context).or.toLowerCase()),
                    const SizedBox(width: AppSize.fieldSpacingM),
                    const Expanded(
                      flex: 2,
                      child: Divider(color: AppColors.dividerColor),
                    ),
                  ],
                ),
                const SizedBox(height: AppSize.fieldSpacingL),
                _buildSignInOptions(context),
                const SizedBox(height: AppSize.fieldSpacingXXL),
                _buildSignupSection(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSignInOptions(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              injector<NavigationService>().replaceTo('/home', arguments: null);
            },
            child: Image.asset(
              'assets/icons/ic_facebook.png',
              height: iconSize,
              width: iconSize,
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<AuthBloc>().add(
                    const OnSocialSignInEvent(SocialSignInEventOptions.google),
                  );
            },
            child: Image.asset(
              'assets/icons/ic_google.png',
              height: iconSize,
              width: iconSize,
            ),
          ),
          if (Platform.isIOS) ...[
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/icons/ic_apple.png',
                height: iconSize,
                width: iconSize,
              ),
            ),
          ],
        ],
      );

  Widget _buildSignupSection(BuildContext context) => Center(
        child: RichText(
          text: TextSpan(
            text: S.of(context).new_on_platform,
            style: const TextStyle(color: AppColors.textColor),
            children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: GestureDetector(
                  onTap: () {
                    context.read<AuthBloc>().add(const OnTabChangeEvent(1));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: UpmText(
                      text: ' ${S.of(context).register}',
                      textColor: AppColors.primaryTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
