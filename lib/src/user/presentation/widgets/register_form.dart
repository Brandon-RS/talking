import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/dialog_utils.dart';
import '../../../chat/presentation/providers/chat_provider.dart';
import '../providers/logged_user_provider.dart';
import '../providers/logged_user_state.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  final bool _acceptTerms = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
          title: 'Error',
          message: next.message,
          buttonText: 'Ok',
          onPressed: () => context.pop(),
        );
      }
    });

    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      // child: Form(
      //   child: Column(
      //     children: [
      //       RoundedTextField(
      //         icon: Icons.perm_identity_outlined,
      //         hintText: 'Name',
      //         controller: _nameController,
      //       ),
      //       const SizedBox(height: 22),
      //       RoundedTextField(
      //         icon: Icons.email_outlined,
      //         hintText: 'Email',
      //         keyboardType: TextInputType.emailAddress,
      //         controller: _emailController,
      //       ),
      //       const SizedBox(height: 22),
      //       RoundedTextField(
      //         icon: Icons.lock_outline,
      //         hintText: 'Password',
      //         obscureText: true,
      //         controller: _passwordController,
      //       ),
      //       const SizedBox(height: 22),
      //       CheckboxListTile(
      //         value: _acceptTerms,
      //         controlAffinity: ListTileControlAffinity.leading,
      //         title: const Text('I read and accept the terms and conditions'),
      //         onChanged: (value) => setState(() => _acceptTerms = value ?? false),
      //       ),
      //       const SizedBox(height: 40),
      //       RoundedButton(
      //         text: 'Register',
      //         expandable: true,
      //         onPressed: _acceptTerms && loggedUser is! LoggedUserLoading
      //             ? () => ref.read(loggedUserProvider.notifier).registerUser(
      //                   name: _nameController.text.trim(),
      //                   email: _emailController.text.trim(),
      //                   password: _passwordController.text.trim(),
      //                 )
      //             : null,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
