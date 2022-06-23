import 'package:flutter/material.dart';

class UpmTextField extends StatelessWidget {
  const UpmTextField({
    Key? key,
    required this.controller,
    this.onTap,
    this.hintText = '',
    this.labelText,
    this.isRequired = true,
    this.isReadOnly = false,
    this.maxLines = 1,
  }) : super(key: key);

  final TextEditingController controller;
  final GestureTapCallback? onTap;
  final String hintText;
  final String? labelText;
  final bool isRequired;
  final bool isReadOnly;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (labelText != null) ...[
          RichText(
            text: TextSpan(
              text: labelText,
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                if (isRequired) ...[
                  const TextSpan(
                    text: '(*)',
                    style: TextStyle(color: Colors.red),
                  ),
                ]
              ],
            ),
          ),
        ],
        TextFormField(
          key: key,
          onTap: onTap,
          controller: controller,
          maxLines: maxLines,
          readOnly: isReadOnly,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hintText,
            alignLabelWithHint: true,
            suffix: GestureDetector(
              onTap: () => controller.clear(),
              child: const Icon(
                Icons.cancel,
                color: Colors.grey,
                size: 20.0,
              ),
            ),
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
