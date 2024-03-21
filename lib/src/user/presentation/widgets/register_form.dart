import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../configs/di/injector.dart';
import '../../../../core/common/dialog_utils.dart';
import '../../../auth/presentation/widgets/rounded_button.dart';
import '../../../auth/presentation/widgets/rounded_text_field.dart';
import '../../domain/usecases/register_user_usecase.dart';
import '../blocs/register/register_bloc.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _showPassword = ValueNotifier(false);
  final _acceptTerms = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: BlocProvider(
        create: (context) => RegisterBloc(registerUserUsecase: sl<RegisterUserUsecase>()),
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            switch (state.status) {
              case RegisterStatus.success:
                context.pushReplacement('/users');
                break;
              case RegisterStatus.failure:
                DialogUtils.showAlert(
                  context,
                  title: 'Something when wrong!',
                  message: state.error,
                  buttonText: 'Ok',
                  onPressed: () => context.pop(),
                );
                break;
              default:
                break;
            }
          },
          child: Column(
            children: [
              BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) => RoundedTextField(
                  prefixIcon: Icons.perm_identity_outlined,
                  hintText: 'Name',
                  labelText: 'Name',
                  inactiveBackgroundColor: colorScheme.outline.withOpacity(.2),
                  onChanged: (value) => context.read<RegisterBloc>().add(RegisterNameChanged(value)),
                ),
              ),
              const SizedBox(height: 22),
              BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) => RoundedTextField(
                  prefixIcon: Icons.email_outlined,
                  hintText: 'Email',
                  labelText: 'Email',
                  inactiveBackgroundColor: colorScheme.outline.withOpacity(.2),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (email) => context.read<RegisterBloc>().add(RegisterEmailChanged(email)),
                ),
              ),
              const SizedBox(height: 22),
              BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) => ValueListenableBuilder(
                  valueListenable: _showPassword,
                  builder: (context, value, child) => RoundedTextField(
                    prefixIcon: Icons.lock_outline,
                    onSuffixIconPressed: () => _showPassword.value = !value,
                    suffixIcon: value ? Icons.visibility : Icons.visibility_off,
                    hintText: 'Password',
                    labelText: 'Password',
                    inactiveBackgroundColor: colorScheme.outline.withOpacity(.2),
                    obscureText: !value,
                    onChanged: (pass) => context.read<RegisterBloc>().add(RegisterPasswordChanged(pass)),
                  ),
                ),
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
              BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) => ValueListenableBuilder(
                  valueListenable: _acceptTerms,
                  builder: (context, value, child) => RoundedButton(
                    text: 'Register',
                    expandable: true,
                    onPressed: value && state.isValid && state.status != RegisterStatus.submitting
                        ? () {
                            context.read<RegisterBloc>().add(const RegisterSubmitted());
                          }
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
