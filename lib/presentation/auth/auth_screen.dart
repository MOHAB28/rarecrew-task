import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/custom_button_builder.dart';
import '../../core/widgets/custom_question_text_button.dart';
import '../../core/widgets/custom_text_builder.dart';
import '../../core/widgets/custom_text_form_field.dart';
import 'auth_viewmodel.dart';

class AuthScreen extends ConsumerWidget {
  AuthScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifire = ref.watch(authViewmodel);
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: authNotifire.isLogin ? 'Login' : 'Register',
                    fontSize: 32.0,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    controller: _emailController,
                    hintText: 'Enter your email',
                    title: 'Email',
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    controller: _passwordController,
                    hintText: 'Enter your password ....',
                    title: 'Password',
                  ),
                  const SizedBox(height: 20.0),
                  CustomButtonBuilder(
                    onTap: () {
                          print('object');
                            authNotifire.isLogin
                                ? authNotifire.login(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim(),
                                  )
                                : authNotifire.signup(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim(),
                                  );
                          },
                    title: authNotifire.isLogin ? 'Login' : 'Register',
                  ),
                  const SizedBox(height: 20.0),
                  CustomQuestionTextButton(
                    actionText: authNotifire.isLogin ? 'Register' : 'Login',
                    onTap: () => authNotifire.loginToggle(),
                    questionText: authNotifire.isLogin
                        ? 'Don\'t have an account? '
                        : 'You already have an account? ',
                  ),
                ],
              ),
            ),
          ),
          if (authNotifire.isLoading) Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black45,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
