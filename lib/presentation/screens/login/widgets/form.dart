import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth/auth.provider.dart';
import '../widgets/login.widgets.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Form(
        child: Column(
          children: [
            RoundedTextField(
              icon: Icons.email_outlined,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
            ),
            const SizedBox(height: 22),
            RoundedTextField(
              icon: Icons.lock_outline,
              hintText: 'Password',
              obscureText: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 40),
            RoundedButton(
              text: 'Login',
              expandable: true,
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).login(
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
