import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frd/core/styles/app_colors.dart';

typedef OnSwitchChanged = Function(bool value);

class OptionField extends StatelessWidget {
  const OptionField({
    super.key,
    required this.label,
    this.value,
    this.icon,
    this.onChanged,
    this.onTap,
  });

  final String label;
  final dynamic value;
  final IconData? icon;
  final OnSwitchChanged? onChanged;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (onChanged == null && onTap != null) ? () => onTap!() : null,
      leading: icon != null ? Icon(icon, size: 30.0) : null,
      minLeadingWidth: 10,
      title: Text(label),
      trailing: _buildTrailing(),
    );
  }

  Widget _buildTrailing() {
    if (value is bool) {
      return CupertinoSwitch(
        activeTrackColor: AppColors.primaryColor,
        value: value,
        onChanged: onChanged,
      );
    } else if (value is String) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[Text(value), const Icon(CupertinoIcons.forward)],
      );
    }

    return const SizedBox.shrink();
  }
}
