import 'package:flutter/material.dart';
import 'package:talking/presentation/screens/login/widgets/login.widgets.dart';
import 'package:talking/presentation/screens/term_and_conditions/widgets/terms_and_conditions_widgets.dart';

import 'widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
              RegisterForm(),
              Labels(
                text: 'Already have an account?',
                buttonText: 'Start session now',
                route: '/login',
              ),
              TermsAndConditionsButton(),
            ],
          ),
        ),
      ),
    );
  }
}
