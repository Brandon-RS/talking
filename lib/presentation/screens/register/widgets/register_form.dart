import 'package:flutter/material.dart';
import 'package:talking/presentation/screens/login/widgets/login.widgets.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
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
              icon: Icons.perm_identity_outlined,
              hintText: 'Name',
              controller: _nameController,
            ),
            const SizedBox(height: 22),
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
              text: 'Register',
              expandable: true,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
