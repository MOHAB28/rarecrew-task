import 'package:flutter/material.dart';

import '../../core/widgets/custom_button_builder.dart';
import '../../core/widgets/custom_question_text_button.dart';
import '../../core/widgets/custom_text_builder.dart';
import '../../core/widgets/custom_text_form_field.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                title: 'Login',
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 20.0),
              const CustomTextFormField(
                hintText: 'Enter your Username',
                title: 'Username',
              ),
              const SizedBox(height: 20.0),
              const CustomTextFormField(
                hintText: 'Enter your password ....',
                title: 'Password',
              ),
              const SizedBox(height: 20.0),
              CustomButtonBuilder(
                onTap: () {},
                title: 'Login',
              ),
              const SizedBox(height: 20.0),
              CustomQuestionTextButton(
                actionText: 'Register',
                onTap: (){},
                questionText: 'Don\'t have an account? ',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
