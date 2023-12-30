import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TermsAndConditionsButton extends StatelessWidget {
  const TermsAndConditionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextButton(
        child: Text(
          'Terms and conditions of use',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                decoration: TextDecoration.underline,
              ),
        ),
        onPressed: () => context.push('/terms-and-conditions'),
      ),
    );
  }
}
