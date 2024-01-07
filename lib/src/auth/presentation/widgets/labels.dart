import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Labels extends StatelessWidget {
  const Labels({
    super.key,
    required this.text,
    required this.buttonText,
    required this.route,
  });

  final String text;
  final String buttonText;
  final String route;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          text,
          style: theme.textTheme.bodyLarge,
        ),
        TextButton(
          onPressed: () {
            context.replace(route);
          },
          child: Text(
            buttonText,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
