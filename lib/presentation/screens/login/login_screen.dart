import 'package:flutter/material.dart';

import 'widgets/login.widgets.dart';
import '../term_and_conditions/widgets/terms_and_conditions_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Logo(),
              LoginForm(),
              Labels(),
              TermsAndConditionsButton(),
            ],
          ),
        ),
      ),
    );
  }
}
