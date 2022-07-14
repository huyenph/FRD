import 'dart:io';

import 'package:flutter/material.dart';
import 'package:upm/common/app_colors.dart';
import 'package:upm/common/app_size.dart';
import 'package:upm/common/constants.dart';
import 'package:upm/generated/l10n.dart';
import 'package:upm/presentation/components/atoms/upm_button.dart';
import 'package:upm/presentation/components/atoms/upm_text.dart';
import 'package:upm/presentation/components/atoms/upm_text_field.dart';

const iconSize = 20.0;

class SignupForm extends StatelessWidget {
  SignupForm({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppSize.fieldSpacingL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UpmText(
              text: S.of(context).adventure_start_here,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
            const SizedBox(height: AppSize.fieldSpacingS),
            UpmText(
              text: S.of(context).register_title,
              fontWeight: FontWeight.w300,
              fontSize: 15.0,
            ),
            const SizedBox(height: AppSize.fieldSpacingXL),
            UpmTextField(
              controller: _usernameController,
              labelText: S.of(context).username,
              hintText: usernameEg,
              isRequired: false,
            ),
            const SizedBox(height: AppSize.fieldSpacingS),
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
            RichText(
              text: TextSpan(
                text: S.of(context).i_agree_to,
                style: const TextStyle(color: AppColors.textColor),
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: UpmText(
                          text: ' ${S.of(context).privacy_policy}',
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
            UpmButton(
              onPressed: () {},
              labelColor: AppColors.backgroundLightColor,
              label: S.of(context).register,
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
            RichText(
              text: TextSpan(
                text: S.of(context).aldready_have_account,
                style: const TextStyle(color: AppColors.textColor),
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: UpmText(
                          text: ' ${S.of(context).login_instead}',
                          textColor: AppColors.primaryTextColor,
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
  }

  List<Widget> _buildSignInOptions(BuildContext context) => [
        UpmButton(
          onPressed: () {},
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
          onPressed: () {},
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
}
