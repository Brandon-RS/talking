import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangePasswordView extends ConsumerStatefulWidget {
  const ChangePasswordView({super.key});

  @override
  ConsumerState<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends ConsumerState<ChangePasswordView> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmNewPasswordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    const labelStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Talking App'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(
                'Change your password',
                style: textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              const Text(
                'Make sure your new password it\'s at least 6 characters including letters, numbers and special characters.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Current password.',
                style: labelStyle,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _currentPasswordController,
                decoration: const InputDecoration(
                  hintText: 'Current password',
                ),
                validator: _passwordValidator,
              ),
              const SizedBox(height: 20),
              const Text(
                'New Password',
                style: labelStyle,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _newPasswordController,
                decoration: const InputDecoration(
                  hintText: 'New password',
                ),
                validator: _passwordValidator,
              ),
              const SizedBox(height: 20),
              const Text(
                'Confirm New Password',
                style: labelStyle,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _confirmNewPasswordController,
                decoration: const InputDecoration(
                  hintText: 'Confirm new password',
                ),
                validator: _passwordValidator,
              ),
              const SizedBox(height: 30),
              FilledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_outline, color: colorScheme.background),
                    const SizedBox(width: 10),
                    Text(
                      'Change Password',
                      style: TextStyle(fontSize: 17, color: colorScheme.background),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _passwordValidator(value) {
    if (value == null || value.isEmpty || value.length < 6) return 'Please enter a valid password.';
    return null;
  }
}
