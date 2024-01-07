import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.expandable,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool? expandable;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        minimumSize: Size((expandable ?? false) ? double.infinity : 50, 50),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}
