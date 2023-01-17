import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class CustomQuestionTextButton extends StatelessWidget {
  const CustomQuestionTextButton({
    Key? key,
    required this.questionText,
    required this.actionText,
    required this.onTap,
  }) : super(key: key);
  final String questionText;
  final String actionText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          text: questionText,
          style: const TextStyle(
            fontSize: 12.0,
            color: AppColor.darkGrey,
          ),
          children: [
            TextSpan(
              text: actionText,
              style: const TextStyle(
                color: AppColor.bBlue,
                fontSize: 12.0,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  onTap();
                },
            ),
          ],
        ),
      ),
    );
  }
}
