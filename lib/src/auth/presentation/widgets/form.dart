import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/dialog_utils.dart';
import '../../../chat/presentation/providers/chat_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/auth_state.dart';
import 'rounded_button.dart';
import 'rounded_text_field.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

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
          DialogUtils.showAlert(
            context,
            title: 'Error T_T',
            message: next.message,
            buttonText: 'Ok',
            onPressed: () => Navigator.of(context).pop(),
          );
        }

        if (next is LoggedIn) {
          context.replace('/users');
          ref.read(chatProvider.notifier).connect();
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
