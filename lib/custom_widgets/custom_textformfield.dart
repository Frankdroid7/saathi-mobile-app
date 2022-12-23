import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final bool autoFocus;
  final String hintText;
  final bool isNumberField;
  final TextStyle? textStyle;
  final InputDecoration? inputDecoration;
  final TextEditingController controller;

  const CustomTextFormField(
      {Key? key,
      this.textStyle,
      this.autoFocus = false,
      this.inputDecoration,
      required this.controller,
      required this.hintText,
      this.isNumberField = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus,
      controller: controller,
      style: textStyle,
      keyboardType: isNumberField
          ? Platform.isIOS
              ? const TextInputType.numberWithOptions(decimal: true)
              : TextInputType.number
          : null,
      decoration: inputDecoration ??
          InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
      inputFormatters:
          isNumberField ? [FilteringTextInputFormatter.digitsOnly] : null,
    );
  }
}
