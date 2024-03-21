import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configs/di/injector.dart';
import '../../domain/usecases/login_usecase.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_status.dart';
import '../blocs/login/login_bloc.dart';
import '../blocs/login/login_status.dart';
import 'rounded_button.dart';
import 'rounded_text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: BlocProvider(
        create: (context) => LoginBloc(loginUsecase: sl<LoginUsecase>()),
        child: Form(
          key: _formKey,
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              switch (state.status) {
                case LoginStatus.success:
                  context.read<AuthBloc>().add(const AuthStatusChanged(AuthStatus.authenticated));
                  break;
                case LoginStatus.error:
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(content: Text('Authentication Failure')),
                    );
                  break;
                case LoginStatus.loading:
                  break;
                case LoginStatus.initial:
                  break;
              }
            },
            child: Column(
              children: [
                BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (prev, next) => prev.username != next.username,
                  builder: (context, state) {
                    return RoundedTextField(
                      suffixIcon: Icons.alternate_email,
                      hintText: 'Email',
                      labelText: 'Email',
                      inactiveBackgroundColor: colorScheme.outline.withOpacity(.2),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      onChanged: (value) => context.read<LoginBloc>().add(LoginUsernameChanged(value)),
                    );
                  },
                ),
                const SizedBox(height: 22),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return ValueListenableBuilder(
                      valueListenable: _showPassword,
                      builder: (context, value, child) => RoundedTextField(
                        onSuffixIconPressed: () => _showPassword.value = !_showPassword.value,
                        suffixIcon: value ? Icons.visibility : Icons.visibility_off,
                        hintText: 'Password',
                        labelText: 'Password',
                        inactiveBackgroundColor: colorScheme.outline.withOpacity(.2),
                        iconsColor: colorScheme.primary,
                        obscureText: !value,
                        controller: _passwordController,
                        onChanged: (value) => context.read<LoginBloc>().add(LoginPasswordChanged(value)),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return RoundedButton(
                      text: 'Login',
                      expandable: true,
                      onPressed: state.isValid && state.status != LoginStatus.loading
                          ? () => context.read<LoginBloc>().add(const LoginSubmitted())
                          : null,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
