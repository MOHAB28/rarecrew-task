// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'custom_text_builder.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.title,
    required this.hintText,
    this.obscureText = false,
    required this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.controller,
    this.validator,
  }) : super(key: key);
  final String title;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
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
          keyboardType: keyboardType,
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
