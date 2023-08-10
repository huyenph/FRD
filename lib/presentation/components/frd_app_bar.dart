import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frd/core/navigation/navigation_service.dart';
import 'package:frd/core/styles/app_colors.dart';
import 'package:frd/di/injector_setup.dart';
import 'package:frd/presentation/components/frd_text.dart';

class FrdAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FrdAppBar({
    Key? key,
    this.title,
    this.leading,
    this.actions,
    this.centerTitle = false,
    this.backgroundColor,
    this.titleColor,
    this.elevation,
    this.onBack,
  }) : super(key: key);

  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? backgroundColor;
  final Color? titleColor;
  final double? elevation;
  final Function? onBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading ??
          IconButton(
              onPressed: () {
                if (onBack != null) {
                  onBack!();
                } else {
                  final navService = injector<NavigationService>();
                  if (navService.canBack()) {
                    navService.goBack();
                  }
                }
              },
              icon: const Icon(
                CupertinoIcons.back,
                color: AppColors.primaryColor,
              )),
      title: title != null
          ? FrdText(
              title!,
              fontWeight: FontWeight.bold,
            )
          : null,
      actions: actions,
      backgroundColor: backgroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
