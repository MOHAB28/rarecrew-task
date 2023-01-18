import 'package:flutter/material.dart';

import 'custom_text_builder.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.title,
    required this.hintText,
    this.initialValue,
    this.obscureText = false,
    this.maxLines,
    required this.keyboardType,
    this.onSaved,
    this.textInputAction = TextInputAction.next,
    this.controller,
    this.validator,
  }) : super(key: key);
  final String title;
  final String hintText;
  final String? initialValue;
  final bool obscureText;
  final int? maxLines;
  final TextInputType keyboardType;
  final void Function(String?)? onSaved;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(title: title),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          keyboardType: keyboardType,
          onSaved: onSaved,
          maxLines: maxLines,
          obscureText: obscureText,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            hintText: hintText,
          ),
          validator: validator,
        ),
      ],
    );
  }
}
