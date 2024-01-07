import 'package:flutter/material.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and conditions'),
      ),
      body: const Center(
        child: Text('TermsAndConditionsScreen'),
      ),
    );
  }
}
