import 'package:flutter/material.dart';

import 'widgets/login.widgets.dart';
import '../term_and_conditions/widgets/terms_and_conditions_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
