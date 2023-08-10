import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frd/core/navigation/navigation_service.dart';
import 'package:frd/core/styles/app_colors.dart';
import 'package:frd/core/styles/app_size.dart';
import 'package:frd/di/injector_setup.dart';
import 'package:frd/generated/l10n.dart';
import 'package:frd/modules/auth/blocs/authentication.dart';
import 'package:frd/presentation/components/frd_button.dart';
import 'package:frd/presentation/components/frd_text.dart';
import 'package:frd/presentation/components/frd_text_field.dart';

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
            height: MediaQuery.sizeOf(context).height,
            // alignment: AlignmentDirectional.bottomCenter,
            padding:
                const EdgeInsets.symmetric(horizontal: AppSize.edgeSpacing),
            color: AppColors.cardDarkColor,
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
                  isRequired: true,
                ),
                const SizedBox(height: AppSize.edgeSpacing),
                FrdTextField(
                  controller: _passwordController,
                  hintText: S.of(context).password,
                  fillColor: AppColors.cardLightColor,
                  isRequired: true,
                ),
                const SizedBox(height: AppSize.fieldSpacingS),
                FrdButton(
                  onPressed: () {},
                  labelColor: AppColors.bgLightColor,
                  label: S.of(context).login,
                ),
                const SizedBox(height: AppSize.fieldSpacingM),
                GestureDetector(
                  onTap: (() {}),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        S.of(context).forgot_password,
                        style: const TextStyle(
                          color: AppColors.primaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
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
                    // Text(
                    //   S.of(context).or.toLowerCase(),
                    //   style: const TextStyle(
                    //     color: AppColors.textColor,
                    //   ),
                    // ),
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
                    child: Text(
                      ' ${S.of(context).register}',
                      style: const TextStyle(
                        color: AppColors.primaryTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
