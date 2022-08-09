import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upm/common/app_colors.dart';

typedef OnSwitchChanged = Function(bool value);

class UpmSwitch extends StatelessWidget {
  const UpmSwitch({
    Key? key,
    required this.label,
    required this.value,
    this.icon,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final bool value;
  final IconData? icon;
  final OnSwitchChanged onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null
          ? Icon(
              icon,
              // color: Theme.of(context).iconTheme.color,
              size: 30.0,
            )
          : null,
      minLeadingWidth: 10,
      title: Text(
        label,
        // style: TextStyle(
        //   color: value ? AppColors.textLightColor : AppColors.textColor,
        // ),
      ),
      trailing: CupertinoSwitch(
        activeColor: AppColors.primaryColor,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
