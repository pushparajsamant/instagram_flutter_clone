//
//  AHI
//
//  Copyright (c) AHI. All rights reserved.
//
import "package:flutter/material.dart";

class TextFieldInput extends StatelessWidget {
  const TextFieldInput(
      {Key? key,
      this.hintText,
      required this.controller,
      this.isPassword = false,
      required this.textInputType})
      : super(key: key);
  final String? hintText;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType textInputType;
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
    );
  }
}
