import 'package:flutter/material.dart';
import 'package:hpcompose/common/app_colors.dart';

class FrdText extends StatelessWidget {
  const FrdText({
    Key? key,
    required this.text,
    this.textColor = AppColors.textColor,
    this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.start,
    this.isAllCaps = false,
  }) : super(key: key);

  final String text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final bool isAllCaps;

  @override
  Widget build(BuildContext context) {
    return Text(
      isAllCaps ? text.toUpperCase() : text,
      style: TextStyle(
        // color: textColor ??
        //     (context.read<AppBloc>().isDarkMode()
        //         ? AppColors.textLightColor
        //         : AppColors.textColor),
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }
}
