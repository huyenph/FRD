import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:upm/common/app_colors.dart';
import 'package:upm/common/app_size.dart';
import 'package:upm/common/constants.dart';
import 'package:upm/generated/l10n.dart';
import 'package:upm/presentation/components/atoms/upm_button.dart';
import 'package:upm/presentation/components/atoms/upm_text.dart';
import 'package:upm/presentation/components/atoms/upm_text_field.dart';

class SignupForm extends StatelessWidget {
  SignupForm({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UpmText(
            text: S.of(context).signup,
            textColor: AppColors.colorWhite,
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
          const SizedBox(height: 20.0),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0,
              ),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    color: AppColors.backgroundBlurDark.withOpacity(0.5),
                    borderRadius:
                        BorderRadius.circular(AppSize.borderRadiusForm)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildTitleSection(context),
                    const SizedBox(height: AppSize.fieldSpacingM),
                    UpmTextField(
                      controller: _usernameController,
                      labelText: S.of(context).username,
                      hintText: usernameEg,
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
                    _buildPrivacySection(context),
                    const SizedBox(height: AppSize.fieldSpacingM),
                    UpmButton(
                      onPressed: () {},
                      label: S.of(context).agree_and_continue,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context) => RichText(
        text: TextSpan(
          text: S.of(context).signup_title,
          style: const TextStyle(color: AppColors.colorWhite, height: 1.6),
          children: const [
            TextSpan(
              text: ' example@gmail.com',
              style: TextStyle(
                color: AppColors.colorWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  Widget _buildPrivacySection(BuildContext context) => RichText(
        text: TextSpan(
          text: S.of(context).signup_policy,
          style: const TextStyle(color: AppColors.colorWhite),
          children: [
            TextSpan(
              text: '\n${S.of(context).i_agree_to}',
              style: const TextStyle(color: AppColors.colorWhite),
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: UpmText(
                    text: ' ${S.of(context).term_of_service_and_privacy}',
                    textColor: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
