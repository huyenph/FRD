import 'package:flutter/material.dart';
import 'package:upm/common/app_colors.dart';
import 'package:upm/common/app_size.dart';

class FrdTextField extends StatelessWidget {
  const FrdTextField({
    Key? key,
    required this.controller,
    this.onTap,
    this.textInputType = TextInputType.text,
    this.hintText = '',
    this.labelText,
    this.fillColor,
    this.isRequired = true,
    this.isReadOnly = false,
    this.maxLines = 1,
  }) : super(key: key);

  final TextEditingController controller;
  final GestureTapCallback? onTap;
  final TextInputType textInputType;
  final String hintText;
  final String? labelText;
  final Color? fillColor;
  final bool isRequired;
  final bool isReadOnly;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          RichText(
            text: TextSpan(
              text: labelText,
              style: const TextStyle(color: AppColors.textColor),
              children: <TextSpan>[
                if (isRequired) ...[
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
                ]
              ],
            ),
          ),
          const SizedBox(height: 2.0),
        ],
        TextFormField(
          key: key,
          onTap: onTap,
          controller: controller,
          maxLines: maxLines,
          readOnly: isReadOnly,
          keyboardType: textInputType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          // style: const TextStyle(color: AppColors.textColor),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(AppSize.borderRadiusField),
            filled: true,
            fillColor: fillColor,
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColors.dividerColor),
            alignLabelWithHint: true,

            // suffix: GestureDetector(
            //   onTap: () => controller.clear(),
            //   child: const Icon(
            //     Icons.cancel,
            //     color: Colors.grey,
            //     size: 20.0,
            //   ),
            // ),
          ),
          validator: (String? value) {
            return (isRequired && (value == null || value.isEmpty))
                ? '${labelText ?? 'This field'} is required'
                : null;
          },
        ),
      ],
    );
  }
}
