import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../configs/di/injector.dart';
import '../../domain/usecases/login_usecase.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/login/login_bloc.dart';
import '../models/models.dart';
import 'rounded_button.dart';
import 'rounded_text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final ValueNotifier<bool> _showPassword = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: BlocProvider(
        create: (context) => LoginBloc(loginUsecase: sl<LoginUsecase>()),
        child: Form(
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              switch (state.status) {
                case FormzSubmissionStatus.success:
                  context.read<AuthBloc>().add(const AuthStatusChanged(AuthStatus.authenticated));
                  break;
                case FormzSubmissionStatus.failure:
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(state.error)));
                  break;
                default:
                  break;
              }
            },
            child: Column(
              children: [
                BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (prev, next) => prev.email != next.email,
                  builder: (context, state) => RoundedTextField(
                    suffixIcon: Icons.alternate_email,
                    hintText: 'Email',
                    labelText: state.email.displayError != null ? 'Invalid email' : 'Email',
                    inactiveBackgroundColor: colorScheme.outline.withOpacity(.2),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => context.read<LoginBloc>().add(LoginUsernameChanged(value)),
                  ),
                ),
                const SizedBox(height: 22),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) => ValueListenableBuilder(
                    valueListenable: _showPassword,
                    builder: (context, value, child) => RoundedTextField(
                      onSuffixIconPressed: () => _showPassword.value = !_showPassword.value,
                      suffixIcon: value ? Icons.visibility : Icons.visibility_off,
                      hintText: 'Password',
                      labelText: state.password.displayError != null ? 'Invalid password' : 'Password',
                      inactiveBackgroundColor: colorScheme.outline.withOpacity(.2),
                      iconsColor: colorScheme.primary,
                      obscureText: !value,
                      onChanged: (value) => context.read<LoginBloc>().add(LoginPasswordChanged(value)),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) => RoundedButton(
                    text: 'Login',
                    expandable: true,
                    onPressed: state.status != FormzSubmissionStatus.inProgress
                        ? () {
                            if (!state.isValid) {
                              String? message;

                              if (state.email.displayError != null) {
                                message = state.email.displayError!.text;
                              } else if (state.password.displayError != null) {
                                message = state.password.displayError!.text;
                              }

                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    content: Text(message ?? 'Please enter valid email and password'),
                                  ),
                                );

                              return;
                            }

                            context.read<LoginBloc>().add(const LoginSubmitted());
                          }
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
