import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:upm/common/app_colors.dart';
import 'package:upm/common/app_size.dart';
import 'package:upm/common/constants.dart';
import 'package:upm/generated/l10n.dart';
import 'package:upm/presentation/components/atoms/upm_button.dart';
import 'package:upm/presentation/components/atoms/upm_text.dart';
import 'package:upm/presentation/components/atoms/upm_text_field.dart';

const iconSize = 20.0;

class WelcomeForm extends StatelessWidget {
  WelcomeForm({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UpmText(
            text: S.of(context).hi,
            textColor: AppColors.colorWhite,
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
          const SizedBox(height: AppSize.fieldSpacingL),
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
                    UpmTextField(
                      controller: _emailController,
                      labelText: S.of(context).email,
                      hintText: emailEg,
                      isRequired: false,
                    ),
                    const SizedBox(height: AppSize.fieldSpacingS),
                    UpmButton(
                      onPressed: () {},
                      label: S.of(context).text_continue,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSize.fieldSpacingM,
                      ),
                      child: Center(
                        child: UpmText(
                          text: S.of(context).or.toLowerCase(),
                          textColor: AppColors.colorWhite,
                        ),
                      ),
                    ),
                    ..._buildSignInOptions(context),
                    const SizedBox(height: AppSize.fieldSpacingM),
                    ..._buildSignupSection(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSignInOptions(BuildContext context) => [
        UpmButton(
          onPressed: () {},
          label: S.of(context).countinue_with_facebook,
          labelColor: AppColors.backgroundDark,
          backgroundColor: AppColors.primaryLightColor,
          startIcon: Image.asset(
            'assets/icons/ic_facebook.png',
            height: iconSize,
            width: iconSize,
          ),
          endIcon: const SizedBox(width: iconSize),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        const SizedBox(height: AppSize.fieldSpacingS),
        UpmButton(
          onPressed: () {},
          label: S.of(context).countinue_with_google,
          labelColor: AppColors.backgroundDark,
          backgroundColor: AppColors.primaryLightColor,
          startIcon: Image.asset(
            'assets/icons/ic_google.png',
            height: 22.0,
            width: 22.0,
          ),
          endIcon: const SizedBox(width: 22.0),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        if (Platform.isIOS) ...[
          const SizedBox(height: AppSize.fieldSpacingS),
          UpmButton(
            onPressed: () {},
            label: S.of(context).countinue_with_apple,
            labelColor: AppColors.backgroundDark,
            backgroundColor: AppColors.primaryLightColor,
            startIcon: Image.asset(
              'assets/icons/ic_apple.png',
              height: 22.0,
              width: 22.0,
            ),
            endIcon: const SizedBox(width: 22.0),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ],
      ];

  List<Widget> _buildSignupSection(BuildContext context) => [
        RichText(
          text: TextSpan(
            text: S.of(context).dont_have_account,
            style: const TextStyle(color: AppColors.colorWhite),
            children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: UpmText(
                      text: ' ${S.of(context).signup}',
                      textColor: AppColors.primaryColor,
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
              textColor: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ];
}
