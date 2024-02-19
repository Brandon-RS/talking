import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/dialog_utils.dart';
import '../../../chat/presentation/providers/chat_provider.dart';
import '../../../user/presentation/providers/logged_user_provider.dart';
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
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  final ValueNotifier<bool> _showPassword = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
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

    final colorScheme = Theme.of(context).colorScheme;

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
          ref.read(loggedUserProvider.notifier).init(
                token: next.token,
                user: next.user,
              );
          ref.read(chatProvider.notifier).connect();
          context.replace('/users');
        }
      },
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            RoundedTextField(
              suffixIcon: Icons.alternate_email,
              hintText: 'Email',
              labelText: 'Email',
              inactiveBackgroundColor: colorScheme.outline.withOpacity(.2),
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
            ),
            const SizedBox(height: 22),
            ValueListenableBuilder(
              valueListenable: _showPassword,
              builder: (context, value, child) => RoundedTextField(
                onSuffixIconPressed: () => _showPassword.value = !_showPassword.value,
                suffixIcon: value ? Icons.visibility : Icons.visibility_off,
                hintText: 'Password',
                labelText: 'Password',
                inactiveBackgroundColor: colorScheme.outline.withOpacity(.2),
                iconsColor: colorScheme.primary,
                obscureText: value,
                controller: _passwordController,
              ),
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
