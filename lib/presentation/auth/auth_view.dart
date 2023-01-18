import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/errors/http_exception.dart';
import '../../core/router/app_router.dart';
import '../../core/styles/app_colors.dart';
import '../../core/widgets/custom_alert_dialog.dart';
import '../../core/widgets/custom_button_builder.dart';
import '../../core/widgets/custom_question_text_button.dart';
import '../../core/widgets/custom_text_builder.dart';
import '../../core/widgets/custom_text_form_field.dart';
import 'auth_viewmodel.dart';

class AuthView extends ConsumerStatefulWidget {
  const AuthView({
    super.key,
  });

  /// The default form type to use.
  @override
  ConsumerState<AuthView> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authNotifire = ref.watch(authViewmodel);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.grey,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: SafeArea(
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
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      hintText: 'Enter your email',
                      title: 'Email',
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextFormField(
                      keyboardType: TextInputType.text,
                      controller: _passwordController,
                      hintText: 'Enter your password ....',
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      title: 'Password',
                      validator: (value) {
                        if (value!.isEmpty || value.length <= 5) {
                          return 'Password length should be greater than 5';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    CustomButtonBuilder(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            authNotifire.isLogin
                                ? await authNotifire.login(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim(),
                                  )
                                : await authNotifire.signup(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim(),
                                  );
                            if (!mounted) return;
                            Navigator.pushReplacementNamed(
                              context,
                              AppRouterNames.homeRouteName,
                            );
                          } on HttpException catch (error) {
                            String errorMessage = _authError(error.toString());
                            _showErrorDialog(context, errorMessage);
                          } catch (error) {
                            const String errorMessage =
                                'Could not authenticate you. Please try again later.';
                            _showErrorDialog(context, errorMessage);
                          }
                        }
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
          ),
          if (authNotifire.isLoading)
            Container(
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

  Future<dynamic> _showErrorDialog(BuildContext context, String errorMessage) {
    return showDialog(
      context: context,
      builder: (ctx) => CustomAlertDialog(
        ctx: ctx,
        message: errorMessage,
      ),
    );
  }

  String _authError(String error) {
    if (error.toString().contains('EMAIL_EXISTS')) {
      return 'This email address is already in use.';
    } else if (error.toString().contains('INVALID_EMAIL')) {
      return 'This is not a valid email address';
    } else if (error.toString().contains('WEAK_PASSWORD')) {
      return 'This password is too weak.';
    } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
      return 'Could not find a user with that email.';
    } else if (error.toString().contains('INVALID_PASSWORD')) {
      return 'Invalid password.';
    } else {
      return 'Authentication failed';
    }
  }
}
