import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import 'custom_text_builder.dart';

class CustomButtonBuilder extends StatelessWidget {
  const CustomButtonBuilder({
    Key? key,
    required this.title,
    required this.onTap,
    this.textColor = AppColor.white,
    this.backgroundColor = AppColor.bBlue,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;
  final Color textColor;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Center(
          child: CustomText(
            title: title,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
