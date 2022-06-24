import 'package:flutter/material.dart';
import 'package:upm/common/app_colors.dart';
import 'package:upm/common/app_size.dart';
import 'package:upm/presentation/components/atoms/upm_text.dart';

class UpmButton extends StatelessWidget {
  const UpmButton({
    Key? key,
    required this.onPressed,
    this.startIcon,
    this.endIcon,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.labelColor,
    this.backgroundColor = AppColors.primaryColor,
    this.padding = const EdgeInsets.all(8.0),
    this.label,
    this.startIconSize,
    this.endIconSize,
    this.labelSize,
    this.isAllCaps = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget? startIcon;
  final Widget? endIcon;
  final MainAxisAlignment mainAxisAlignment;
  final Color? labelColor;
  final Color backgroundColor;
  final EdgeInsets padding;
  final String? label;
  final double? startIconSize;
  final double? endIconSize;
  final double? labelSize;
  final bool isAllCaps;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.borderRadiusField),
              side: BorderSide.none,
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.all(15.0),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            backgroundColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: <Widget>[
            if (startIcon != null) ...[startIcon!],
            if (label != null) ...[
              UpmText(
                text: label!,
                fontSize: labelSize,
                textColor: labelColor,
                isAllCaps: isAllCaps,
                fontWeight: FontWeight.bold,
              ),
            ],
            if (endIcon != null) ...[endIcon!],
          ],
        ),
      ),
    );
  }
}
