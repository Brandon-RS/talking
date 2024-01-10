import 'package:flutter/material.dart';

import '../../configs/colors/generic_colors.dart';

class SnackBarUtils {
  static bool _isSnackBarVisible = false;
  static void _showSnackBar(
    BuildContext context, {
    bool force = false,
    required Widget content,
    Color? backgroundColor,
    VoidCallback? onPressed,
  }) async {
    if (!force && _isSnackBarVisible) return;
    _isSnackBarVisible = true;
    await ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            action: onPressed != null
                ? SnackBarAction(
                    label: 'Ok',
                    onPressed: onPressed,
                  )
                : null,
            backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
            content: content,
          ),
        )
        .closed
        .then((_) => _isSnackBarVisible = false);
  }

  /// Shows a [SnackBar] with a simple [message]
  static void showSnackBar(
    BuildContext context, {
    bool force = false,
    required String message,
  }) {
    _showSnackBar(context, force: force, content: Text(message));
  }

  /// Shows a [SnackBar] with a simple [message] and a [TColors.red] background
  static void showErrorSnackBar(
    BuildContext context, {
    bool force = false,
    required String message,
  }) {
    _showSnackBar(
      context,
      backgroundColor: TColors.red,
      content: Text(message),
      force: force,
    );
  }

  /// Shows a [SnackBar] with a simple [message] and a [TColors.red] background an [onPressed] action
  static void showSnackBarWithAction(
    BuildContext context, {
    bool force = false,
    required String message,
    VoidCallback? onPressed,
  }) {
    _showSnackBar(
      context,
      content: Text(message),
      force: force,
      onPressed: onPressed,
    );
  }

  /// Shows a [SnackBar] with a simple [message] and an [onPressed] action
  static void showErrorSnackBarWithAction(
    BuildContext context, {
    bool force = false,
    required String message,
    VoidCallback? onPressed,
  }) {
    _showSnackBar(
      context,
      backgroundColor: TColors.red,
      content: Text(message),
      force: force,
      onPressed: onPressed,
    );
  }
}
