import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/custom_text_form_field.dart';
import '../../auth/viewmodel/auth_viewmodel.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      ref.watch(authViewmodel).getEmailData().then((_) {
        _emailController.text = ref.watch(authViewmodel).model!.email!;
        _nameController.text = ref.watch(authViewmodel).model!.name!;
        _phoneController.text = ref.watch(authViewmodel).model!.phone!;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ref.watch(authViewmodel).isProfileLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      controller: _nameController,
                      hintText: 'Enter your name',
                      title: 'Name',
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextFormField(
                      readOnly: true,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      hintText: 'Enter your email',
                      title: 'Email',
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextFormField(
                      readOnly: true,
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      hintText: 'Enter your phone',
                      title: 'Phone',
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
