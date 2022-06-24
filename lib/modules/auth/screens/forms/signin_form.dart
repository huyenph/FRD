import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:upm/common/app_colors.dart';
import 'package:upm/common/app_size.dart';
import 'package:upm/common/constants.dart';
import 'package:upm/generated/l10n.dart';
import 'package:upm/presentation/components/atoms/upm_button.dart';
import 'package:upm/presentation/components/atoms/upm_text.dart';
import 'package:upm/presentation/components/atoms/upm_text_field.dart';

class SigninForm extends StatelessWidget {
  SigninForm({Key? key}) : super(key: key);

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
            text: S.of(context).signin,
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
                    _buildProfileSection(),
                    const SizedBox(height: AppSize.fieldSpacingM),
                    UpmTextField(
                      controller: _passwordController,
                      labelText: S.of(context).password,
                      hintText: passwordEg,
                      isRequired: false,
                    ),
                    const SizedBox(height: AppSize.fieldSpacingS),
                    UpmButton(
                      onPressed: () {},
                      label: S.of(context).text_continue,
                    ),
                    const SizedBox(height: AppSize.fieldSpacingM),
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() => Row(
        children: <Widget>[
          const CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            child: Center(
              child: UpmText(
                text: 'U',
                textColor: AppColors.colorWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: AppSize.fieldSpacingS),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              UpmText(
                text: 'Username',
                textColor: AppColors.colorWhite,
                fontWeight: FontWeight.bold,
              ),
              UpmText(
                text: 'username@gmail.com',
                textColor: AppColors.colorWhite,
              ),
            ],
          ),
        ],
      );
}
