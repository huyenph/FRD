import 'package:flutter/material.dart';
import 'package:upm/presentation/components/atoms/upm_text.dart';

class UpmAppBar extends StatelessWidget with PreferredSizeWidget {
  const UpmAppBar({
    Key? key,
    required this.title,
    this.leading,
    this.actions,
    this.centerTitle = false,
    this.backgroundColor,
    this.elevation,
  }) : super(key: key);

  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? backgroundColor;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: UpmText(text: title),
      actions: actions,
      backgroundColor: backgroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
