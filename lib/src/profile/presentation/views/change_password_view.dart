import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:talking/configs/di/injector.dart';
import 'package:talking/configs/router/app_router.dart';
import 'package:talking/core/common/dialog_utils.dart';
import 'package:talking/core/common/snack_bar_utils.dart';
import 'package:talking/src/auth/presentation/models/models.dart';
import 'package:talking/src/profile/presentation/blocs/change_password/change_password_bloc.dart';
import 'package:talking/src/user/domain/usecases/change_password_usecase.dart';

class ChangePasswordView extends ConsumerStatefulWidget {
  const ChangePasswordView({super.key});

  @override
  ConsumerState<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends ConsumerState<ChangePasswordView> {
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

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
        child: Form(
          key: _formKey,
          child: BlocProvider(
            create: (context) => ChangePasswordBloc(
              changePasswordUsecase: sl<ChangePasswordUsecase>(),
            ),
            child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
              listener: (context, state) {
                switch (state.status) {
                  case FormzSubmissionStatus.success:
                    DialogUtils.showAlert(
                      context,
                      title: 'Password Changed!',
                      message: 'Your password has been changed successfully.',
                      buttonText: 'OK',
                      onPressed: () => AppRouter.replaceAndRemoveUntil('/users'),
                    );
                    break;
                  case FormzSubmissionStatus.failure:
                    SnackBarUtils.showErrorSnackBar(
                      context,
                      message: state.error,
                    );
                    break;
                  default:
                    break;
                }
              },
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
                  BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                    buildWhen: (prev, next) => prev.currentPassword != next.currentPassword,
                    builder: (context, state) => TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Current password',
                        errorMaxLines: 2,
                      ),
                      validator: (value) => _passwordValidator(
                        value,
                        state.currentPassword.displayError?.text,
                      ),
                      onChanged: (value) => context.read<ChangePasswordBloc>().add(CurrentPasswordChanged(value)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'New password',
                    style: labelStyle,
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                    buildWhen: (prev, next) => prev.newPassword != next.newPassword,
                    builder: (context, state) => TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'New password',
                        errorMaxLines: 2,
                      ),
                      validator: (value) => _passwordValidator(
                        value,
                        state.newPassword.displayError?.text,
                      ),
                      onChanged: (value) => context.read<ChangePasswordBloc>().add(NewPasswordChanged(value)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Confirm new password',
                    style: labelStyle,
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                    buildWhen: (prev, next) => prev.verifyPassword != next.verifyPassword,
                    builder: (context, state) => TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        hintText: 'Confirm new password',
                        errorMaxLines: 2,
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? false) return 'Please enter a valid password.';

                        if (value != state.newPassword.value) return 'Passwords don\'t match.';

                        return null;
                      },
                      onChanged: (value) => context.read<ChangePasswordBloc>().add(VerifyPasswordChanged(value)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                    builder: (context, state) => FilledButton(
                      onPressed: !state.isLoading
                          ? () {
                              if (_formKey.currentState!.validate()) {
                                context.read<ChangePasswordBloc>().add(const ChangePasswordSubmitted());
                              }
                            }
                          : null,
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _passwordValidator(String? value, String? message) {
    if (value == null || value.isEmpty || value.length < 6) return message ?? 'Please enter a valid password.';
    return null;
  }
}
