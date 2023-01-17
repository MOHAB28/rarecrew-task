import 'package:flutter/material.dart';

import 'custom_text_builder.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.title,
    required this.hintText,
    this.controller,
    this.validator,
  }) : super(key: key);
  final String title;
  final String hintText;
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
          decoration: InputDecoration(
            hintText: hintText,
          ),
          validator: validator,
        ),
      ],
    );
  }
}
