import 'package:flutter/material.dart';

import '../../../auth/presentation/widgets/labels.dart';
import '../../../auth/presentation/widgets/logo.dart';
import '../../../terms_and_conditions/presentation/widgets/terms_and_conditions_button.dart';
import '../widgets/register_form.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

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
