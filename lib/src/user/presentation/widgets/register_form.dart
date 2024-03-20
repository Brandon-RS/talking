import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/dialog_utils.dart';
import '../../../auth/presentation/widgets/rounded_button.dart';
import '../../../auth/presentation/widgets/rounded_text_field.dart';
import '../../../chat/presentation/providers/chat_provider.dart';
import '../providers/logged_user_provider.dart';
import '../providers/logged_user_state.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _name = ValueNotifier('');
  final _email = ValueNotifier('');
  final _password = ValueNotifier(('', false));
  final _acceptTerms = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final loggedUser = ref.watch(loggedUserProvider);

    ref.listen(loggedUserProvider, (prev, next) {
      if (next is LoggedUserLoaded) {
        context.pushReplacement('/users');
        ref.read(chatProvider.notifier).connect();
      }

      if (next is LoggedUserError) {
        DialogUtils.showAlert(
          context,
          title: 'Something when wrong!',
          message: next.message,
          buttonText: 'Ok',
          onPressed: () => context.pop(),
        );
      }
    });

    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: _name,
            builder: (context, value, child) => RoundedTextField(
              prefixIcon: Icons.perm_identity_outlined,
              hintText: 'Name',
              labelText: 'Name',
              inactiveBackgroundColor: colorScheme.outline.withOpacity(.2),
              onChanged: (value) => _name.value = value,
            ),
          ),
          const SizedBox(height: 22),
          ValueListenableBuilder(
            valueListenable: _email,
            builder: (context, value, child) => RoundedTextField(
              prefixIcon: Icons.email_outlined,
              hintText: 'Email',
              labelText: 'Email',
              inactiveBackgroundColor: colorScheme.outline.withOpacity(.2),
              keyboardType: TextInputType.emailAddress,
              onChanged: (email) => _email.value = email,
            ),
          ),
          const SizedBox(height: 22),
          ValueListenableBuilder(
            valueListenable: _password,
            builder: (context, passRecord, child) {
              final (value, showPassword) = passRecord;

              return RoundedTextField(
                prefixIcon: Icons.lock_outline,
                onSuffixIconPressed: () => _password.value = (value, !showPassword),
                suffixIcon: showPassword ? Icons.visibility : Icons.visibility_off,
                hintText: 'Password',
                labelText: 'Password',
                inactiveBackgroundColor: colorScheme.outline.withOpacity(.2),
                obscureText: !showPassword,
                onChanged: (pass) => _password.value = (pass, showPassword),
              );
            },
          ),
          const SizedBox(height: 22),
          ValueListenableBuilder(
            valueListenable: _acceptTerms,
            builder: (context, accepted, child) => CheckboxListTile(
              value: accepted,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('I read and accept the terms and conditions'),
              onChanged: (value) => _acceptTerms.value = value ?? false,
            ),
          ),
          const SizedBox(height: 40),
          ValueListenableBuilder(
            valueListenable: _acceptTerms,
            builder: (context, value, child) => RoundedButton(
              text: 'Register',
              expandable: true,
              onPressed: _acceptTerms.value && loggedUser is! LoggedUserLoading
                  ? () => ref.read(loggedUserProvider.notifier).registerUser(
                        name: _name.value.trim(),
                        email: _email.value.trim(),
                        password: _password.value.$1.trim(),
                      )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
