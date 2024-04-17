import 'package:flutter/material.dart';
import 'package:talking/src/auth/presentation/widgets/labels.dart';
import 'package:talking/src/auth/presentation/widgets/login_form.dart';
import 'package:talking/src/auth/presentation/widgets/logo.dart';
import 'package:talking/src/terms_and_conditions/presentation/widgets/terms_and_conditions_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Logo(),
              LoginForm(),
              Labels(
                text: 'Don\'t have an account?',
                buttonText: 'Create an account',
                route: '/register',
              ),
              TermsAndConditionsButton(),
            ],
          ),
        ),
      ),
    );
  }
}
