import 'package:flutter/material.dart';
import 'package:upm/presentation/components/atoms/upm_text.dart';

class UpmButton extends StatelessWidget {
  const UpmButton({
    Key? key,
    required this.onPressed,
    this.startIcon,
    this.endIcon,
    this.startIconColor,
    this.endIconColor,
    this.labelColor,
    this.padding = const EdgeInsets.all(8.0),
    this.label,
    this.startIconSize,
    this.endIconSize,
    this.labelSize,
    this.isAllCaps = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData? startIcon;
  final IconData? endIcon;
  final Color? startIconColor;
  final Color? endIconColor;
  final Color? labelColor;
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
        style: TextButton.styleFrom(padding: padding),
        child: Row(
          children: <Widget>[
            if (startIcon != null) ...[
              Icon(
                startIcon,
                color: startIconColor,
                size: startIconSize,
              ),
            ],
            if (label != null) ...[
              UpmText(
                text: label!,
                fontSize: labelSize,
                textColor: labelColor,
                isAllCaps: isAllCaps,
              ),
            ],
            if (endIcon != null) ...[
              Icon(
                endIcon,
                color: endIconColor,
                size: endIconSize,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
