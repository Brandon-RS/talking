import 'package:flutter/material.dart';

class DialogUtils {
  static void showAlert(
    BuildContext context, {
    required String title,
    required String message,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    final textTheme = Theme.of(context).textTheme;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: textTheme.titleMedium),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: onPressed,
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
