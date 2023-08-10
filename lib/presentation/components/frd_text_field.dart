import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frd/core/styles/app_colors.dart';
import 'package:frd/core/styles/app_size.dart';
import 'package:frd/generated/l10n.dart';

class FrdTextField extends StatefulWidget {
  const FrdTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.onTap,
    this.textInputType = TextInputType.text,
    this.suffixIcon,
    this.labelText,
    this.fillColor,
    this.isRequired = true,
    this.isReadOnly = false,
    this.isVisiblePassword = false,
    this.isVisibleSuffix = false,
    this.maxLines = 1,
  }) : super(key: key);

  final TextEditingController controller;
  final GestureTapCallback? onTap;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final String hintText;
  final String? labelText;
  final Color? fillColor;
  final bool isRequired;
  final bool isReadOnly;
  final bool isVisiblePassword;
  final bool isVisibleSuffix;
  final int maxLines;

  @override
  State<FrdTextField> createState() => _FrdTextFieldState();
}

class _FrdTextFieldState extends State<FrdTextField> {
  bool _isVisibleSuffix = false;
  bool _isVisiblePass = false;

  @override
  void initState() {
    super.initState();
    _isVisiblePass = widget.isVisiblePassword;
    widget.controller.addListener(_controllerListener);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          RichText(
            text: TextSpan(
              text: widget.labelText,
              style: const TextStyle(
                color: AppColors.textColor,
                fontFamily: 'lexend',
              ),
              children: <TextSpan>[
                if (widget.isRequired) ...[
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'lexend',
                    ),
                  ),
                ]
              ],
            ),
          ),
          const SizedBox(height: 2.0),
        ],
        TextFormField(
          key: widget.key,
          onTap: widget.onTap,
          controller: widget.controller,
          maxLines: widget.maxLines,
          readOnly: widget.isReadOnly,
          keyboardType: widget.textInputType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: const TextStyle(color: AppColors.textColor),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(AppSize.edgeSpacing),
            filled: true,
            fillColor: widget.fillColor,
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: AppColors.dividerColor),
            alignLabelWithHint: true,
            suffixIcon: widget.isVisibleSuffix
                ? GestureDetector(
                    onTap: _onSuffixPressed,
                    child: _renderSuffix(),
                  )
                : null,
          ),
          validator: (String? value) {
            return (widget.isRequired && (value == null || value.isEmpty))
                ? '${widget.hintText} ${S.of(context).isRequired}'
                : null;
          },
        ),
      ],
    );
  }

  Widget _renderSuffix() {
    if (widget.isVisiblePassword) {
      return Icon(
        _isVisiblePass
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined,
        color: Colors.grey,
        size: 20.0,
      );
    } else {
      return _isVisibleSuffix
          ? const Icon(
              CupertinoIcons.clear,
              color: Colors.grey,
              size: 20.0,
            )
          : widget.suffixIcon ?? const SizedBox();
    }
  }

  void _onSuffixPressed() {
    if (widget.isVisiblePassword) {
      setState(() {
        _isVisiblePass = !_isVisiblePass;
      });
    } else {
      widget.controller.clear();
    }
  }

  void _controllerListener() {
    if (mounted) {
      setState(() {
        _isVisibleSuffix = widget.controller.text.isNotEmpty;
      });
    }
  }
}
