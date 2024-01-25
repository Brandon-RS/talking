import 'package:flutter/material.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    const labelStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Talking App'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text(
              'Change your password',
              style: textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            const Text(
              'Make sure your new password it\'s at least 6 characters including letters, numbers and special characters.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Current password.',
              style: labelStyle,
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Current password',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'New Password',
              style: labelStyle,
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                hintText: 'New password',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Confirm New Password',
              style: labelStyle,
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Confirm new password',
              ),
            ),
            const SizedBox(height: 30),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_outline, color: colorScheme.background),
                  const SizedBox(width: 10),
                  Text(
                    'Change Password',
                    style: TextStyle(fontSize: 17, color: colorScheme.background),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
