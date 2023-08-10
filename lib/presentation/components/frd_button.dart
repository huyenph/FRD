import 'package:flutter/material.dart';
import 'package:frd/core/styles/app_colors.dart';
import 'package:frd/core/styles/app_size.dart';
import 'package:frd/presentation/components/frd_text.dart';

class FrdButton extends StatelessWidget {
  const FrdButton({
    Key? key,
    required this.onPressed,
    this.startIcon,
    this.endIcon,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.labelColor = AppColors.textColor,
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
          backgroundColor: MaterialStateProperty.all<Color>(
            backgroundColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: <Widget>[
            if (startIcon != null) ...[
              startIcon!,
              const SizedBox(width: AppSize.fieldSpacingS),
            ],
            if (label != null) ...[
              FrdText(
                label!,
                fontSize: labelSize ?? 16.0,
                color: labelColor,
                fontWeight: FontWeight.bold,
              ),
            ],
            if (endIcon != null) ...[
              const SizedBox(width: AppSize.fieldSpacingS),
              endIcon!
            ],
          ],
        ),
      ),
    );
  }
}
