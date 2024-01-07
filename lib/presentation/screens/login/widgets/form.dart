import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../providers/auth/auth_provider.dart';
import '../../../providers/auth/auth_state.dart';
import '../widgets/login.widgets.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    ref.listen<AuthState>(
      authProvider,
      (prev, next) {
        if (next is AuthError) {
          // TODO(BRANDOM): Create a custom snackbar widget (something like CoreUtils.showSnackBar)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.message),
              backgroundColor: Colors.red,
            ),
          );
        }

        if (next is LoggedIn) {
          context.replace('/users');
          // TODO(BRANDOM): Clear unnecessary data of provider
        }
      },
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Form(
        child: Column(
          children: [
            RoundedTextField(
              icon: Icons.email_outlined,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
            ),
            const SizedBox(height: 22),
            RoundedTextField(
              icon: Icons.lock_outline,
              hintText: 'Password',
              obscureText: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 40),
            RoundedButton(
              text: 'Login',
              expandable: true,
              onPressed: auth is! AuthLoading
                  ? () async {
                      final email = _emailController.text.trim();
                      final password = _passwordController.text.trim();

                      await ref.read(authProvider.notifier).login(
                            email: email,
                            password: password,
                          );
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
