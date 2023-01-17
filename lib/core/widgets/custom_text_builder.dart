// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    required this.title,
    this.color = AppColor.black,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w400,
  }) : super(key: key);
  final String title;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: 'Lato',
        fontWeight: fontWeight,
      ),
    );
  }
}
