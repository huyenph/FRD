import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upm/common/app_colors.dart';
import 'package:upm/common/app_size.dart';
import 'package:upm/common/constants.dart';
import 'package:upm/generated/l10n.dart';
import 'package:upm/modules/auth/blocs/authentication.dart';
import 'package:upm/presentation/components/atoms/upm_button.dart';
import 'package:upm/presentation/components/atoms/upm_text.dart';
import 'package:upm/presentation/components/atoms/upm_text_field.dart';

const iconSize = 20.0;

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
            margin:
                const EdgeInsets.symmetric(horizontal: AppSize.fieldSpacingL),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  hintText: emailEg,
                  isRequired: false,
                ),
                const SizedBox(height: AppSize.fieldSpacingS),
                UpmTextField(
                  controller: _passwordController,
                  labelText: S.of(context).password,
                  hintText: passwordEg,
                  isRequired: false,
                ),
                const SizedBox(height: AppSize.fieldSpacingS),
                UpmButton(
                  onPressed: () {},
                  labelColor: AppColors.backgroundLightColor,
                  label: S.of(context).login,
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
                ..._buildSignInOptions(context),
                const SizedBox(height: AppSize.fieldSpacingL),
                ..._buildSignupSection(context),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildSignInOptions(BuildContext context) => [
        UpmButton(
          onPressed: () {
            context.read<AuthBloc>().add(
                  const OnSocialSignInEvent(SocialSignInEventOptions.facebook),
                );
          },
          label: S.of(context).continue_with_facebook,
          backgroundColor: AppColors.cardLightColor,
          startIcon: Image.asset(
            'assets/icons/ic_facebook.png',
            height: iconSize,
            width: iconSize,
          ),
        ),
        const SizedBox(height: AppSize.fieldSpacingS),
        UpmButton(
          onPressed: () {
            context.read<AuthBloc>().add(
                  const OnSocialSignInEvent(SocialSignInEventOptions.google),
                );
          },
          label: S.of(context).continue_with_google,
          backgroundColor: AppColors.cardLightColor,
          startIcon: Image.asset(
            'assets/icons/ic_google.png',
            height: 22.0,
            width: 22.0,
          ),
        ),
        if (Platform.isIOS) ...[
          const SizedBox(height: AppSize.fieldSpacingS),
          UpmButton(
            onPressed: () {},
            label: S.of(context).continue_with_apple,
            backgroundColor: AppColors.cardLightColor,
            startIcon: Image.asset(
              'assets/icons/ic_apple.png',
              height: 22.0,
              width: 22.0,
            ),
          ),
        ],
      ];

  List<Widget> _buildSignupSection(BuildContext context) => [
        RichText(
          text: TextSpan(
            text: S.of(context).new_on_platform,
            style: const TextStyle(color: AppColors.textColor),
            children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: GestureDetector(
                  onTap: () {},
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
        const SizedBox(height: AppSize.fieldSpacingS),
        GestureDetector(
          onTap: (() {}),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: UpmText(
              text: S.of(context).forgot_password,
              textColor: AppColors.primaryTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ];
}
