import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          'Don\'t have an account?',
          style: theme.textTheme.bodyLarge,
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'Create an account',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
